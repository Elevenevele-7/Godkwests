# Learning & Build Plan

Assumes you are **new to programming**, study about **2 hours on weekdays and 3–4 hours on one weekend day**, and build together with Claude: Claude writes the harder code, you read it, change it and understand it. More hours or prior experience shorten the timeline. Fewer hours lengthen it.

## How long will it take?

| Milestone | What you have | Estimate |
| --- | --- | --- |
| **MVP** | Habits & missions, budget & savings, visions, XP and scores, a real home screen, accounts. Running on your own phone. | **~4 months** (weeks 1–16) |
| **Full blueprint** | MVP + Knowledge Hub (PDF/EPUB reader) + AI Council | **~6 months** (weeks 17–24) |
| **Public release** | Security review, testing with real users, Play Store / App Store | **~7 months** (weeks 25–28) |

Ship the MVP first and use it yourself every day. Real use will show you what to fix before you build the reader and the AI.

## The daily routine (~2 hours)

| Time | Activity |
| --- | --- |
| 20 min | **Learn:** the concept for today (docs, a short video, or ask Claude to explain it) |
| 60 min | **Build:** today's task. Type the code yourself when it's small. When Claude writes it, read every line. |
| 20 min | **Review:** run the app, change one thing on purpose, see what happens, undo it |
| 10 min | **Commit:** save your work in Git with a message saying what you did |
| 10 min | **Log:** write 3 lines in `docs/journal.md`: what I did, what confused me, what's next |

**Weekend session (3–4 h):** finish the week's task, re-read the week's code, and write down your questions for Claude.

**Rule:** don't move to the next week until that week's "Done when" passes. Being late is fine; skipping is not.

## Free learning resources

- Dart language: https://dart.dev/language
- Flutter first app codelab: https://docs.flutter.dev/get-started/codelab
- Flutter widgets catalog: https://docs.flutter.dev/ui/widgets
- Riverpod: https://riverpod.dev
- Supabase + Flutter: https://supabase.com/docs/guides/getting-started/quickstarts/flutter
- SQL basics: https://www.postgresql.org/docs/current/tutorial.html
- Git: https://git-scm.com/book/en/v2 (chapters 1–3)

---

## Phase A: Foundations of programming (weeks 1–4)

### Week 1: Set up your computer and run the app

| Day | Learn | Do |
| --- | --- | --- |
| 1 | What Flutter, Dart and Git are | Install VS Code, Git and Flutter (docs.flutter.dev/get-started/install). Run `flutter doctor`. |
| 2 | What cloning a repo means | Clone this repo. Run `flutter pub get` and `flutter run` (Chrome or an Android emulator). |
| 3 | Dart: variables, types, strings | In DartPad (dartpad.dev), write a program that prints your savings goal and how much is left. |
| 4 | Dart: `if`, loops, lists | In DartPad, make a list of 5 habits and print only the completed ones. |
| 5 | Dart: functions | Write `int xpFor(int difficulty)` returning 1–5. Test it with different values. |
| 6 (weekend) | Git: commit, push, branches | Change the greeting text in `home_screen.dart`, run it, commit and push. |

**Done when:** the app runs on your machine and you pushed your own commit.

### Week 2: Dart for real apps

| Day | Learn | Do |
| --- | --- | --- |
| 1 | Classes and objects | Write a `Habit` class (name, difficulty, completed) in DartPad. |
| 2 | Enums | Read `lib/features/council/domain/advisor.dart`. Add a temporary advisor of your own, run it, remove it. |
| 3 | Maps and records | Read the `_sections` list in `home_screen.dart`. Reorder two sections and see the screen change. |
| 4 | `null` safety | Look up `?` and `!` in Dart. Find `onViewAll` in `section_card.dart` and explain why it's nullable. |
| 5 | `async` / `await` | Read `main.dart` and `supabase_bootstrap.dart`. Explain in your journal why `await` is there. |
| 6 (weekend) | Review | Rewrite the week's DartPad exercises without looking. |

**Done when:** you can explain every line of `main.dart` and `advisor.dart`.

### Week 3: Flutter widgets and layout
- Complete the official Flutter first-app codelab.
- Learn `Column`, `Row`, `Padding`, `Card`, `Text`, `Icon`, `ListView`.
- **Task:** build a static mission row (checkbox, title, "+2 XP") as a new widget in `lib/features/missions/presentation/`.

