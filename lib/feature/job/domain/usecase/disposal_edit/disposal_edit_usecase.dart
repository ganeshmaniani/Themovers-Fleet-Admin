import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../feature.dart';

class DisposalEditUseCase {
  final JobRepository _jobRepository;

  DisposalEditUseCase(this._jobRepository);

  Future<Either<Failure, DisposalBookingModel>> callDisposalBookingDetail(
      String bookingId) async {
    return await _jobRepository.disposalBookingDetail(bookingId);
  }

  Future<Either<Failure, dynamic>> callDisposalBookingUpdate(
      DisposalEntities disposalEntities) async {
    return await _jobRepository.disposalBookingUpdate(disposalEntities);
  }
}
