import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dashboard.dart';

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  final remoteDataSource = ref.watch(dashboardDatasourceProvider);
  return DashboardRepositoryImpl(remoteDataSource);
});
