import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../dashboard.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardDataSource _dashboardDataSource;

  DashboardRepositoryImpl(this._dashboardDataSource);

  @override
  Future<Either<Failure, AccountResult>> checkUserAccountActivation() async {
    return await _dashboardDataSource.checkUserAccountActivation();
  }

  @override
  Future<Either<Failure, JobStatusModel>> jobStatusDetail() async {
    return await _dashboardDataSource.jobStatusDetail();
  }

  @override
  Future<Either<Failure, DashboardSliderModel>>
      dashboardCarouselSlider() async {
    return await _dashboardDataSource.dashboardCarouselSlider();
  }

  @override
  Future<Either<Failure, VersionModel>> getVersionCode() async {
    return await _dashboardDataSource.getVersionCode();
  }
}
