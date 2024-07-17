import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../faq.dart';

abstract class FaqDataSource {
  Future<Either<Failure, FAQListModel>> faqList();

  Future<Either<Failure, TermsPoliciesModel>> termAndPolicy();

  Future<Either<Failure, TermsConditionModel>> termAndCondition();
}
