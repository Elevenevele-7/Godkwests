# Setup

## 1. Run the app on your Android phone (no account needed)

Everything except sync and the AI Council works offline, on the phone.

1. Install [Flutter](https://docs.flutter.dev/get-started/install) (stable channel) and Android Studio. Run `flutter doctor` until the Android section is green.
2. On the phone: **Settings → About phone →** tap **Build number** 7 times to enable Developer options. Then **Developer options → USB debugging** on.
3. Connect the phone by USB and allow debugging when prompted.
4. In the project folder:

   ```bash
   flutter pub get
   flutter run
   ```

To install a standalone build: `flutter build apk --release`, then copy `build/app/outputs/flutter-apk/app-release.apk` to the phone and open it. Android will ask you to allow installs from that source.

## 2. Switch on accounts, sync and the AI Council (Supabase)

1. Create a free project at [supabase.com](https://supabase.com). Note the **Project URL** and the **publishable key** (Project Settings → API).
2. **Database:** open the SQL editor, paste `supabase/migrations/20261102000000_initial.sql` and run it. (Or with the [Supabase CLI](https://supabase.com/docs/guides/cli): `supabase link` then `supabase db push`.)
3. **Auth:** Authentication → Providers → Email is on by default. For testing, you can turn off "Confirm email".
4. **AI Council:**
   - Create an API key at [console.anthropic.com](https://console.anthropic.com) and add billing.
   - Using the Supabase CLI:

     ```bash
     supabase secrets set ANTHROPIC_API_KEY=sk-ant-...
     supabase functions deploy council
     ```

   The key lives only in Supabase. It's never in the app or in Git.
5. **Connect the app:** copy `env.example.json` to `env.json` (Git ignores it), fill in the URL and publishable key, then:

   ```bash
   flutter run --dart-define-from-file=env.json
   flutter build apk --release --dart-define-from-file=env.json
   ```

6. In the app: **Profile → Account & sync → Sign in or create account**. Then create a **finance passphrase** to sync your budget (encrypted), and save the recovery key somewhere safe.

## 3. Watching AI costs

The Council uses **Claude Haiku 5.5**. Every reply is logged in `council_usage` with its token counts. To see the daily totals and an estimated cost, run this in the SQL editor:

```sql
select * from council_daily_cost;
```

The estimate uses Haiku 5.5's rates for prompts of 100K tokens or fewer ($0.10 per million input tokens, $0.50 per million output tokens). Check the current prices at [claude.com/pricing](https://claude.com/pricing) before you set a budget.

## Checks

```bash
dart format lib test
flutter analyze
flutter test
```

After changing a table in `lib/core/database/tables.dart`, regenerate the database code with `dart run build_runner build`, bump `schemaVersion`, and add a migration step.
