import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImpl(this._authDataSource);

  @override
  Future<Either<Failure, AuthResult>> signIn(
      LoginEntities loginEntities) async {
    return await _authDataSource.signIn(loginEntities);
  }

  @override
  Future<Either<Failure, AuthResult>> register(
      RegisterEntities registerEntities) async {
    return await _authDataSource.register(registerEntities);
  }

  @override
  Future<Either<Failure, String>> forgetPasswordEmailChecker(
      String email) async {
    return await _authDataSource.forgetPasswordEmailChecker(email);
  }

  @override
  Future<Either<Failure, AuthResult>> phoneNoChecker(String phone) async {
    return await _authDataSource.phoneNoChecker(phone);
  }

  @override
  Future<Either<Failure, AuthResult>> forgetPassword(
      ForgetPasswordEntities forgetPasswordEntities) async {
    return await _authDataSource.forgetPassword(forgetPasswordEntities);
  }

  @override
  Future<Either<Failure, String>> forgetPasswordMobileNumberChecker(
      String phone) async {
    return await _authDataSource.forgetPasswordMobileNumberChecker(phone);
  }

  @override
  Future<Either<Failure, AuthResult>> emailOtpChecker(
      EmailOtpEntities emailOtpEntities) async {
    return await _authDataSource.emailOtpChecker(emailOtpEntities);
  }

  @override
  Future<Either<Failure, AuthResult>> emailOtpGenerator(String email) async {
    return await _authDataSource.emailOtpGenerator(email);
  }
}
