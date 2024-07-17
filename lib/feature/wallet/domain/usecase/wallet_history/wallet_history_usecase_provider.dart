import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../feature.dart';

final walletHistoryUseCaseProvider = Provider<WalletHistoryUseCase>((ref) {
  final walletRepository = ref.watch(walletRepositoryProvider);
  return WalletHistoryUseCase(walletRepository);
});
