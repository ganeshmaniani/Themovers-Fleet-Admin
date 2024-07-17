import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../wallet.dart';

class WalletAmountUseCase {
  final WalletRepository _repository;

  WalletAmountUseCase(this._repository);

  Future<Either<Failure, String>> call() async {
    return await _repository.checkWalletAmount();
  }
}
