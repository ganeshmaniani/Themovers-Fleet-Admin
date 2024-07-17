import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../account.dart';

final userEditUseCaseProvider = Provider<UserEditUseCase>((ref) {
  final accountRepository = ref.watch(accountRepositoryProvider);
  return UserEditUseCase(accountRepository);
});
