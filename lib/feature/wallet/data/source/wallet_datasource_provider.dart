import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../wallet.dart';

final walletDatasourceProvider = Provider<WalletDataSource>((ref) {
  final apiServices = ref.watch(networkProvider);
  return WalletDataSourceImpl(apiServices);
});
