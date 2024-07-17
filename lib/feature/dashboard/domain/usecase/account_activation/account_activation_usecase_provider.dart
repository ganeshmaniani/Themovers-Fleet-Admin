import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../feature.dart';

final accountActivationUseCaseProvider =
    Provider<AccountActivationUseCase>((ref) {
  final dashboardRepository = ref.watch(dashboardRepositoryProvider);
  return AccountActivationUseCase(dashboardRepository);
});
