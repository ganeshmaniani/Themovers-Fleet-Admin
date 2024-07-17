import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth.dart';

final otpGeneratorUseCaseProvider = Provider<OtpGeneratorUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return OtpGeneratorUseCase(authRepository);
});
