import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../feature.dart';

final premiumEditUseCaseProvider = Provider<PremiumEditUseCase>((ref) {
  final authRepository = ref.watch(jobRepositoryProvider);
  return PremiumEditUseCase(authRepository);
});
