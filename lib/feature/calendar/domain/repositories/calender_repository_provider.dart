import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../calendar.dart';

final calenderRepositoryProvider = Provider<CalenderRepository>((ref) {
  final remoteDataSource = ref.watch(calenderDatasourceProvider);
  return CalenderRepositoryImpl(remoteDataSource);
});
