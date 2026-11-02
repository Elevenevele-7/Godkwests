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

## Finance privacy: end-to-end encryption

Finance records (budgets, allowances, spending, savings amounts) are **encrypted on the device before they sync**. The server stores scrambled data it can't read. Each of the user's devices holds the key, so they can decrypt it.

- **Key setup:** when finance is first set up, the app creates an encryption key. The user picks a **finance passphrase** and is shown a **recovery key** once. A new device unlocks finance with either one.
- **The trade-off:** if the user loses every device *and* forgets both the passphrase and the recovery key, finance history cannot be recovered, by anyone. Onboarding must say this clearly.
- **Non-finance data** (habits, visions, XP, learning) syncs normally, protected by row-level security. It isn't end-to-end encrypted, so the server can calculate scores and the AI Council can use it.

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

## Next

1. Finalize the scoring rules (roadmap → open design decisions), because tables like `xp_events` and `penalties` depend on them.
2. Write the table list: which tables exist, what columns each has, and which are encrypted.
3. Build the first Supabase migration and the matching local `drift` tables.
