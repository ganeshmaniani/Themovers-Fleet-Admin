import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../feature.dart';

final jobListCaseProvider = Provider<JobListUseCase>((ref) {
  final authRepository = ref.watch(jobRepositoryProvider);
  return JobListUseCase(authRepository);
});
