import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final useCaseSignIn = ref.watch(signInUseCaseProvider);
  final useCaseRegister = ref.watch(registerCaseProvider);
  final mobileNumberChecker = ref.watch(mobileNumberCheckerUseCaseProvider);
  final forgetPassword = ref.watch(forgetPasswordCaseProvider);
  final otpGenerator = ref.watch(otpGeneratorUseCaseProvider);
  final otpChecker = ref.watch(otpCheckerUseCaseProvider);
  final emailChecker = ref.watch(emailCheckerUseCaseProvider);
  return AuthNotifier(useCaseSignIn, useCaseRegister, mobileNumberChecker,
      forgetPassword, otpGenerator, otpChecker, emailChecker);
});
