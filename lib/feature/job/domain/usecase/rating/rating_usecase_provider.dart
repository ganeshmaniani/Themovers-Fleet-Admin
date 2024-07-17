import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../feature.dart';

final ratingUseCaseProvider = Provider<RatingUseCase>((ref) {
  final authRepository = ref.watch(jobRepositoryProvider);
  return RatingUseCase(authRepository);
});
