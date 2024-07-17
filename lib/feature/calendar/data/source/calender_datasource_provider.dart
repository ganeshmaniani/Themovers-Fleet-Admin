import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../calendar.dart';

final calenderDatasourceProvider = Provider<CalenderDataSource>((ref) {
  final apiServices = ref.watch(networkProvider);
  return CalenderDataSourceImpl(apiServices);
});
