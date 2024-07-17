import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/core.dart';

class AuthenticationNotifier extends StateNotifier<bool> {
  AuthenticationNotifier() : super(false) {
    _initializeAuthenticationSharedPrefs();
  }

  void _initializeAuthenticationSharedPrefs() {
    final sharedPreferences = SharedPrefs.instance;
    state = sharedPreferences.getBool(AppKeys.loginToken) ?? true;
  }

  Future<void> authenticationLoggedIn() async {
    final sharedPreferences = SharedPrefs.instance;
    state = sharedPreferences.getBool(AppKeys.loginToken) ?? false;
  }

  Future<void> setAuthenticationLoggedIn(bool isLoggedIn) async {
    final sharedPreferences = SharedPrefs.instance;
    await sharedPreferences.setBool(AppKeys.loginToken, isLoggedIn);
    state = isLoggedIn;
  }
}
