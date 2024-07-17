import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../account.dart';

final userDetailUseCaseProvider = Provider<UserDetailUseCase>((ref) {
  final accountRepository = ref.watch(accountRepositoryProvider);
  return UserDetailUseCase(accountRepository);
});
