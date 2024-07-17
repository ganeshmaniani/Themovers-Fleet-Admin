import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../feature.dart';

final accountStreamProvider =
    StreamProvider<Either<Failure, AccountResult>>((ref) {
  final dashboard = ref.read(dashboardProvider.notifier);

  return dashboard.accountActivation().asStream();
});

final jobStatusProvider =
    StreamProvider.autoDispose<Either<Failure, JobStatusModel>>((ref) async* {
  final dashboard = ref.read(dashboardProvider.notifier);

  yield await dashboard.jobStatus();
});
