import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../feature.dart';

class JobListUseCase implements UseCase<JobListModel, String> {
  final JobRepository _jobRepository;

  JobListUseCase(this._jobRepository);

  @override
  Future<Either<Failure, JobListModel>> call(String stageId) async {
    return await _jobRepository.jobList(stageId);
  }
}
