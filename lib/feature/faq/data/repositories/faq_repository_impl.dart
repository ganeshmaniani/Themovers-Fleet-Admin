import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../faq.dart';

class FaqRepositoryImpl implements FaqRepository {
  final FaqDataSource _dataSource;

  const FaqRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, FAQListModel>> faqList() async {
    return await _dataSource.faqList();
  }

  @override
  Future<Either<Failure, TermsConditionModel>> termAndCondition() async {
    return await _dataSource.termAndCondition();
  }

  @override
  Future<Either<Failure, TermsPoliciesModel>> termAndPolicy() async {
    return await _dataSource.termAndPolicy();
  }
}
