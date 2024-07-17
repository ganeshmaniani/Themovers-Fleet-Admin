import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../auth.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final SignInUseCase _signInUseCase;
  final RegisterUseCase _registerUseCase;
  final MobileNumberCheckerUseCase _mobileNumberCheckerUseCase;
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final OtpGeneratorUseCase _otpGeneratorUseCase;
  final OtpCheckerUseCase _otpCheckerUseCase;
  final EmailCheckerUseCase _emailCheckerUseCase;

  AuthNotifier(
      this._signInUseCase,
      this._registerUseCase,
      this._mobileNumberCheckerUseCase,
      this._forgetPasswordUseCase,
      this._otpGeneratorUseCase,
      this._otpCheckerUseCase,
      this._emailCheckerUseCase)
      : super(const AuthState.initial());

  Future<Either<Failure, AuthResult>> signIn(
      LoginEntities loginEntities) async {
    state.copyWith(isLoading: true);
    final result = await _signInUseCase.call(loginEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, AuthResult>> register(
      RegisterEntities registerEntities) async {
    state.copyWith(isLoading: true);
    final result = await _registerUseCase.call(registerEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, String>> mobileNumberChecker(String phone) async {
    state.copyWith(isLoading: true);
    final result = await _mobileNumberCheckerUseCase.call(phone);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, String>> emailChecker(String email) async {
    state.copyWith(isLoading: true);
    final result = await _emailCheckerUseCase.call(email);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, AuthResult>> forgetPassword(
      ForgetPasswordEntities passwordEntities) async {
    state.copyWith(isLoading: true);
    final result = await _forgetPasswordUseCase.call(passwordEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, AuthResult>> otpGenerator(String email) async {
    state.copyWith(isLoading: true);
    final result = await _otpGeneratorUseCase.call(email);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, AuthResult>> otpChecker(
      EmailOtpEntities emailOtpEntities) async {
    state.copyWith(isLoading: true);
    final result = await _otpCheckerUseCase.call(emailOtpEntities);
    state.copyWith(isLoading: false);
    return result;
  }
}
