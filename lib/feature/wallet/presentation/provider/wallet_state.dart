import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../feature.dart';

@immutable
class WalletState extends Equatable {
  final WalletResult walletResult;
  final bool isLoading;

  const WalletState({required this.walletResult, required this.isLoading});

  const WalletState.initial(
      {this.walletResult = WalletResult.none, this.isLoading = false});

  @override
  List<Object> get props => [walletResult, isLoading];

  @override
  bool get stringify => true;

  WalletState copyWith({WalletResult? walletResult, bool? isLoading}) {
    return WalletState(
      walletResult: walletResult ?? this.walletResult,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
