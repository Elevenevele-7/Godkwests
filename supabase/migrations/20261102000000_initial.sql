-- Godkwests cloud schema.
--
-- The app is offline-first: each device keeps its own SQLite database and
-- syncs rows here. One generic table holds every synced row, keyed by user,
-- table and row id. Finance rows are end-to-end encrypted on the device and
-- arrive here only as ciphertext (docs/database.md).

create table public.sync_rows (
  user_id     uuid        not null references auth.users (id) on delete cascade,
  tbl         text        not null,
  id          text        not null,
  -- Readable row (non-finance tables), as the app's JSON.
  data        jsonb,
  -- Encrypted row (finance tables): base64 of nonce ‖ ciphertext ‖ MAC.
  cipher      text,
  -- When the row last changed on the device that wrote it (conflict rule:
  -- the newest change wins).
  updated_at  timestamptz not null,
  deleted     boolean     not null default false,
  -- When the server last stored it; devices pull everything newer than the
  -- last value they saw.
  synced_at   timestamptz not null default now(),
  primary key (user_id, tbl, id),
  constraint one_payload check ((data is null) <> (cipher is null))
);

create index sync_rows_pull on public.sync_rows (user_id, synced_at);

create or replace function public.touch_synced_at() returns trigger
language plpgsql as $$
begin
  new.synced_at := clock_timestamp();
  return new;
end $$;

create trigger sync_rows_touch
before insert or update on public.sync_rows
for each row execute function public.touch_synced_at();

alter table public.sync_rows enable row level security;

create policy "own rows: read" on public.sync_rows
  for select using (auth.uid() = user_id);
create policy "own rows: insert" on public.sync_rows
  for insert with check (auth.uid() = user_id);
create policy "own rows: update" on public.sync_rows
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
-- No delete policy: deletions sync as deleted = true.

-- The finance data key, wrapped (encrypted) under the user's passphrase and
-- under their recovery key. The server can't unwrap either.
create table public.finance_keys (
  user_id      uuid primary key references auth.users (id) on delete cascade,
  by_passphrase jsonb not null,
  by_recovery   jsonb not null,
  created_at   timestamptz not null default now()
);

alter table public.finance_keys enable row level security;

create policy "own key: read" on public.finance_keys
  for select using (auth.uid() = user_id);
create policy "own key: insert" on public.finance_keys
  for insert with check (auth.uid() = user_id);
create policy "own key: update" on public.finance_keys
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- AI Council token usage per request, written only by the council function
-- (service role), so costs can be estimated from real usage.
create table public.council_usage (
  id                 bigint generated always as identity primary key,
  user_id            uuid not null references auth.users (id) on delete cascade,
  advisor            text not null,
  model              text not null,
  input_tokens       integer not null,
  output_tokens      integer not null,
  cache_read_tokens  integer not null default 0,
  cache_write_tokens integer not null default 0,
  created_at         timestamptz not null default now()
);

create index council_usage_user_day on public.council_usage (user_id, created_at);

alter table public.council_usage enable row level security;

create policy "own usage: read" on public.council_usage
  for select using (auth.uid() = user_id);

-- Daily cost summary for the project owner (run in the SQL editor).
-- Haiku 5.5 rates (prompts ≤100K tokens): $0.10 / $0.50 per million input /
-- output tokens; cache reads 0.1×, 5-minute cache writes 1.25× input.
create view public.council_daily_cost
with (security_invoker = true) as
select
  date_trunc('day', created_at)        as day,
  count(distinct user_id)              as users,
  count(*)                             as replies,
  sum(input_tokens)                    as input_tokens,
  sum(output_tokens)                   as output_tokens,
  round((
      sum(input_tokens)       * 0.10
    + sum(cache_read_tokens)  * 0.01
    + sum(cache_write_tokens) * 0.125
    + sum(output_tokens)      * 0.50
  ) / 1e6, 4)                          as est_cost_usd
from public.council_usage
group by 1
order by 1 desc;
