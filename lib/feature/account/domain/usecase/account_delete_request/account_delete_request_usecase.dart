import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../account.dart';

class AccountDeleteUseCase {
  final AccountRepository _repository;

  AccountDeleteUseCase(this._repository);

  Future<Either<Failure, dynamic>> call() async {
    return await _repository.accountDeleteRequest();
  }
}
