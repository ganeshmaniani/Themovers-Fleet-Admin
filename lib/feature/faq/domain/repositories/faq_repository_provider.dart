import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../faq.dart';

final faqRepositoryProvider = Provider<FaqRepository>((ref) {
  final remoteDataSource = ref.watch(faqDatasourceProvider);
  return FaqRepositoryImpl(remoteDataSource);
});
