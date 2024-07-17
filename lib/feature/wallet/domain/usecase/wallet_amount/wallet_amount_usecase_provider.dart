import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../feature.dart';

final walletAmountUseCaseProvider = Provider<WalletAmountUseCase>((ref) {
  final walletRepository = ref.watch(walletRepositoryProvider);
  return WalletAmountUseCase(walletRepository);
});
