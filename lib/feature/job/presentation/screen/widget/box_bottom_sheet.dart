import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../../feature.dart';

class BoxBottomSheet extends ConsumerStatefulWidget {
  const BoxBottomSheet({super.key});

  @override
  ConsumerState<BoxBottomSheet> createState() => _BoxBottomSheetConsumerState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _BoxBottomSheetConsumerState extends ConsumerState<BoxBottomSheet> {
  void sendResponse(String service, dynamic val) async {
    switch (service) {
      case 'count':
        ref.read(budgetNotifierProvider).setBoxCount(val);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    int boxCount = ref.watch(budgetNotifierProvider).boxCount ?? 0;

    final amount = ref.watch(budgetNotifierProvider).budgetPackage;
    final textTheme = context.textTheme;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Dimensions.kVerticalSpaceLarge,
            CustomAppBar(
                onPressed: () => _scaffoldKey.currentState?.openDrawer()),
            Container(
              height: MediaQuery.of(context).size.height,
              padding: Dimensions.kPaddingAllMedium,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Budget Booking',
                    style: textTheme.headlineMedium!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  Dimensions.kVerticalSpaceSmall,
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Color(0xFFB40205),
                    ),
                    child: Text(
                      'Boxes (Any Size)',
                      style:
                          textTheme.titleMedium!.copyWith(color: Colors.white),
                    ),
                  ),
                  Dimensions.kVerticalSpaceSmall,
                  Text(
                      'Protect your items from scratches, damage or dirt during transsit',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF000000),
                      )),
                  Dimensions.kVerticalSpaceLarge,
                  CustomProductCounterCard(
                    limited: false,
                    count: boxCount,
                    increment: () => setState(
                      () => {
                        boxCount = boxCount + 1,
                        sendResponse('count', boxCount),
                      },
                    ),
                    decrement: () => setState(
                      boxCount != 0
                          ? () => {
                                boxCount = boxCount - 1,
                                sendResponse('count', boxCount),
                              }
                          : () {},
                    ),
                  ),
                  Spacer(),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "MYR ${amount!.boxCount.toString()}",
                          style: context.textTheme.titleLarge?.copyWith(
                              color: const Color(0xFF000000), fontSize: 30),
                        ),
                        Text(
                          "per box",
                          style: context.textTheme.titleLarge?.copyWith(
                            color: const Color(0xFF000000),
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Dimensions.kVerticalSpaceLarge,
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: const Color(0xFFB40205),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'Done',
                        style: context.textTheme.bodySmall
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  Dimensions.kVerticalSpaceLargest,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  customTextCard({required String title, required String discription}) {
    final textTheme = context.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleLarge?.copyWith(color: const Color(0xFF444550)),
        ),
        Dimensions.kVerticalSpaceSmallest,
        Text(
          discription,
          style: textTheme.labelLarge?.copyWith(color: Colors.black54),
        ),
      ],
    );
  }
}
