import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth.dart';

final mobileNumberCheckerUseCaseProvider =
    Provider<MobileNumberCheckerUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return MobileNumberCheckerUseCase(authRepository);
});
