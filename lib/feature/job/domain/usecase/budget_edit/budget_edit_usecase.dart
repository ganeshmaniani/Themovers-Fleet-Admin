import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../feature.dart';

class BudgetEditUseCase {
  final JobRepository _jobRepository;

  BudgetEditUseCase(this._jobRepository);

  Future<Either<Failure, BudgetBookingModel>> callBudgetBookingDetail(
      String bookingId) async {
    return await _jobRepository.budgetBookingDetail(bookingId);
  }

  Future<Either<Failure, dynamic>> callBudgetBookingUpdate(
      BudgetEntities budgetEntities) async {
    return await _jobRepository.budgetBookingUpdate(budgetEntities);
  }
}
