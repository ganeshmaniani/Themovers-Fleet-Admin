import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../feature.dart';

final disposalEditUseCaseProvider = Provider<DisposalEditUseCase>((ref) {
  final authRepository = ref.watch(jobRepositoryProvider);
  return DisposalEditUseCase(authRepository);
});
