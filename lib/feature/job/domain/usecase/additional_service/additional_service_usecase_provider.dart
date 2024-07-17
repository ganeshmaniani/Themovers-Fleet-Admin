import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../feature.dart';

final additionalServiceUseCaseProvider =
    Provider<AdditionalServiceUseCase>((ref) {
  final authRepository = ref.watch(jobRepositoryProvider);
  return AdditionalServiceUseCase(authRepository);
});
