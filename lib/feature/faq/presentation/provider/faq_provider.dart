import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../faq.dart';

final faqProvider = StateNotifierProvider<FaqNotifier, FaqState>((ref) {
  final faq = ref.watch(faqUseCaseProvider);
  return FaqNotifier(faq);
});
