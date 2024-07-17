import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../account.dart';

class UserEditUseCase
    implements UseCase<AdminAccountResult, AccountEditEntities> {
  final AccountRepository _accountRepository;

  UserEditUseCase(this._accountRepository);

  @override
  Future<Either<Failure, AdminAccountResult>> call(
      AccountEditEntities accountEditEntities) async {
    return await _accountRepository.userEdit(accountEditEntities);
  }
}
