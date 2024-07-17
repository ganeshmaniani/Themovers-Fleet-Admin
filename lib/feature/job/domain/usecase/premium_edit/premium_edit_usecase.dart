import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../feature.dart';

class PremiumEditUseCase {
  final JobRepository _jobRepository;

  PremiumEditUseCase(this._jobRepository);

  Future<Either<Failure, PremiumBookingModel>> callPremiumBookingDetail(
      String bookingId) async {
    return await _jobRepository.premiumBookingDetail(bookingId);
  }

  Future<Either<Failure, dynamic>> callPremiumBookingUpdate(
      PremiumEntities premiumEntities) async {
    return await _jobRepository.premiumBookingUpdate(premiumEntities);
  }
}
