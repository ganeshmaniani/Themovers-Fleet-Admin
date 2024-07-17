import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../dashboard.dart';

final dashboardDatasourceProvider = Provider<DashboardDataSource>((ref) {
  final apiServices = ref.watch(networkProvider);
  return DashboardDataSourceImpl(apiServices);
});
