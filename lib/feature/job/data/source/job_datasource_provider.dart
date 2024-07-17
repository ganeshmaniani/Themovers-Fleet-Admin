import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../feature.dart';

final jobDatasourceProvider = Provider<JobDataSource>((ref) {
  final apiServices = ref.watch(networkProvider);
  return JobDataSourceImpl(apiServices);
});
