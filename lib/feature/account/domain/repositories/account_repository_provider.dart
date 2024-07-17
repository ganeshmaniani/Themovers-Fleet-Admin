import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../account.dart';

final accountRepositoryProvider = Provider<AccountRepository>((ref) {
  final remoteDataSource = ref.watch(accountDatasourceProvider);
  return AccountRepositoryImpl(remoteDataSource);
});
