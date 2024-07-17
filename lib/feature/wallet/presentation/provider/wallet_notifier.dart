import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../feature.dart';

class WalletNotifier extends StateNotifier<WalletState> {
  final TopUpRequestUseCase _topUpRequestUseCase;
  final WalletAmountUseCase _amountUseCase;
  final WalletHistoryUseCase _historyUseCase;

  WalletNotifier(
      this._topUpRequestUseCase, this._amountUseCase, this._historyUseCase)
      : super(const WalletState.initial());

  Future<Either<Failure, String>> walletAmount() async {
    state.copyWith(isLoading: true);
    final result = await _amountUseCase.call();
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, WalletHistoryModel>> walletHistory() async {
    state.copyWith(isLoading: true);
    final result = await _historyUseCase.call();
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, WalletResult>> topUpRequest(
      WalletTopUpEntities walletTopUpEntities) async {
    state.copyWith(isLoading: true);
    final result = await _topUpRequestUseCase.call(walletTopUpEntities);
    state.copyWith(isLoading: false);
    return result;
  }
}
