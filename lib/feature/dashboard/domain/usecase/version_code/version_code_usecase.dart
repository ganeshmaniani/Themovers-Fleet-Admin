import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../dashboard.dart';

class VersionCodeUseCase {
  final DashboardRepository _repository;

  VersionCodeUseCase(this._repository);

  Future<Either<Failure, VersionModel>> call() async {
    return await _repository.getVersionCode();
  }
}
