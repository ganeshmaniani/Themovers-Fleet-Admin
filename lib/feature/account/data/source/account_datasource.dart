import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../account.dart';

abstract class AccountDataSource {
  Future<Either<Failure, UserDetailModel>> userDetail();

  Future<Either<Failure, AdminAccountResult>> userEdit(
      AccountEditEntities accountEditEntities);

  Future<Either<Failure, AdminAccountResult>> userProfile(File file);

  Future<Either<Failure, dynamic>> accountDeleteRequest();
}
