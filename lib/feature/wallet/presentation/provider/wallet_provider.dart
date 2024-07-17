import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../feature.dart';

final walletProvider =
    StateNotifierProvider<WalletNotifier, WalletState>((ref) {
  final topUpRequestUseCase = ref.watch(topUpRequestUseCaseProvider);
  final walletAmount = ref.watch(walletAmountUseCaseProvider);
  final walletHistory = ref.watch(walletHistoryUseCaseProvider);
  return WalletNotifier(topUpRequestUseCase, walletAmount, walletHistory);
});
