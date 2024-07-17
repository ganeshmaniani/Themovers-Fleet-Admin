import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../feature.dart';

final jobProvider = StateNotifierProvider<JobNotifier, JobState>((ref) {
  final jobList = ref.watch(jobListCaseProvider);
  final jobDetail = ref.watch(jobDetailUseCaseProvider);
  final jobUpdate = ref.watch(jobUpdateUseCaseProvider);
  final jobComplete = ref.watch(jobCompleteUpdateUseCaseProvider);
  final rating = ref.watch(ratingUseCaseProvider);
  final budgetEdit = ref.watch(budgetEditUseCaseProvider);
  final disposalEdit = ref.watch(disposalEditUseCaseProvider);
  final premiumEdit = ref.watch(premiumEditUseCaseProvider);
  final deleteRequest = ref.watch(deleteRequestUseCaseProvider);
  final additionalService = ref.watch(additionalServiceUseCaseProvider);
  return JobNotifier(jobList, jobDetail, jobUpdate, jobComplete, rating,
      budgetEdit, disposalEdit, premiumEdit, deleteRequest, additionalService);
});

final budgetNotifierProvider =
    ChangeNotifierProvider<BudgetChangeNotifierProvider>((ref) {
  return BudgetChangeNotifierProvider();
});

final premiumNotifierProvider =
    ChangeNotifierProvider<PremiumChangeNotifierProvider>((ref) {
  return PremiumChangeNotifierProvider();
});

final disposalNotifierProvider =
    ChangeNotifierProvider<DisposalChangeNotifierProvider>((ref) {
  return DisposalChangeNotifierProvider();
});
