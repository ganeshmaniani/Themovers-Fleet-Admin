import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../calendar.dart';

final calenderUseCaseProvider = Provider<CalenderUseCase>((ref) {
  final calenderRepository = ref.watch(calenderRepositoryProvider);
  return CalenderUseCase(calenderRepository);
});
