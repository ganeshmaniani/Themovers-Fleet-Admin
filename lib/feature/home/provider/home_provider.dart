import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../feature/feature.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});
