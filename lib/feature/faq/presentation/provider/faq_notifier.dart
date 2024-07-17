import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../faq.dart';

class FaqNotifier extends StateNotifier<FaqState> {
  final FaqUseCase _faqUseCase;

  FaqNotifier(this._faqUseCase) : super(const FaqState.initial());

  Future<Either<Failure, FAQListModel>> faqList() async {
    state.copyWith(isLoading: true);
    final result = await _faqUseCase.callFaqList();
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, TermsPoliciesModel>> termAndPolicy() async {
    state.copyWith(isLoading: true);
    final result = await _faqUseCase.callTermAndPolicy();
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, TermsConditionModel>> termAndCondition() async {
    state.copyWith(isLoading: true);
    final result = await _faqUseCase.callTermAndCondition();
    state.copyWith(isLoading: false);
    return result;
  }
}
