import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dashboard.dart';

final dashboardProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
  final useCaseAccountActivation = ref.watch(accountActivationUseCaseProvider);
  final useCaseJobStatus = ref.watch(jobStatusUseCaseProvider);
  final useCaseSlider = ref.watch(sliderUseCaseProvider);
  final versionCode = ref.watch(versionCodeUseCaseProvider);
  return DashboardNotifier(
      useCaseAccountActivation, useCaseJobStatus, useCaseSlider, versionCode);
});
