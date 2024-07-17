import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../calendar.dart';

class CalenderUseCase implements UseCase<CalenderListModel, CalenderEntities> {
  final CalenderRepository _calenderRepository;

  CalenderUseCase(this._calenderRepository);

  @override
  Future<Either<Failure, CalenderListModel>> call(
      CalenderEntities calenderEntities) async {
    return await _calenderRepository.calenderList(calenderEntities);
  }
}
