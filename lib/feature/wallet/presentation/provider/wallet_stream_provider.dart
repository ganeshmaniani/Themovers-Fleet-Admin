import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../feature.dart';

final walletAmountStreamProvider =
    StreamProvider.autoDispose<Either<Failure, String>>((ref) async* {
  final dashboard = ref.read(walletProvider.notifier);

  yield await dashboard.walletAmount();
});

final walletHistoryStreamProvider =
    StreamProvider.autoDispose<Either<Failure, WalletHistoryModel>>(
        (ref) async* {
  final dashboard = ref.read(walletProvider.notifier);

  yield await dashboard.walletHistory();
});
