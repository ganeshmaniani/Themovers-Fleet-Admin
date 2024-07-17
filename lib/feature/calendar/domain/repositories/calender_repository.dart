import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../calendar.dart';

abstract class CalenderRepository {
  Future<Either<Failure, CalenderListModel>> calenderList(
      CalenderEntities calenderEntities);
}
