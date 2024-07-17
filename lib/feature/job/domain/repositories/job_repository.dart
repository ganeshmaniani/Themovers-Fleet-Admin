import 'package:dartz/dartz.dart';
import 'package:themovers_fleet_admin/core/core.dart';

import '../../../feature.dart';

abstract class JobRepository {
  Future<Either<Failure, JobListModel>> jobList(String stageId);

  Future<Either<Failure, JobDetailModel>> jobDetail(String bookingId);

  Future<Either<Failure, dynamic>> jobUpdate(
      JobStageUpdateEntities jobStageUpdateEntities);

  Future<Either<Failure, dynamic>> jobCompleteStageUpdate(
      JobStageUpdateEntities jobStageUpdateEntities);

  Future<Either<Failure, dynamic>> jobDeleteRequest(
      JobDeleteEntities jobDeleteEntities);

  Future<Either<Failure, dynamic>> updateRating(RatingEntities ratingEntities);

  Future<Either<Failure, BudgetBookingModel>> budgetBookingDetail(
      String bookingId);

  Future<Either<Failure, dynamic>> budgetBookingUpdate(
      BudgetEntities budgetEntities);

  Future<Either<Failure, DisposalBookingModel>> disposalBookingDetail(
      String bookingId);

  Future<Either<Failure, dynamic>> disposalBookingUpdate(
      DisposalEntities disposalEntities);

  Future<Either<Failure, PremiumBookingModel>> premiumBookingDetail(
      String bookingId);

  Future<Either<Failure, dynamic>> premiumBookingUpdate(
      PremiumEntities premiumEntities);

  Future<Either<Failure, dynamic>> additionalServiceUpdate(
      AdditionalServiceEntities additionalServiceEntities);
}
