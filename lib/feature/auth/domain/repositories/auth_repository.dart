import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../auth.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResult>> signIn(LoginEntities loginEntities);

  Future<Either<Failure, AuthResult>> register(
      RegisterEntities registerEntities);

  Future<Either<Failure, AuthResult>> phoneNoChecker(String phone);

  Future<Either<Failure, String>> forgetPasswordEmailChecker(String email);

  Future<Either<Failure, AuthResult>> emailOtpGenerator(String email);

  Future<Either<Failure, AuthResult>> emailOtpChecker(
      EmailOtpEntities emailOtpEntities);

  Future<Either<Failure, String>> forgetPasswordMobileNumberChecker(
      String phone);

  Future<Either<Failure, AuthResult>> forgetPassword(
      ForgetPasswordEntities passwordEntities);
}
