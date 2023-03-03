import 'dart:developer';

import 'package:mobx/mobx.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'supabase_controller.g.dart';

class SupabaseController = SupabaseControllerBase with _$SupabaseController;

abstract class SupabaseControllerBase with Store {
  final supabase = Supabase.instance.client;

  @observable
  bool isAuthorized = false;

  SupabaseControllerBase();

  @action
  Future googleAuth() async {
    isAuthorized = await supabase.auth.signInWithOAuth(
      Provider.google,
      redirectTo: 'com.example.edokuri://login-callback/',
    );
  }

  @action
  Future githubAuth() async {
    isAuthorized = await supabase.auth.signInWithOAuth(
      Provider.github,
      redirectTo: 'com.example.edokuri://login-callback/',
    );
  }

  @action
  Future skipAuth() async {}

  @action
  Future logout() async {
    await supabase.auth.signOut();
    isAuthorized = false;
  }

  @action
  Future updateStatus() async {
    isAuthorized = supabase.auth.currentSession != null;
  }

  Future _runWithUpdate(Future<void> Function() f) async {
    try {
      await f();
    } catch (e) {
      log(e.toString());
    } finally {
      await updateStatus();
    }
  }
}
