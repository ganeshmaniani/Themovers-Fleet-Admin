import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../auth.dart';

class MobileNumberCheckerUseCase implements UseCase<String, String> {
  final AuthRepository _authRepository;

  MobileNumberCheckerUseCase(this._authRepository);

  @override
  Future<Either<Failure, String>> call(String phone) async {
    return await _authRepository.forgetPasswordMobileNumberChecker(phone);
  }
}
