import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../feature.dart';

final sliderUseCaseProvider = Provider<SliderUseCase>((ref) {
  final dashboardRepository = ref.watch(dashboardRepositoryProvider);
  return SliderUseCase(dashboardRepository);
});
