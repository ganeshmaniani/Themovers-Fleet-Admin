import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../feature.dart';

final jobDetailUseCaseProvider = Provider<JobDetailUseCase>((ref) {
  final authRepository = ref.watch(jobRepositoryProvider);
  return JobDetailUseCase(authRepository);
});
