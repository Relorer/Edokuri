import 'package:flutter_config/flutter_config.dart';
import 'package:freader/src/controllers/stores/supabase/supabase_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseFactory {
  Future<SupabaseController> getSupabaseController() async {
    await Supabase.initialize(
      url: FlutterConfig.get('SUPABASE_URL'),
      anonKey: FlutterConfig.get('SUPABASE_ANON_KEY'),
    );

    return SupabaseController();
  }
}
