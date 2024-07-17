import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../faq.dart';

class TermPolicyScreen extends ConsumerStatefulWidget {
  static const String id = 'term_and_policy_screen';

  const TermPolicyScreen({super.key});

  @override
  ConsumerState<TermPolicyScreen> createState() =>
      _TermPolicyScreenConsumerState();
}

class _TermPolicyScreenConsumerState extends ConsumerState<TermPolicyScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<TermsPolicies> termsPolicies = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initialCallback();
  }

  void initialCallback() async {
    WidgetsBinding.instance.addPostFrameCallback((__) {
      setState(() => isLoading = true);

      ref.read(faqProvider.notifier).termAndPolicy().then(
            (response) => response.fold(
              (l) => {
                setState(() => {isLoading = false, termsPolicies = []})
              },
              (r) => {
                setState(() =>
                    {isLoading = false, termsPolicies = r.termsPolicies ?? []}),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Dimensions.kDivider,
              Row(
                children: [
                  Text('Privacy Policies', style: context.textTheme.bodyLarge),
                ],
              ),
              Dimensions.kVerticalSpaceSmaller,
              isLoading
                  ? const Expanded(
                      child: Center(child: CircularProgressIndicator()))
                  : Expanded(
                      child: termsPolicies.isEmpty
                          ? const EmptyListContainer()
                          : ListView.builder(
                              padding: const EdgeInsets.only(bottom: 30),
                              physics: const BouncingScrollPhysics(),
                              itemCount: termsPolicies.length,
                              itemBuilder: (_, i) {
                                return termAndPolicyListUI(termsPolicies[i]);
                              },
                            ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget termAndPolicyListUI(TermsPolicies terms) {
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

  Widget faqListEmpty() {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [],
      ),
    );
  }
}
