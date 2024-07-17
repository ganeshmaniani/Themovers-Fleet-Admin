import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../feature.dart';

class TopUpRequestUseCase
    implements UseCase<WalletResult, WalletTopUpEntities> {
  final WalletRepository _walletRepository;

  TopUpRequestUseCase(this._walletRepository);

  @override
  Future<Either<Failure, WalletResult>> call(
      WalletTopUpEntities walletTopUpEntities) async {
    return await _walletRepository.topUpRequest(walletTopUpEntities);
  }
}
