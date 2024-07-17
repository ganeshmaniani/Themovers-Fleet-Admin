import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../account.dart';

class UserDetailUseCase {
  final AccountRepository _repository;

  UserDetailUseCase(this._repository);

  Future<Either<Failure, UserDetailModel>> call() async {
    return await _repository.userDetail();
  }
}
