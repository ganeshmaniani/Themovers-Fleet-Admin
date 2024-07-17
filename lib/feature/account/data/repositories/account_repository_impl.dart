import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:themovers_fleet_admin/core/errors/failure.dart';

import '../../../feature.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountDataSource _accountDataSource;

  const AccountRepositoryImpl(this._accountDataSource);

  @override
  Future<Either<Failure, dynamic>> accountDeleteRequest() async {
    return await _accountDataSource.accountDeleteRequest();
  }

  @override
  Future<Either<Failure, UserDetailModel>> userDetail() async {
    return await _accountDataSource.userDetail();
  }

  @override
  Future<Either<Failure, AdminAccountResult>> userEdit(
      AccountEditEntities accountEditEntities) async {
    return await _accountDataSource.userEdit(accountEditEntities);
  }

  @override
  Future<Either<Failure, AdminAccountResult>> userProfile(File file) async {
    return await _accountDataSource.userProfile(file);
  }
}
