import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../feature.dart';

final deleteRequestUseCaseProvider = Provider<DeleteRequestUseCase>((ref) {
  final authRepository = ref.watch(jobRepositoryProvider);
  return DeleteRequestUseCase(authRepository);
});
