import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../faq.dart';

final faqDatasourceProvider = Provider<FaqDataSource>((ref) {
  final apiServices = ref.watch(networkProvider);
  return FaqDataSourceImpl(apiServices);
});
