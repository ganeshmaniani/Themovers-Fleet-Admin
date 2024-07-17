import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../wallet.dart';

class WalletHistoryUseCase {
  final WalletRepository _repository;

  WalletHistoryUseCase(this._repository);

  Future<Either<Failure, WalletHistoryModel>> call() async {
    return await _repository.getWalletHistory();
  }
}
