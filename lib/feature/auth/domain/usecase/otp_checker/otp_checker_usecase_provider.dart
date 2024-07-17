import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth.dart';

final otpCheckerUseCaseProvider = Provider<OtpCheckerUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return OtpCheckerUseCase(authRepository);
});
