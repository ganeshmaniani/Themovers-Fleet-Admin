import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../account.dart';

@immutable
class AccountState extends Equatable {
  final AdminAccountResult accountResult;
  final bool isLoading;

  const AccountState({required this.accountResult, required this.isLoading});

  const AccountState.initial(
      {this.accountResult = AdminAccountResult.none, this.isLoading = false});

  @override
  List<Object> get props => [accountResult, isLoading];

  @override
  bool get stringify => true;

  AccountState copyWith({AdminAccountResult? accountResult, bool? isLoading}) {
    return AccountState(
      accountResult: accountResult ?? this.accountResult,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
