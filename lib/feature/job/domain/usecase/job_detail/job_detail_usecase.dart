import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../feature.dart';

class JobDetailUseCase implements UseCase<JobDetailModel, String> {
  final JobRepository _jobRepository;

  JobDetailUseCase(this._jobRepository);

  @override
  Future<Either<Failure, JobDetailModel>> call(String bookingId) async {
    return await _jobRepository.jobDetail(bookingId);
  }
}
