import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../account.dart';

final accountDatasourceProvider = Provider<AccountDataSource>((ref) {
  final apiServices = ref.watch(networkProvider);
  return AccountDataSourceImpl(apiServices);
});
