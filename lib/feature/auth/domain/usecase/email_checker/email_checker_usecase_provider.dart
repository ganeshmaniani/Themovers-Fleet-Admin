import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth.dart';

final emailCheckerUseCaseProvider = Provider<EmailCheckerUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return EmailCheckerUseCase(authRepository);
});
