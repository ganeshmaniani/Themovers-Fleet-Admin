import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../account.dart';

class AccountNotifier extends StateNotifier<AccountState> {
  final AccountDeleteUseCase _accountDeleteUseCase;
  final UserDetailUseCase _userDetailUseCase;
  final UserEditUseCase _userEditUseCase;
  final UserProfileEditUseCase _userProfileEditUseCase;

  AccountNotifier(this._accountDeleteUseCase, this._userDetailUseCase,
      this._userEditUseCase, this._userProfileEditUseCase)
      : super(const AccountState.initial());

  Future<Either<Failure, dynamic>> accountDelete() async {
    state.copyWith(isLoading: true);
    final result = await _accountDeleteUseCase.call();
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, UserDetailModel>> userDetail() async {
    state.copyWith(isLoading: true);
    final result = await _userDetailUseCase.call();
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, AdminAccountResult>> userEdit(
      AccountEditEntities accountEditEntities) async {
    state.copyWith(isLoading: true);
    final result = await _userEditUseCase.call(accountEditEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, AdminAccountResult>> userProfileEdit(File file) async {
    state.copyWith(isLoading: true);
    final result = await _userProfileEditUseCase.call(file);
    state.copyWith(isLoading: false);
    return result;
  }
}
