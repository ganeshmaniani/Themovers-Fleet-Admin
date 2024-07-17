import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../faq.dart';

class FAQScreen extends ConsumerStatefulWidget {
  static const String id = 'faq_screen';

  const FAQScreen({super.key});

  @override
  ConsumerState<FAQScreen> createState() => _FAQScreenConsumerState();
}

class _FAQScreenConsumerState extends ConsumerState<FAQScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<FaqList> faqList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initialCallback();
  }

  void initialCallback() async {
    WidgetsBinding.instance.addPostFrameCallback((__) {
      setState(() => isLoading = true);

      ref.read(faqProvider.notifier).faqList().then(
            (response) => response.fold(
              (l) => {
                setState(() => {isLoading = false, faqList = []})
              },
              (r) => {
                setState(() => {isLoading = false, faqList = r.faqList ?? []}),
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
                  Text(
                    'Faq',
                    style: context.textTheme.bodyLarge,
                  ),
                ],
              ),
              Dimensions.kVerticalSpaceSmaller,
              isLoading
                  ? const FaqShimmerLoading()
                  : Expanded(
                      child: faqList.isEmpty
                          ? const EmptyListContainer()
                          : ListView.builder(
                              padding: const EdgeInsets.only(bottom: 30),
                              physics: const BouncingScrollPhysics(),
                              itemCount: faqList.length,
                              itemBuilder: (_, i) {
                                return faqCardListUI(faqList[i]);
                              },
                            ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget faqCardListUI(FaqList faq) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.primary),
        ),
        child: ExpansionTile(
          backgroundColor: Colors.white,
          shape: Border.all(color: Colors.transparent),
          title: Text(
            '${faq.id}. ${faq.question}',
            style: context.textTheme.headlineSmall,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child:
                  Text(faq.answer ?? '', style: context.textTheme.bodyMedium),
            )
          ],
        ),
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
