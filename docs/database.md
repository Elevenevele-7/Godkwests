# Database Decisions

Decided 2026-10-22. Each decision below comes from a product requirement.

## Requirements

| Question | Answer |
| --- | --- |
| Work without internet? | Yes. Daily logging must never fail on a bad connection. |
| Devices | Several devices on one account (phone, tablet, web), kept in sync. |
| Privacy | Finance data must be private: not readable by the server or the developer. |
| Hosting budget | Start on free tiers; upgrade (about $25/month) at launch. |

## The design: offline-first, with a local database and cloud sync

```
 Phone / tablet / web                         Supabase (cloud)
┌───────────────────────────┐               ┌──────────────────────────────┐
│ App screens               │               │ Postgres database            │
│        │                  │               │  • habits, visions, XP …     │
│        ▼                  │    sync when  │    (readable, locked per user│
│ Local SQLite database     │◄─────────────►│     by row-level security)   │
│  • everything, instantly  │     online    │  • finance rows: encrypted   │
│  • finance decrypted here │               │    blobs the server can't read│
└───────────────────────────┘               │ Auth · Edge Functions        │
                                            └──────────────────────────────┘
```

1. **Every read and write goes to a database on the device first** (SQLite, through the `drift` package). The app is instant and works offline.
2. **A sync step copies changes to and from Supabase** when a connection is available, so all devices converge. Most of our data is append-only logs (mission completions, spending entries, XP events), which keeps sync simple and avoids conflicting edits. If custom sync becomes too complex, PowerSync, a sync service built for Supabase and Flutter, is the fallback.
3. **Supabase Postgres** is the shared copy and the backup. Row-level security means each account can only reach its own rows.

### How sync is built (implemented 2026-11-02)

- Every synced local table has `id`, `updatedAt`, `deleted` (soft delete, so deletions sync) and `dirty` (changed on this device since the last sync).
- The server has one generic table, `sync_rows`: a row's JSON (`data`) or, for finance tables, its ciphertext (`cipher`). A trigger stamps `synced_at`, and each device pulls rows newer than the last `synced_at` it saw.
- **Conflicts:** the newest `updatedAt` wins, per row. Rows that happen once per day per thing (a habit's completion on a day, a reward) have deterministic ids, so two devices produce the same row instead of duplicates.
- Code: `lib/features/sync/` (tests in `test/features/sync_test.dart` simulate two devices). Schema: `supabase/migrations/`.
- Imported book files stay on the device that imported them; only reading progress, bookmarks and notes sync.

## Finance privacy: end-to-end encryption

Finance records (budgets, allowances, spending, savings amounts) are **encrypted on the device before they sync**. The server stores scrambled data it can't read. Each of the user's devices holds the key, so they can decrypt it.

- **Key setup:** when finance is first set up, the app creates an encryption key. The user picks a **finance passphrase** and is shown a **recovery key** once. A new device unlocks finance with either one.
- **The trade-off:** if the user loses every device *and* forgets both the passphrase and the recovery key, finance history cannot be recovered, by anyone. Onboarding must say this clearly.
- **Non-finance data** (habits, visions, XP, learning) syncs normally, protected by row-level security. It isn't end-to-end encrypted, so the AI Council can use a summary of it.

### How finance still earns rewards

The blueprint says rewards and penalties come from trusted app logic, never the AI. Since the server can't read finance data:

- Budget calculations (allowance left, on track, overspent) run in **the app's own tested code on the device**, not in the AI.
- The device sends the server **only the outcome** it needs to award XP or apply a penalty, for example "stayed within budget on 2026-10-22" or "savings milestone 3 reached". It never sends amounts.
- The AI Council's Financial Mentor sees **only summaries the user allows**, such as status or percentages, never raw transactions.

A user could in principle tamper with their own device to claim a budget outcome they didn't earn. That only affects their own score, and is accepted as the cost of privacy.

## Choices

| Concern | Choice | Why |
| --- | --- | --- |
| Local database | SQLite via `drift` | Typed Dart queries, migrations, works on Android, iOS and web |
| Cloud database | Supabase Postgres | Relational data (visions link to habits, budgets, XP), auth, row-level security, Edge Functions |
| Sync | Custom, built on append-only change logs; PowerSync as fallback | Simple for log-shaped data; no extra service at first |
| Finance encryption | AES-256-GCM, key derived from passphrase (Argon2id) | Standard, well-reviewed algorithms |
| Hosting | Supabase free plan now, Pro plan at launch | Free projects pause after inactivity; Pro adds daily backups |

## Status

Done: scoring rules settled ([scoring-spec.md](scoring-spec.md)); local tables (`lib/core/database/tables.dart`); Supabase schema (`supabase/migrations/`); sync with encrypted finance. To switch it on, see [setup.md](setup.md).
