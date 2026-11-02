# Roadmap

Phases follow blueprint §9. Per the blueprint, no new major features are added until these systems work together reliably.

| # | Phase | Scope | Status |
| - | --- | --- | --- |
| 1 | Foundation | Flutter project, Git, folder layout, dependencies, nav shell | Done |
| 2 | Database | Local drift tables, Supabase schema with RLS, sync | Built; Supabase side not yet run against a real project |
| 3 | Authentication | Email sign-up and sign-in, sessions | Built; needs a Supabase project to try |
| 4 | Onboarding | Name, growth areas, accountability, coach, first vision, budget, starting habits | Done |
| 5 | Dashboard | Command Center wired to real data | Done |
| 6 | Core engines | Habits, budgets, scoring, penalties, rewards, visions, evolution | Done, with tests |
| 7 | Learning | PDF/EPUB import, reader, bookmarks, highlights, notes, AI tutor | Built; needs a real phone to try |
| 8 | AI Council | Advisors, Chamber, coaching style, usage logging | Built; needs Supabase and an Anthropic key |
| 9 | Testing/release | Calculations, permissions, security, accessibility, performance | Started: 41 automated tests pass |

## Done so far

### Phase 1: Foundation (2026-10-19)
- Flutter project for Android, iOS and web, feature-first folders, five-tab navigation. See [architecture.md](architecture.md).

### Decisions (2026-10-22 to 2026-11-02)
- [database.md](database.md): offline-first, several devices, end-to-end encrypted finance, Supabase free plan to start.
- [scoring-spec.md](scoring-spec.md): XP (bonus cap ×3), compound 12% level curve (levels can drop), anti-grinding, penalties by accountability mode, excused days, Momentum, Discipline Score, DP, VP, evolution, finance outcomes. **The Integrity Score was removed.**
- AI Council: Claude Haiku 5.5. It sees progress plus budget status only (no amounts). No message limit; usage is logged per user to estimate costs from real data.

### The app (2026-11-02)
- **Missions:** habits with difficulty, days, targets, growth area and vision link. One-tap completion with an XP breakdown. Excuse a day (4 penalty-free per month). Evolution offers and step-back. Recovery challenges.
- **Finance:** weekly essentials and fun budget, daily allowance, budget status, spending log, savings (optionally toward a vision), and the opt-in overspend adjustment.
- **Visions:** goals with why, category, target, deadline and milestones. Ambition-based VP. A permanent record of completed visions. Linked habits.
- **Knowledge:** import PDF/EPUB, reading progress, bookmarks, highlights (EPUB), notes, link a book to a "books" vision. AI explain, summarise and quiz. Starter learning paths.
- **AI Council:** chat with each advisor, the Council Chamber (up to 4 advisors), and a daily insight on Home that works offline.
- **Profile:** level, XP, DP, VP, Discipline, Momentum, Life Score, a full history of every point with its reason, and settings.
- **Sync:** sign-in, push/pull sync with newest-wins, finance passphrase and recovery key.
- **Tests:** scoring rules, the growth service on a real SQLite database, encryption, two-device sync, and app flows (onboarding, tabs, ticking a mission).

## Not yet verified

These need things this build environment doesn't have:
- **Running on a phone.** No Android SDK or emulator here, so file import, the PDF viewer and secure storage are untested on a device. Follow [setup.md](setup.md) §1.
- **Supabase.** The SQL migration, the sync calls and the `council` function haven't run against a real project. The function also hasn't been type-checked. Follow [setup.md](setup.md) §2.
- **Security, accessibility and performance review** (Phase 9).

## Open design decisions

- **Knowledge Hub:** book files stay on the device that imported them. Syncing the files themselves (Supabase Storage) is open.
- **AI Council:** whether to add a per-user daily limit once real usage data exists (`select * from council_daily_cost`).
- **Learning paths:** currently a static starter list; a fuller version (AI-built plans from a book) is open.
