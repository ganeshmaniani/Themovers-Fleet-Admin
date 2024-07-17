import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'authentication_notifier_provider.dart';

final authenticationProvider = FutureProvider<bool>((ref) async {
  final authentication = ref.watch(authenticationNotifierProvider);
  return authentication;
});
