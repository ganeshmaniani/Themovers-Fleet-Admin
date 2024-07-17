import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../feature.dart';

final budgetEditUseCaseProvider = Provider<BudgetEditUseCase>((ref) {
  final authRepository = ref.watch(jobRepositoryProvider);
  return BudgetEditUseCase(authRepository);
});
