import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../calendar.dart ';

class CalenderNotifier extends StateNotifier<CalenderState> {
  final CalenderUseCase _calenderUseCase;

  CalenderNotifier(this._calenderUseCase)
      : super(const CalenderState.initial());

  Future<Either<Failure, CalenderListModel>> calenderList(String date) async {
    final calenderEntities = CalenderEntities(fromDate: date, endDate: date);
    state.copyWith(isLoading: true);
    final result = await _calenderUseCase.call(calenderEntities);
    state.copyWith(isLoading: false);
    return result;
  }
}
