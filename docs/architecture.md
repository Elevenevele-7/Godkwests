# Architecture

## Stack

| Concern        | Choice                                  |
| -------------- | --------------------------------------- |
| App            | Flutter (Android, iOS, web)             |
| Backend        | Supabase (Postgres, Auth, Storage, Edge Functions) |
| State          | Riverpod (`flutter_riverpod`)           |
| Navigation     | `go_router`, with a five-tab `StatefulShellRoute` |
| Formatting     | `intl` (currency such as KSh, dates)    |
| Testing        | `flutter_test`, `mocktail`              |

## Folder layout

```
lib/
  main.dart                 Entry point: Supabase bootstrap, ProviderScope
  app/                      App widget, router, bottom-nav shell, theme
  core/
    config/                 Compile-time env (Supabase URL and key)
    supabase/               Supabase initialization
    widgets/                Shared UI building blocks
  features/
    auth/                   Sign-up, login, sessions
    onboarding/             Goals, preferences, budget settings, initial routines
    home/                   Command Center dashboard
    missions/               Habits, daily missions, streaks, challenges, evolution
    finance/                Budgets, allowances, savings goals, accountability
    visions/                Long-term goals, milestones, Vision Points history
    knowledge/              Library, reader, highlights, notes, learning paths
    council/                AI advisors, Council Chamber
    progression/            XP, levels, scores, DP/VP, penalties and recovery
    profile/                Identity progress, settings
supabase/
  migrations/               SQL schema, row-level security policies, functions
  functions/                Edge Functions (trusted scoring, AI Council proxy)
docs/                       Blueprint, architecture, roadmap
test/                       Mirrors lib/
```

Each feature has three layers:

- `domain/`: plain Dart entities and rules, with no Flutter or Supabase imports. Scoring and budget calculations live here or on the server, so they can be unit tested.
- `data/`: repositories that read and write Supabase and map rows to domain entities.
- `presentation/`: screens, widgets and Riverpod providers.

Features may depend on `core/` and on other features' `domain/` layers, never on another feature's `presentation/` or `data/`.

## Trust boundaries

The blueprint requires that **financial calculations, rewards and deductions are decided by trusted application logic, never by the AI**:

1. The client may show a preview of XP effects, but the authoritative values are computed on the server, in Postgres functions or Edge Functions, and written by them. **Exception: finance.** Finance data is end-to-end encrypted, so budget calculations run in tested app code on the device. The device reports only outcomes (for example "within budget today") to the server for rewards. See [database.md](database.md).
2. Users cannot write score, XP, DP or VP columns directly. Row-level security allows inserting activity records only. Awards are derived from those records.
3. The AI Council reads a summary of the user's data and returns advice and *suggested* actions. Any suggestion that changes a goal, budget or challenge needs the user's confirmation and passes through the same validated paths.
4. AI provider keys live only in Edge Function secrets, never in the app.
5. Earned VP and completed visions are append-only (achievement permanence).

## Configuration

Secrets are passed with `--dart-define-from-file=env.json`; see `env.example.json`. Without them the app runs with no backend so UI work isn't blocked.
