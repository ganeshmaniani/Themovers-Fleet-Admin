import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../feature.dart';

class DeleteRequestUseCase implements UseCase<dynamic, JobDeleteEntities> {
  final JobRepository _jobRepository;

  DeleteRequestUseCase(this._jobRepository);

  @override
  Future<Either<Failure, dynamic>> call(
      JobDeleteEntities jobDeleteEntities) async {
    return await _jobRepository.jobDeleteRequest(jobDeleteEntities);
  }
}
