import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../faq.dart';

class TermConditionScreen extends ConsumerStatefulWidget {
  static const String id = 'term_and_condition_screen';

  const TermConditionScreen({super.key});

  @override
  ConsumerState<TermConditionScreen> createState() =>
      _TermConditionScreenConsumerState();
}

class _TermConditionScreenConsumerState
    extends ConsumerState<TermConditionScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<TermsCondition> termsCondition = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initialCallback();
  }

  void initialCallback() async {
    WidgetsBinding.instance.addPostFrameCallback((__) {
      setState(() => isLoading = true);

      ref.read(faqProvider.notifier).termAndCondition().then(
            (response) => response.fold(
              (l) => {
                setState(() => {isLoading = false, termsCondition = []})
              },
              (r) => {
                setState(() => {
                      isLoading = false,
                      termsCondition = r.termsCondition ?? []
                    }),
              },
            ),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      appBar: PreferredSize(
        preferredSize: Size(context.deviceSize.width, 50),
        child: CustomAppBar(
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          width: context.deviceSize.width,
          height: context.deviceSize.height / 1.08,
          padding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Dimensions.kDivider,
              Row(
                children: [
                  Text(
                    'Terms & Conditions',
                    style: context.textTheme.bodyLarge,
                  ),
                ],
              ),
              Dimensions.kVerticalSpaceSmaller,
              isLoading
                  ? const Expanded(
                      child: Center(child: CircularProgressIndicator()))
                  : Expanded(
                      child: termsCondition.isEmpty
                          ? const EmptyListContainer()
                          : ListView.builder(
                              padding: const EdgeInsets.only(bottom: 30),
                              physics: const BouncingScrollPhysics(),
                              itemCount: termsCondition.length,
                              itemBuilder: (_, i) {
                                return termAndConditionListUI(
                                    termsCondition[i]);
                              },
                            ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget termAndConditionListUI(TermsCondition terms) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(terms.titleName ?? '', style: context.textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(terms.value ?? '', style: context.textTheme.bodySmall),
        ],
      ),
    );
  }
}
