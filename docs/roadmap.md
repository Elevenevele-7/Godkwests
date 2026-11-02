# Roadmap

Phases follow blueprint §9. Per the blueprint, no new major features are added until these systems work together reliably.

| # | Phase           | Scope                                                            | Status  |
| - | --------------- | ---------------------------------------------------------------- | ------- |
| 1 | Foundation      | Flutter project, Git, folder layout, dependencies, nav shell      | Done    |
| 2 | Database        | User, habit, budget, vision, scoring, challenge, learning models; RLS | In progress: design decided, tables next |
| 3 | Authentication  | Sign-up, login, sessions, profiles                               |         |
| 4 | Onboarding      | Goals, preferences, budget settings, initial routines            |         |
| 5 | Dashboard       | Command Center wired to real data                                |         |
| 6 | Core engines    | Habits, budgets, scoring, deductions, rewards, visions           |         |
| 7 | Learning        | Local file import (PDF, EPUB), reader, bookmarks, progress       |         |
| 8 | AI Council      | Advisors, personalization, challenge recommendations             |         |
| 9 | Testing/release | Calculations, permissions, security, accessibility, performance  |         |

## Done so far

### Phase 1: Foundation (done 2026-10-19)
- Flutter project created for Android, iOS and web (`ascension`), with Supabase, Riverpod, go_router and intl.
- Feature-first folders: `lib/features/<feature>/{data,domain,presentation}` for auth, onboarding, home, missions, finance, visions, knowledge, council, progression and profile. See [architecture.md](architecture.md).
- Bottom navigation with five tabs: Home, Missions, Finance, Knowledge, Profile.
- Command Center home screen in blueprint order (finance first), showing empty states until real data exists.
- AI Council roster: the eight advisors defined in `lib/features/council/domain/advisor.dart`.
- Supabase connection is optional: the app runs without a backend until keys are added to `env.json`.
- Automated tests for the home screen and tab navigation; code analysis passes with no issues.

### Planning and documentation
- [blueprint.md](blueprint.md): the product blueprint, saved in the repo.
- [architecture.md](architecture.md): folder rules and trust boundaries (rewards and penalties come from tested code, never the AI).
- [learning-plan.md](learning-plan.md): a 28-week timeline (MVP in about 4 months) and the daily study routine.

### Phase 2: Database (in progress)
Done, recorded in [database.md](database.md) (2026-10-22):
- **Offline-first:** each device has its own SQLite database (`drift`), which syncs with Supabase Postgres when online.
- **Several devices:** one account on phone, tablet and web, kept in sync.
- **Encrypted finance:** money data is encrypted on the device; the server can't read it. Users get a finance passphrase and a one-time recovery key.
- **Finance rewards:** budget maths runs in app code on the device, and only outcomes (for example "within budget today") are sent for XP.
- **Hosting:** Supabase free plan while building; Pro plan (about $25/month) at launch.

Remaining:
- [x] Scoring rules settled: [scoring-spec.md](scoring-spec.md).
- [ ] Write the table list: each table, its columns, and which are encrypted.
- [ ] First Supabase migration with row-level security.
- [ ] Matching local `drift` tables and the sync step.

## Open design decisions

These must be settled in the technical specification before Phase 6. Each should become a written rule plus unit tests.

**Scoring, penalties, rewards and evolution** (resolved 2026-11-02, see [scoring-spec.md](scoring-spec.md))
- ~~Level curve, XP multiplier and cap, anti-grinding, Discipline Score and Momentum, DP, VP, penalties and recovery, excused days, overspend adjustment, evolution triggers~~
- The Integrity Score was removed from the product.

**Database** (resolved, see [database.md](database.md))
- ~~Offline support, multi-device sync, finance privacy, hosting budget~~

**Knowledge Hub**
- Supported import formats for v1, and whether files stay on the device or sync to Supabase Storage.

**AI Council**
- Provider decided: Claude (Anthropic), called from a Supabase Edge Function. Still open: model choice, what user data is shared, per-user cost limits.
