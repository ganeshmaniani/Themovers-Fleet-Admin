import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../feature.dart';

class RatingUseCase implements UseCase<dynamic, RatingEntities> {
  final JobRepository _jobRepository;

  RatingUseCase(this._jobRepository);

  @override
  Future<Either<Failure, dynamic>> call(RatingEntities ratingEntities) async {
    return await _jobRepository.updateRating(ratingEntities);
  }
}
