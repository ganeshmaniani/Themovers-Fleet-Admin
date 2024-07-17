import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../dashboard.dart';

abstract class DashboardRepository {
  Future<Either<Failure, JobStatusModel>> jobStatusDetail();

  Future<Either<Failure, AccountResult>> checkUserAccountActivation();

  Future<Either<Failure, DashboardSliderModel>> dashboardCarouselSlider();

  Future<Either<Failure, VersionModel>> getVersionCode();
}
