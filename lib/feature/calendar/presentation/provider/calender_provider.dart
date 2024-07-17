import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../calendar.dart ';

final calenderProvider =
    StateNotifierProvider<CalenderNotifier, CalenderState>((ref) {
  final calenderUseCase = ref.watch(calenderUseCaseProvider);
  return CalenderNotifier(calenderUseCase);
});
