import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../config/env.dart';

abstract final class SupabaseBootstrap {
  /// Initializes Supabase when credentials are configured.
  ///
  /// Without credentials the app still starts, so UI work can continue
  /// before a backend project exists.
  static Future<void> initialize() async {
    if (!Env.hasSupabase) {
      debugPrint('Supabase not configured; running without a backend.');
      return;
    }
    await Supabase.initialize(
      url: Env.supabaseUrl,
      publishableKey: Env.supabasePublishableKey,
    );
  }
}
