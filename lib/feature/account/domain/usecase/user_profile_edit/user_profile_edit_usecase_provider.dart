import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../account.dart';

final userProfileEditUseCaseProvider = Provider<UserProfileEditUseCase>((ref) {
  final accountRepository = ref.watch(accountRepositoryProvider);
  return UserProfileEditUseCase(accountRepository);
});
