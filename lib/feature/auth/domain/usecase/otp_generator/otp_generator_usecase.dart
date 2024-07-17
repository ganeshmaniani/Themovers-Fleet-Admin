import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../auth.dart';

class OtpGeneratorUseCase implements UseCase<AuthResult, String> {
  final AuthRepository _authRepository;

  OtpGeneratorUseCase(this._authRepository);

  @override
  Future<Either<Failure, AuthResult>> call(String email) async {
    return await _authRepository.emailOtpGenerator(email);
  }
}
