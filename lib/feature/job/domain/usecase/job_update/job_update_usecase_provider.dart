import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../feature.dart';

final jobUpdateUseCaseProvider = Provider<JobUpdateUseCase>((ref) {
  final authRepository = ref.watch(jobRepositoryProvider);
  return JobUpdateUseCase(authRepository);
});
