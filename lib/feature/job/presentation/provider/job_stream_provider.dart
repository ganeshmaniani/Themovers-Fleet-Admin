import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../feature.dart';

final jobListStreamProvider = StreamProvider.autoDispose
    .family<Either<Failure, JobListModel>, String>((ref, stageId) async* {
  final job = ref.read(jobProvider.notifier);
  yield await job.jobList(stageId);
});

final jobDetailStreamProvider = StreamProvider.autoDispose
    .family<Either<Failure, JobDetailModel>, String>((ref, bookingId) async* {
  final job = ref.read(jobProvider.notifier);
  yield await job.jobDetail(bookingId);
});
