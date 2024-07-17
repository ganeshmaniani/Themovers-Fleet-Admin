import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../feature.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletDataSource _walletDataSource;

  const WalletRepositoryImpl(this._walletDataSource);

  @override
  Future<Either<Failure, String>> checkWalletAmount() async {
    return await _walletDataSource.checkWalletAmount();
  }

  @override
  Future<Either<Failure, WalletHistoryModel>> getWalletHistory() async {
    return await _walletDataSource.getWalletHistory();
  }

  @override
  Future<Either<Failure, WalletResult>> topUpRequest(
      WalletTopUpEntities walletTopUpEntities) async {
    return await _walletDataSource.topUpRequest(walletTopUpEntities);
  }
}
