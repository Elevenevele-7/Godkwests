# Roadmap

Phases follow blueprint §9. Per the blueprint, no new major features are added until these systems work together reliably.

| # | Phase           | Scope                                                            | Status  |
| - | --------------- | ---------------------------------------------------------------- | ------- |
| 1 | Foundation      | Flutter project, Git, folder layout, dependencies, nav shell      | Done    |
| 2 | Database        | User, habit, budget, vision, scoring, challenge, learning models; RLS | Next |
| 3 | Authentication  | Sign-up, login, sessions, profiles                               |         |
| 4 | Onboarding      | Goals, preferences, budget settings, initial routines            |         |
| 5 | Dashboard       | Command Center wired to real data                                |         |
| 6 | Core engines    | Habits, budgets, scoring, deductions, rewards, visions           |         |
| 7 | Learning        | Local file import (PDF, EPUB), reader, bookmarks, progress       |         |
| 8 | AI Council      | Advisors, personalization, challenge recommendations             |         |
| 9 | Testing/release | Calculations, permissions, security, accessibility, performance  |         |

## Open design decisions

These must be settled in the technical specification before Phase 6. Each should become a written rule plus unit tests.

**Ascension Algorithm (XP and levels)**
- Level threshold curve, based on the binomial concept: the exact formula and table of levels.
- XP multiplier inputs (consistency, discipline, momentum, vision alignment), how each is weighted, and the **maximum multiplier cap**.
- Rounding rules.
- Anti-grinding rules: diminishing returns or daily caps for repeated trivial activities.

**Scores**
- Discipline Score, Integrity Score and Momentum: formulas, time windows and decay.
- How Integrity distinguishes a missed commitment from a legitimate change in circumstances, and who declares that.
- Life Score and Identity Progress: how user-chosen areas are combined.

**Rewards**
- DP award criteria (exceptional consistency, recovery, difficult achievements).
- VP progression: how later, more ambitious visions earn more than repeated beginner goals; the on-time completion bonus.

**Penalties and recovery**
- Penalty sizes per accountability mode, from gentle to highly structured.
- How a pattern of misses is detected.
- Recovery challenge definitions and Momentum restoration.
- Discretionary allowance adjustment: opt-in flow, limits, and the guarantee that essential spending is never affected.

**Challenge & Evolution**
- The trigger for an evolution offer: what counts as sustained improvement and over what period.
- Step-up sizing and the rule for recommending a return to the previous level.

**Knowledge Hub**
- Supported import formats for v1, and whether files stay on the device or sync to Supabase Storage.

**AI Council**
- AI provider and model, what user data is shared with it, and per-user cost limits.