**Done when:** your mission widget appears on the Missions tab.

### Week 4: State and navigation
- Learn `StatelessWidget` vs `StatefulWidget`, then Riverpod providers.
- Read `router.dart` and `shell_scaffold.dart`.
- **Task:** make the mission checkbox tickable, and show "3 of 5" updating on the Missions tab using a Riverpod provider.

**Done when:** ticking a mission updates a counter on screen.

## Phase B: Decisions and data (weeks 5–8)

### Week 5: Finalize the rules (no coding)
- Work through every item in [roadmap.md → Open design decisions](roadmap.md#open-design-decisions) with Claude.
- Write the results into `docs/scoring-spec.md`: XP formula, level table, multiplier cap, penalties per accountability mode, evolution triggers.

**Done when:** each rule has worked examples with real numbers.

### Week 6: Database design
- Learn SQL basics: tables, columns, primary keys, foreign keys, `SELECT`, `INSERT`.
- Create a free Supabase project. Learn what row-level security (RLS) is.
- **Task:** with Claude, write the first migration: profiles, habits, habit_logs, budgets, transactions, savings_goals, visions, milestones, xp_events.

**Done when:** the tables exist in Supabase and you can explain why a user can't edit their own XP.

### Week 7: Authentication
- Learn what sessions and tokens are.
- **Task:** sign-up, login and logout screens, and redirecting logged-out users to login.

**Done when:** you can create an account and log back in after restarting the app.

### Week 8: Onboarding
- **Task:** a 4-step onboarding flow: choose growth areas, first vision, budget (daily allowance, fun budget, savings target), 3 starting habits, and accountability mode.

**Done when:** a new account goes through onboarding and the answers are saved in Supabase.

## Phase C: Core engines, the MVP (weeks 9–16)

| Week | Build | Done when |
| --- | --- | --- |
| 9 | Habits: create, edit, daily missions, mark done | Missions come from the database and stay ticked after a restart |
| 10 | Streaks and Momentum | Streak count is correct after skipping a day (with unit tests) |
| 11 | Finance: log spending (essential vs fun), daily/weekly allowance | Allowance goes down as you log spending |
| 12 | Savings goals, budget status ("On track") | Financial Snapshot on Home shows real numbers |
| 13 | Visions: goals, milestones, progress, link habits to a vision | Active Visions on Home shows real progress |
| 14 | Scoring engine on the server: XP, levels, Discipline and Integrity scores | Unit tests match the worked examples in `scoring-spec.md` |
| 15 | Penalties, recovery paths, Challenge & Evolution offers | A missed mission makes the agreed adjustment, with an explanation |
| 16 | Wire the whole home screen, fix bugs, install on your phone | **You use the MVP every day** |

## Phase D: Knowledge Hub and AI Council (weeks 17–24)

| Week | Build |
| --- | --- |
| 17 | Import PDFs from the device; library list |
| 18 | Reader: open a PDF, save reading progress |
| 19 | Bookmarks, highlights, notes; EPUB support |
| 20 | Reading missions and XP; "Continue Learning" on Home |
| 21 | AI setup: Edge Function that calls the AI provider; keys kept on the server |
| 22 | Advisors: personalities, coaching strictness, one-to-one chat |
| 23 | Council Chamber (several advisors on one decision); Today's Council Insight |
| 24 | AI explanations, summaries and quizzes for books |

## Phase E: Release (weeks 25–28)

| Week | Work |
| --- | --- |
| 25 | Security review: RLS policies, data access, key handling |
| 26 | Accessibility and performance; app icon and name |
| 27 | Beta with 5–10 friends; fix what they find |
| 28 | Privacy policy; publish to the Play Store (App Store needs a Mac and a paid Apple developer account) |

---

## Progress tracker

- [ ] Week 1: Set up and run the app
- [ ] Week 2: Dart for real apps
- [ ] Week 3: Flutter widgets
- [ ] Week 4: State and navigation
- [ ] Week 5: Scoring spec finalized
- [ ] Week 6: Database
- [ ] Week 7: Authentication
- [ ] Week 8: Onboarding
- [ ] Weeks 9–16: MVP engines
- [ ] Weeks 17–24: Knowledge Hub and AI Council
- [ ] Weeks 25–28: Release
