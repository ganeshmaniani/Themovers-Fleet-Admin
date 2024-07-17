import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../feature.dart';

class JobNotifier extends StateNotifier<JobState> {
  final JobListUseCase _jobListUseCase;
  final JobDetailUseCase _jobDetailUseCase;
  final JobUpdateUseCase _jobUpdateUseCase;
  final JobCompleteUpdateUseCase _jobCompleteUpdateUseCase;
  final RatingUseCase _ratingUseCase;
  final BudgetEditUseCase _budgetEditUseCase;
  final DisposalEditUseCase _disposalEditUseCase;
  final PremiumEditUseCase _premiumEditUseCase;
  final DeleteRequestUseCase _deleteRequestUseCase;
  final AdditionalServiceUseCase _additionalServiceUseCase;

  JobNotifier(
    this._jobListUseCase,
    this._jobDetailUseCase,
    this._jobUpdateUseCase,
    this._jobCompleteUpdateUseCase,
    this._ratingUseCase,
    this._budgetEditUseCase,
    this._disposalEditUseCase,
    this._premiumEditUseCase,
    this._deleteRequestUseCase,
    this._additionalServiceUseCase,
  ) : super(const JobState.initial());

  Future<Either<Failure, JobListModel>> jobList(String stageId) async {
    state.copyWith(isLoading: true);
    final result = await _jobListUseCase.call(stageId);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, JobDetailModel>> jobDetail(String bookingId) async {
    state.copyWith(isLoading: true);
    final result = await _jobDetailUseCase.call(bookingId);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, dynamic>> jobUpdate(
      JobStageUpdateEntities jobStageUpdateEntities) async {
    state.copyWith(isLoading: true);
    final result = await _jobUpdateUseCase.call(jobStageUpdateEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, dynamic>> jobCompleteStageUpdate(
      JobStageUpdateEntities jobStageUpdateEntities) async {
    state.copyWith(isLoading: true);
    final result = await _jobCompleteUpdateUseCase.call(jobStageUpdateEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, dynamic>> ratingUpdate(
      RatingEntities ratingEntities) async {
    state.copyWith(isLoading: true);
    final result = await _ratingUseCase.call(ratingEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, BudgetBookingModel>> budgetBookingDetail(
      String bookingId) async {
    state.copyWith(isLoading: true);
    final result = await _budgetEditUseCase.callBudgetBookingDetail(bookingId);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, dynamic>> budgetBookingUpdate(
      BudgetEntities budgetEntities) async {
    state.copyWith(isLoading: true);
    final result =
        await _budgetEditUseCase.callBudgetBookingUpdate(budgetEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, PremiumBookingModel>> premiumBookingDetail(
      String bookingId) async {
    state.copyWith(isLoading: true);
    final result =
        await _premiumEditUseCase.callPremiumBookingDetail(bookingId);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, dynamic>> premiumBookingUpdate(
      PremiumEntities premiumEntities) async {
    state.copyWith(isLoading: true);
    final result =
        await _premiumEditUseCase.callPremiumBookingUpdate(premiumEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, DisposalBookingModel>> disposalBookingDetail(
      String bookingId) async {
    state.copyWith(isLoading: true);
    final result =
        await _disposalEditUseCase.callDisposalBookingDetail(bookingId);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, dynamic>> disposalBookingUpdate(
      DisposalEntities disposalEntities) async {
    state.copyWith(isLoading: true);
    final result =
        await _disposalEditUseCase.callDisposalBookingUpdate(disposalEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, dynamic>> deleteRequest(
      JobDeleteEntities jobDeleteEntities) async {
    state.copyWith(isLoading: true);
    final result = await _deleteRequestUseCase.call(jobDeleteEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, dynamic>> additionalServiceUpdate(
      AdditionalServiceEntities additionalServiceEntities) async {
    state.copyWith(isLoading: true);
    final result =
        await _additionalServiceUseCase.call(additionalServiceEntities);
    state.copyWith(isLoading: false);
    return result;
  }
}
