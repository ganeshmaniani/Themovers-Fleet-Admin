import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../calendar.dart';

abstract class CalenderDataSource {
  Future<Either<Failure, CalenderListModel>> calenderList(
      CalenderEntities calenderEntities);
}
