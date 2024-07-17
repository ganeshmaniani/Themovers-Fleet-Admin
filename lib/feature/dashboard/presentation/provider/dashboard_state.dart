import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../dashboard.dart';

@immutable
class DashboardState extends Equatable {
  final AccountResult accountResult;
  final bool isLoading;

  const DashboardState({required this.accountResult, required this.isLoading});

  const DashboardState.initial(
      {this.accountResult = AccountResult.none, this.isLoading = false});

  @override
  List<Object> get props => [accountResult, isLoading];

  @override
  bool get stringify => true;

  DashboardState copyWith({AccountResult? accountResult, bool? isLoading}) {
    return DashboardState(
      accountResult: accountResult ?? this.accountResult,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
