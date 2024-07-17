import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../auth.dart';

class EmailCheckerUseCase implements UseCase<String, String> {
  final AuthRepository _authRepository;

  EmailCheckerUseCase(this._authRepository);

  @override
  Future<Either<Failure, String>> call(String email) async {
    return await _authRepository.forgetPasswordEmailChecker(email);
  }
}
