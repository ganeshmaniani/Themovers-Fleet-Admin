import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../account.dart';

// final accountNotifierProvider =
//     ChangeNotifierProvider<AccountChangeNotifierProvider>((ref) {
//   return AccountChangeNotifierProvider();
// });

final accountProvider =
    StateNotifierProvider<AccountNotifier, AccountState>((ref) {
  final accountDelete = ref.watch(accountDeleteUseCaseProvider);
  final userDetail = ref.watch(userDetailUseCaseProvider);
  final userEdit = ref.watch(userEditUseCaseProvider);
  final userProfileEdit = ref.watch(userProfileEditUseCaseProvider);
  return AccountNotifier(accountDelete, userDetail, userEdit, userProfileEdit);
});
