import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../../feature.dart';

class WrappingBottomSheet extends ConsumerStatefulWidget {
  const WrappingBottomSheet({super.key});

  @override
  ConsumerState<WrappingBottomSheet> createState() =>
      _WrappingBottomSheetConsumerState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _WrappingBottomSheetConsumerState
    extends ConsumerState<WrappingBottomSheet> {
  void sendResponse(String service, int val) async {
    switch (service) {
      case 'shrink':
        ref.read(budgetNotifierProvider).setShrinkWrap(val);
        break;
      case 'bubble':
        ref.read(budgetNotifierProvider).setBubbleWrap(val);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    int shrinkWrapCount = ref.watch(budgetNotifierProvider).shrinkWrap ?? 0;
    int bubbleWrapCount = ref.watch(budgetNotifierProvider).bubbleWrap ?? 0;

    final amount = ref.watch(budgetNotifierProvider).budgetPackage;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Dimensions.kVerticalSpaceLarge,
              CustomAppBar(
                  onPressed: () => _scaffoldKey.currentState?.openDrawer()),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Budget Booking',
                      style: textTheme.headlineMedium!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    Dimensions.kVerticalSpaceSmallest,
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color(0xFFB40205),
                      ),
                      child: Text(
                        'Wrapping',
                        style: textTheme.titleMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    Dimensions.kVerticalSpaceSmallest,
                    const Text(
                      'Protect your items from scratches, damage or dirt during transsit',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF000000),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const Image(
                      image: AssetImage(AppIcon.shrinkWrapping),
                      height: 100,
                      width: 100,
                    ),
                    Dimensions.kVerticalSpaceSmallest,
                    Text(
                      'MYR ${amount?.shrinkWrapping} per roll',
                      style: textTheme.titleLarge
                          ?.copyWith(color: const Color(0xFF000000)),
                    ),
                    Dimensions.kVerticalSpaceSmallest,
                    Text(
                      '50cm (W) x 1000cm (L)',
                      style: textTheme.labelMedium
                          ?.copyWith(color: const Color(0xFF000000)),
                    ),
                    Dimensions.kVerticalSpaceSmallest,
                    const Text(
                      "A clear plastic material used to protect furniture\nand mattress from scratch or dust",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF000000),
                      ),
                    ),
                    Dimensions.kVerticalSpaceSmallest,
                    CustomProductCounterCard(
                      limited: false,
                      count: shrinkWrapCount,
                      increment: () => setState(
                        () => {
                          shrinkWrapCount = shrinkWrapCount + 1,
                          sendResponse('shrink', shrinkWrapCount),
                        },
                      ),
                      decrement: () => setState(
                        () => shrinkWrapCount != 0
                            ? {
                                shrinkWrapCount = shrinkWrapCount - 1,
                                sendResponse('shrink', shrinkWrapCount),
                              }
                            : () {},
                      ),
                    ),
                    Dimensions.kVerticalSpaceMedium,
                    const Image(
                      image: AssetImage(AppIcon.bubbleWrapping),
                      height: 100,
                      width: 100,
                    ),
                    Dimensions.kVerticalSpaceSmallest,
                    Text(
                      'MYR ${amount?.bubbleWrapping} per roll',
                      style: textTheme.titleLarge
                          ?.copyWith(color: const Color(0xFF444550)),
                    ),
                    Dimensions.kVerticalSpaceSmallest,
                    Text(
                      '100cm (W) x 1000cm (L)',
                      style: textTheme.labelMedium
                          ?.copyWith(color: const Color(0xFF000000)),
                    ),
                    Dimensions.kVerticalSpaceSmallest,
                    const Text(
                      "A transparent bubble plastic material used for\npackaging fragile item",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF000000),
                      ),
                    ),
                    Dimensions.kVerticalSpaceSmallest,
                    CustomProductCounterCard(
                      limited: false,
                      count: bubbleWrapCount,
                      increment: () => setState(() => {
                            bubbleWrapCount = bubbleWrapCount + 1,
                            sendResponse('bubble', bubbleWrapCount),
                          }),
                      decrement: () => setState(
                        () => bubbleWrapCount != 0
                            ? {
                                bubbleWrapCount = bubbleWrapCount - 1,
                                sendResponse('bubble', bubbleWrapCount),
                              }
                            : () {},
                      ),
                    ),
                    const SizedBox(height: 16),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  optionDetailCard({required String title, required String discription}) {
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
