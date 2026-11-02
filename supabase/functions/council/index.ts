// AI Council and Knowledge Hub tutor.
//
// The app calls this function (never Claude directly) so the Anthropic API
// key stays in Supabase secrets. The function only gives advice: it never
// awards points or changes budgets (docs/architecture.md, trust boundaries).
//
// Deploy:   supabase functions deploy council
// Secret:   supabase secrets set ANTHROPIC_API_KEY=sk-ant-...

import Anthropic from "npm:@anthropic-ai/sdk@1.3.0";
import { createClient } from "npm:@supabase/supabase-js@2.118.0";

const MODEL = "claude-haiku-5-5";

const anthropic = new Anthropic(); // reads ANTHROPIC_API_KEY

const ADVISORS: Record<string, string> = {
  rebel:
    "The Rebel: you challenge excuses, complacency and self-defeating habits. " +
    "Blunt, energetic, a little provocative, never cruel.",
  strategist:
    "The Strategist: you analyse systems, plans, risk and long-term decisions. " +
    "Calm, structured, thinks in trade-offs and second-order effects.",
  boss:
    "The Boss: you focus on leadership, responsibility and keeping one's word. " +
    "Direct, decisive, holds people to their commitments with respect.",
  philosopher:
    "The Philosopher: you explore wisdom, ethics, purpose and perspective. " +
    "Reflective, asks good questions, draws on broad philosophical traditions.",
  psychologist:
    "The Psychologist: you help the user understand behaviour, emotions and " +
    "patterns. Warm, curious, evidence-informed. You are not a therapist and " +
    "suggest professional help when someone may need it.",
  financialMentor:
    "The Financial Mentor: you teach budgeting, saving, investing " +
    "fundamentals and financial responsibility. Practical, cautious about " +
    "risk, never gives individual investment recommendations.",
  commander:
    "The Commander: you give firm accountability and practical guidance " +
    "during difficult periods. Short sentences, clear next actions, steady.",
  negotiator:
    "The Negotiator: you specialise in persuasion, negotiation, sales, " +
    "confidence and communication. Tactical, empathetic, scenario-driven.",
};

const STRICTNESS: Record<number, string> = {
  1: "Coaching style: supportive. Lead with encouragement.",
  2: "Coaching style: balanced. Encourage, but name problems plainly.",
  3: "Coaching style: direct. Be frank and challenge the user firmly, never humiliating.",
};

// Stable shared instructions first, so the prefix can be cached.
const BASE = `You are part of the AI Council in Ascension, a personal-growth app that combines habits, financial discipline, long-term visions, learning and coaching.
Core philosophy: the user chooses who they want to become; the app helps them get there.

Rules:
- You are an original character archetype. Do not imitate or quote any real person or fictional character.
- Give advice and suggestions only. You cannot award or remove XP, points or rewards, or change budgets; the app's own rules do that. If asked, say so.
- Suggested changes (new habits, harder targets, budget tweaks) are proposals for the user to accept in the app.
- Respect user autonomy. Accountability without humiliation: be honest about setbacks and always offer a recovery path.
- Finance data you see is status only (no amounts). Never ask the user to share account numbers or passwords.
- For medical, legal, mental-health crises or major financial decisions, recommend a qualified professional.
- Keep replies short and conversational: usually 2 to 5 sentences, or a short list when steps help. Plain text, no headings.`;

const TUTOR = `You are the tutor in Ascension's Knowledge Hub. You help the user learn from what they are reading.
- explain: explain the passage simply, with one concrete example.
- summarize: summarise the key ideas in 3 to 6 bullet points.
- quiz: write 3 short questions that test understanding, then the answers under "Answers:".
Plain text. Be accurate; if the passage is unclear, say what you're unsure about.`;

type Turn = { role: "user" | "assistant"; content: string };

interface CouncilRequest {
  mode?: "council" | "tutor";
  advisors?: string[];
  strictness?: number;
  history?: Turn[];
  message: string;
  context?: string;
  task?: "explain" | "summarize" | "quiz";
}

const cors = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

function json(body: unknown, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...cors, "Content-Type": "application/json" },
  });
}

