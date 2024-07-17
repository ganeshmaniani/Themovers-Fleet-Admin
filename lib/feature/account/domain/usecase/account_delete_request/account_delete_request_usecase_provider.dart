import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../account.dart';

final accountDeleteUseCaseProvider = Provider<AccountDeleteUseCase>((ref) {
  final accountRepository = ref.watch(accountRepositoryProvider);
  return AccountDeleteUseCase(accountRepository);
});
