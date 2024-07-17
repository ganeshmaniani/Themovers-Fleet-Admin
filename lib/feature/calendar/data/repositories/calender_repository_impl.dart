import 'package:dartz/dartz.dart';
import 'package:themovers_fleet_admin/core/errors/failure.dart';

import '../../calendar.dart';

class CalenderRepositoryImpl implements CalenderRepository {
  final CalenderDataSource _calenderDataSource;

  const CalenderRepositoryImpl(this._calenderDataSource);

  @override
  Future<Either<Failure, CalenderListModel>> calenderList(
      CalenderEntities calenderEntities) async {
    return await _calenderDataSource.calenderList(calenderEntities);
  }
}
