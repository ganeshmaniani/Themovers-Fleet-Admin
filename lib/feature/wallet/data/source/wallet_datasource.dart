import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../feature.dart';

abstract class WalletDataSource {
  Future<Either<Failure, String>> checkWalletAmount();

  Future<Either<Failure, WalletHistoryModel>> getWalletHistory();

  Future<Either<Failure, WalletResult>> topUpRequest(
      WalletTopUpEntities walletTopUpEntities);
}