function textOf(message: Anthropic.Message): string {
  if (message.stop_reason === "refusal") {
    return "I can't help with that one. Let's come back to your goals. What would you like to work on?";
  }
  return message.content
    .filter((b): b is Anthropic.TextBlock => b.type === "text")
    .map((b) => b.text)
    .join("\n")
    .trim();
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: cors });

  // Only signed-in users of this project may call the function.
  const admin = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
  );
  const token = (req.headers.get("Authorization") ?? "").replace(/^Bearer /, "");
  const { data: auth } = await admin.auth.getUser(token);
  if (!auth.user) return json({ error: "Sign in to use the AI Council." }, 401);

  let body: CouncilRequest;
  try {
    body = await req.json();
  } catch {
    return json({ error: "Invalid request" }, 400);
  }
  const message = (body.message ?? "").slice(0, 8000).trim();
  if (!message) return json({ error: "Empty message" }, 400);

  const history = (body.history ?? [])
    .slice(-20)
    .filter((t) => (t.role === "user" || t.role === "assistant") && t.content)
    .map((t): Anthropic.MessageParam => ({ role: t.role, content: t.content.slice(0, 4000) }));
  // The conversation must start with a user turn.
  while (history.length && history[0].role !== "user") history.shift();

  const userTurn: Anthropic.MessageParam = {
    role: "user",
    content: body.context
      ? `[App context, for your reference]\n${body.context.slice(0, 4000)}\n\n[User]\n${message}`
      : message,
  };

  const calls: { advisor: string; system: Anthropic.TextBlockParam[] }[] =
    body.mode === "tutor"
      ? [{
        advisor: "tutor",
        system: [{ type: "text", text: TUTOR }, {
          type: "text",
          text: `Task: ${body.task ?? "explain"}`,
        }],
      }]
      : (body.advisors ?? ["strategist"])
        .filter((a) => a in ADVISORS)
        .slice(0, 4)
        .map((advisor) => ({
          advisor,
          system: [
            { type: "text", text: BASE, cache_control: { type: "ephemeral" } },
            {
              type: "text",
              text: `${ADVISORS[advisor]}\n${STRICTNESS[body.strictness ?? 2] ?? STRICTNESS[2]}` +
                ((body.advisors?.length ?? 1) > 1
                  ? "\nYou are speaking in the Council Chamber alongside other advisors: give your distinct perspective in 2 to 4 sentences."
                  : ""),
            },
          ],
        }));
  if (calls.length === 0) return json({ error: "Unknown advisor" }, 400);

  try {
    const results = await Promise.all(calls.map(async (call) => {
      const response = await anthropic.messages.create({
        model: MODEL,
        max_tokens: 4000,
        output_config: { effort: "low" },
        system: call.system,
        messages: [...history, userTurn],
      });
      return { advisor: call.advisor, response };
    }));

    // Usage log, so per-user costs can be estimated from real data.
    await admin.from("council_usage").insert(results.map(({ advisor, response }) => ({
      user_id: auth.user!.id,
      advisor,
      model: response.model,
      input_tokens: response.usage.input_tokens,
      output_tokens: response.usage.output_tokens,
      cache_read_tokens: response.usage.cache_read_input_tokens ?? 0,
      cache_write_tokens: response.usage.cache_creation_input_tokens ?? 0,
    })));

    return json({
      replies: results.map(({ advisor, response }) => ({
        advisor,
        text: textOf(response),
      })),
    });
  } catch (error) {
    if (error instanceof Anthropic.RateLimitError) {
      return json({ error: "The Council is busy. Try again in a minute." }, 429);
    }
    if (error instanceof Anthropic.AuthenticationError) {
      console.error("Anthropic key missing or invalid");
      return json({ error: "The Council isn't configured yet." }, 503);
    }
    if (error instanceof Anthropic.APIError) {
      console.error(`Anthropic API error ${error.status}: ${error.message}`);
      return json({ error: "The Council couldn't answer right now." }, 502);
    }
    console.error(error);
    return json({ error: "Unexpected error" }, 500);
  }
});
