import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../account.dart';

class UserProfileEditUseCase implements UseCase<AdminAccountResult, File> {
  final AccountRepository _accountRepository;

  UserProfileEditUseCase(this._accountRepository);

  @override
  Future<Either<Failure, AdminAccountResult>> call(File file) async {
    return await _accountRepository.userProfile(file);
  }
}
