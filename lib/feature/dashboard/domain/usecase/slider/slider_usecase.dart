import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../dashboard.dart';

class SliderUseCase {
  final DashboardRepository _repository;

  SliderUseCase(this._repository);

  Future<Either<Failure, DashboardSliderModel>> call() async {
    return await _repository.dashboardCarouselSlider();
  }
}
