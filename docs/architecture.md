# Architecture

## Stack

| Concern | Choice |
| --- | --- |
| App | Flutter (Android first; iOS and web also build) |
| On-device database | SQLite via `drift` (offline-first) |
| Backend | Supabase: Postgres (sync), Auth, Edge Functions |
| AI | Claude Haiku 5.5 via the `council` Edge Function |
| Encryption | `cryptography` (AES-256-GCM, Argon2id); keys in `flutter_secure_storage` |
| Reader | `pdfx` (PDF), `epubx` (EPUB), `file_picker` (import) |
| State | Riverpod (`flutter_riverpod`) |
| Navigation | `go_router`: onboarding redirect plus a five-tab `StatefulShellRoute` |
| Testing | `flutter_test` with in-memory SQLite |

All dependencies are open source under permissive licences (MIT, BSD or Apache 2.0).

## Folder layout

```
lib/
  main.dart                 Entry point: Supabase bootstrap, ProviderScope
  app/                      App widget (day close + sync on start/resume), router, nav shell, theme
  core/
    clock.dart              "Now", overridable in tests
    config/                 Compile-time env (Supabase URL and key)
    database/               Drift tables, database, id helpers
    supabase/               Supabase initialization
    time/                   Calendar-day helpers
    widgets/                Shared UI building blocks
  features/
    onboarding/             First-run flow
    home/                   Command Center dashboard
    missions/               Habits, completions, excuses, recovery challenges
    finance/                Budgets, expenses, savings, weekly fun budget
    visions/                Visions, milestones, VP
    knowledge/              Library, PDF/EPUB reader, annotations, AI tutor
    council/                Advisors, offline daily insight, AI chat and Chamber
    progression/            Scoring rules, reward ledger, growth service and state
    profile/                Profile, stats, settings, history
    sync/                   Sign-in, sync engine, finance encryption
supabase/
  migrations/               SQL schema and row-level security
  functions/council/        AI Council and tutor (calls Claude)
docs/                       Blueprint, specs, setup, roadmap
test/                       Unit, database and widget tests
```

Each feature has up to three layers:

- `domain/`: plain Dart models and rules, with no Flutter, database or network imports. **Every scoring rule lives here** (see [scoring-spec.md](scoring-spec.md)), and each one is unit-tested.
- `data/`: repositories over the drift database, plus services and derived state (Riverpod providers).
- `presentation/`: screens and widgets.

A `domain/` layer never imports `data/` or `presentation/`. Features may use each other's `domain/` and `data/` layers, for example the growth service reads habits, visions and finance. Shared screen pieces like `MissionTile` and `VisionTile` are reused across tabs.

## How a day works

1. Ticking a mission calls `GrowthService.completeMission`. It records the completion, computes XP with the spec's formula, and appends a `Reward` to the ledger with a plain-language explanation.
2. On app start and resume, `closePastDays` settles every day that has ended: miss penalties, the daily budget outcome, perfect weeks, recovery challenges and evolution DP. Every award has a unique key, so running it twice changes nothing.
3. Screens read `growthStateProvider`, which derives level, Momentum, Discipline, today's missions and identity progress from the database. Nothing is cached that could drift out of date.

## Trust boundaries

The blueprint requires that **rewards and deductions come from trusted application logic, never from the AI**:

1. All awards and penalties are computed by the rule code in `progression/domain` and applied only by `GrowthService`. The AI Council has no path to change points, budgets or goals. Its suggestions are text the user can choose to act on.
2. Because the app is offline-first, these rules run on the device. A user who tampers with their own phone could inflate only their own score. This is the same reasoning that removed the Integrity Score: self-reported progress can't be proven, so the app doesn't pretend to verify it.
3. The reward ledger is append-only. VP and completed visions are never revoked. The one exception: XP for a mission un-ticked on the same day.
4. Finance data is end-to-end encrypted before it syncs. The server and the AI see only status (for example "on track"), never amounts.
5. The Anthropic API key lives only in Supabase function secrets. The function checks the caller is signed in and logs token usage per user.

## Configuration

Secrets are passed with `--dart-define-from-file=env.json` (see `env.example.json` and [setup.md](setup.md)). Without them the app runs fully offline.
