import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../feature.dart';

final jobRepositoryProvider = Provider<JobRepository>((ref) {
  final remoteDataSource = ref.watch(jobDatasourceProvider);
  return JobRepositoryImpl(remoteDataSource);
});
