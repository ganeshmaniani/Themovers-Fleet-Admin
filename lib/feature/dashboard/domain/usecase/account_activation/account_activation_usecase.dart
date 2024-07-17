import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../dashboard.dart';

class AccountActivationUseCase {
  final DashboardRepository _repository;
  AccountActivationUseCase(this._repository);

  Future<Either<Failure, AccountResult>> call() async {
    return await _repository.checkUserAccountActivation();
  }
}
