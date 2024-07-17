import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../feature.dart';

final jobStatusUseCaseProvider = Provider<JobStatusUseCase>((ref) {
  final dashboardRepository = ref.watch(dashboardRepositoryProvider);
  return JobStatusUseCase(dashboardRepository);
});
