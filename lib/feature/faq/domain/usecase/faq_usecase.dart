import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../faq.dart';

class FaqUseCase {
  final FaqRepository _faqRepository;

  FaqUseCase(this._faqRepository);

  Future<Either<Failure, FAQListModel>> callFaqList() async {
    return await _faqRepository.faqList();
  }

  Future<Either<Failure, TermsPoliciesModel>> callTermAndPolicy() async {
    return await _faqRepository.termAndPolicy();
  }

  Future<Either<Failure, TermsConditionModel>> callTermAndCondition() async {
    return await _faqRepository.termAndCondition();
  }
}
