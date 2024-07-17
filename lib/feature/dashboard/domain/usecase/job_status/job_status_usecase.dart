import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../dashboard.dart';

class JobStatusUseCase {
  final DashboardRepository _repository;

  JobStatusUseCase(this._repository);

  Future<Either<Failure, JobStatusModel>> call() async {
    return await _repository.jobStatusDetail();
  }
}
