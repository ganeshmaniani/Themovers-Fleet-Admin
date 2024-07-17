import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../feature.dart';

final userDetailStreamProvider =
    StreamProvider.autoDispose<Either<Failure, UserDetailModel>>((ref) async* {
  final dashboard = ref.read(accountProvider.notifier);

  yield await dashboard.userDetail();
});
