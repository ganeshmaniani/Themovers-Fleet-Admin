import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../faq.dart';

final faqStreamProvider =
    StreamProvider<Either<Failure, FAQListModel>>((ref) async* {
  final faq = ref.read(faqProvider.notifier);

  yield await faq.faqList();
});

final termAndConditionStreamProvider =
    StreamProvider<Either<Failure, TermsConditionModel>>((ref) async* {
  final faq = ref.read(faqProvider.notifier);

  yield await faq.termAndCondition();
});

final termAndPolicyStreamProvider =
    StreamProvider<Either<Failure, TermsPoliciesModel>>((ref) async* {
  final faq = ref.read(faqProvider.notifier);

  yield await faq.termAndPolicy();
});
