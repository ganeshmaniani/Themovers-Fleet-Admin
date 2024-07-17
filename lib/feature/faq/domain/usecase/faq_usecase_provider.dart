import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../faq.dart';

final faqUseCaseProvider = Provider<FaqUseCase>((ref) {
  final calenderRepository = ref.watch(faqRepositoryProvider);
  return FaqUseCase(calenderRepository);
});
