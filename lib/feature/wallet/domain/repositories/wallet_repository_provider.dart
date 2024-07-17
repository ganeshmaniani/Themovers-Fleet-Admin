import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../feature.dart';

final walletRepositoryProvider = Provider<WalletRepository>((ref) {
  final remoteDataSource = ref.watch(walletDatasourceProvider);
  return WalletRepositoryImpl(remoteDataSource);
});
