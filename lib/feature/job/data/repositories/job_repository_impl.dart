import 'package:dartz/dartz.dart';
import 'package:themovers_fleet_admin/core/errors/failure.dart';

import '../../../feature.dart';

class JobRepositoryImpl implements JobRepository {
  final JobDataSource _jobDataSource;

  const JobRepositoryImpl(this._jobDataSource);

  @override
  Future<Either<Failure, JobDetailModel>> jobDetail(String bookingId) async {
    return await _jobDataSource.jobDetail(bookingId);
  }

  @override
  Future<Either<Failure, JobListModel>> jobList(String stageId) async {
    return await _jobDataSource.jobList(stageId);
  }

  @override
  Future<Either<Failure, dynamic>> jobUpdate(
      JobStageUpdateEntities jobStageUpdateEntities) async {
    return await _jobDataSource.jobUpdate(jobStageUpdateEntities);
  }

  @override
  Future<Either<Failure, dynamic>> jobCompleteStageUpdate(
      JobStageUpdateEntities jobStageUpdateEntities) async {
    return await _jobDataSource.jobCompleteStageUpdate(jobStageUpdateEntities);
  }

  @override
  Future<Either<Failure, dynamic>> updateRating(
      RatingEntities ratingEntities) async {
    return await _jobDataSource.updateRating(ratingEntities);
  }

  @override
  Future<Either<Failure, BudgetBookingModel>> budgetBookingDetail(
      String bookingId) async {
    return await _jobDataSource.budgetBookingDetail(bookingId);
  }

  @override
  Future<Either<Failure, dynamic>> budgetBookingUpdate(
      BudgetEntities budgetEntities) async {
    return await _jobDataSource.budgetBookingUpdate(budgetEntities);
  }

  @override
  Future<Either<Failure, dynamic>> disposalBookingUpdate(
      DisposalEntities disposalEntities) async {
    return await _jobDataSource.disposalBookingUpdate(disposalEntities);
  }

  @override
  Future<Either<Failure, DisposalBookingModel>> disposalBookingDetail(
      String bookingId) async {
    return await _jobDataSource.disposalBookingDetail(bookingId);
  }

  @override
  Future<Either<Failure, dynamic>> premiumBookingUpdate(
      PremiumEntities premiumEntities) async {
    return await _jobDataSource.premiumBookingUpdate(premiumEntities);
  }

  @override
  Future<Either<Failure, PremiumBookingModel>> premiumBookingDetail(
      String bookingId) async {
    return await _jobDataSource.premiumBookingDetail(bookingId);
  }

  // @override
  // Future<Either<Failure, PremiumLongpushTypeModel>>
  //     premiumLongPushType() async {
  //   return await _jobDataSource.premiumLongPushType();
  // }

  // @override
  // Future<Either<Failure, PremiumPackageModel>> premiumPackage() async {
  //   return await _jobDataSource.premiumPackage();
  // }

  // @override
  // Future<Either<Failure, VehicleTypeModel>> vehicleType() async {
  //   return await _jobDataSource.vehicleType();
  // }

  @override
  Future<Either<Failure, dynamic>> jobDeleteRequest(
      JobDeleteEntities jobDeleteEntities) async {
    return await _jobDataSource.jobDeleteRequest(jobDeleteEntities);
  }

  @override
  Future<Either<Failure, dynamic>> additionalServiceUpdate(
      AdditionalServiceEntities additionalServiceEntities) async {
    return await _jobDataSource
        .additionalServiceUpdate(additionalServiceEntities);
  }
}
