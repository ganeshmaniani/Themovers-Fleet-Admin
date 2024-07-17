import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../feature.dart';

final topUpRequestUseCaseProvider = Provider<TopUpRequestUseCase>((ref) {
  final walletRepository = ref.watch(walletRepositoryProvider);
  return TopUpRequestUseCase(walletRepository);
});
