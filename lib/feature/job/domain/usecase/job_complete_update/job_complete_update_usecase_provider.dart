import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../feature.dart';

final jobCompleteUpdateUseCaseProvider =
    Provider<JobCompleteUpdateUseCase>((ref) {
  final authRepository = ref.watch(jobRepositoryProvider);
  return JobCompleteUpdateUseCase(authRepository);
});
