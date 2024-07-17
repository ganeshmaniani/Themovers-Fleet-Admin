import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../auth.dart';

class OtpCheckerUseCase implements UseCase<AuthResult, EmailOtpEntities> {
  final AuthRepository _authRepository;

  OtpCheckerUseCase(this._authRepository);

  @override
  Future<Either<Failure, AuthResult>> call(
      EmailOtpEntities emailOtpEntities) async {
    return await _authRepository.emailOtpChecker(emailOtpEntities);
  }
}
