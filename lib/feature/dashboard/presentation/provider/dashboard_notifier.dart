import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../dashboard.dart';

class DashboardNotifier extends StateNotifier<DashboardState> {
  final AccountActivationUseCase _activationUseCase;
  final JobStatusUseCase _statusUseCase;
  final SliderUseCase _sliderUseCase;
  final VersionCodeUseCase _versionCodeUseCase;

  DashboardNotifier(this._activationUseCase, this._statusUseCase,
      this._sliderUseCase, this._versionCodeUseCase)
      : super(const DashboardState.initial());

  Future<Either<Failure, AccountResult>> accountActivation() async {
    state.copyWith(isLoading: true);
    final result = await _activationUseCase.call();
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, JobStatusModel>> jobStatus() async {
    state.copyWith(isLoading: true);
    final result = await _statusUseCase.call();
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, DashboardSliderModel>>
      dashboardCarouselSlider() async {
    state.copyWith(isLoading: true);
    final result = await _sliderUseCase.call();
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, VersionModel>> versionCode() async {
    state.copyWith(isLoading: true);
    final result = await _versionCodeUseCase.call();
    state.copyWith(isLoading: false);
    return result;
  }
}
