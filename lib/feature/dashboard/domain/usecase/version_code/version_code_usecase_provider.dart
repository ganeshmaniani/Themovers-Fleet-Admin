import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../feature.dart';
import '../slider/slider_usecase.dart';

final versionCodeUseCaseProvider = Provider<VersionCodeUseCase>((ref) {
  final dashboardRepository = ref.watch(dashboardRepositoryProvider);
  return VersionCodeUseCase(dashboardRepository);
});
