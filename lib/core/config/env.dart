/// Compile-time configuration, supplied with
/// `flutter run --dart-define-from-file=env.json`.
///
/// See `env.example.json` for the expected keys. Never commit real keys.
abstract final class Env {
  static const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const supabasePublishableKey = String.fromEnvironment(
    'SUPABASE_PUBLISHABLE_KEY',
  );

  static bool get hasSupabase =>
      supabaseUrl.isNotEmpty && supabasePublishableKey.isNotEmpty;
}
