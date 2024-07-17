import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core.dart';

final networkProvider = Provider<BaseNetworkApi>((ref) {
  return BaseNetworkApiImpl();
});
