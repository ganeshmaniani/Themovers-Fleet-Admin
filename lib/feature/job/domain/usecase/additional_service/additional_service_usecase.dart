import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../feature.dart';

class AdditionalServiceUseCase
    implements UseCase<dynamic, AdditionalServiceEntities> {
  final JobRepository _jobRepository;

  AdditionalServiceUseCase(this._jobRepository);

  @override
  Future<Either<Failure, dynamic>> call(
      AdditionalServiceEntities additionalServiceEntities) async {
    return await _jobRepository
        .additionalServiceUpdate(additionalServiceEntities);
  }
}
