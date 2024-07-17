import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'authentication_notifier.dart';

final authenticationNotifierProvider =
    StateNotifierProvider<AuthenticationNotifier, bool>((ref) {
  return AuthenticationNotifier();
});
