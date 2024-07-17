import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../feature.dart';

class JobUpdateUseCase implements UseCase<dynamic, JobStageUpdateEntities> {
  final JobRepository _jobRepository;

  JobUpdateUseCase(this._jobRepository);

  @override
  Future<Either<Failure, dynamic>> call(
      JobStageUpdateEntities jobStageUpdateEntities) async {
    return await _jobRepository.jobUpdate(jobStageUpdateEntities);
  }
}
