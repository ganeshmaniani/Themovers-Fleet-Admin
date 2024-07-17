import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../../feature.dart';

class LongPushBottomSheet extends ConsumerStatefulWidget {
  const LongPushBottomSheet({super.key});

  @override
  ConsumerState<LongPushBottomSheet> createState() =>
      _LongPushBottomSheetConsumerState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _LongPushBottomSheetConsumerState
    extends ConsumerState<LongPushBottomSheet> {
  void longPushTypeList(List<LongPushTypeList> type) async {
    ref.read(budgetNotifierProvider).setLongPushType(type);
  }

  void longPushSelectedIndex(int index) async {
    ref.read(budgetNotifierProvider).setLongPushIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    int selectedIndex = ref.watch(budgetNotifierProvider).longPush ?? 0;
    final longPushType = ref.watch(budgetNotifierProvider).longPushType ?? [];
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Dimensions.kVerticalSpaceLarge,
            CustomAppBar(
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),
            Padding(
              padding: Dimensions.kPaddingAllMedium,
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Color(0xFFB40205),
                    ),
                    child: Text(
                      'Long Push',
                      style:
                          textTheme.titleMedium!.copyWith(color: Colors.white),
                    ),
                  ),
                  Dimensions.kVerticalSpaceSmallest,
                  const Text(
                    'Do any of your units have access to the loading / unloading area.',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF000000),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: longPushType.length,
                padding: Dimensions.kPaddingAllMedium,
                itemBuilder: (_, i) {
                  final res = i + 1;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 74),
                    child: GestureDetector(
                      onTap: () => setState(() => {
                            if (selectedIndex == res)
                              {
                                longPushSelectedIndex(0),
                                // longPushTypeList([]),
                              }
                            else
                              {
                                longPushSelectedIndex(res),
                                longPushTypeList(longPushType),
                              }
                          }),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: Dimensions.kPaddingAllMedium,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFB30205)),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          Dimensions.kBorderRadiusAllSmallest,
                                      border: Border.all(
                                        width: 2,
                                        color: selectedIndex == res
                                            ? context.colorScheme.primary
                                            : const Color(0xFF969696),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 2,
                                  right: 2,
                                  child: selectedIndex == res
                                      ? Image(
                                          image: const AssetImage(
                                              AppIcon.checkMark),
                                          width: Dimensions.iconSizeSmall,
                                          color: context.colorScheme.primary,
                                        )
                                      : const SizedBox(),
                                ),
                              ],
                            ),
                            Dimensions.kHorizontalSpaceSmall,
                            Text(
                              longPushType[i].description ?? '',
                              textAlign: TextAlign.center,
                              style: textTheme.headlineMedium
                                  ?.copyWith(color: const Color(0xFF444550)),
                            ),
                            Dimensions.kVerticalSpaceSmallest,
                            Text(
                              'MYR ${longPushType[i].rate}',
                              textAlign: TextAlign.center,
                              style: textTheme.headlineMedium?.copyWith(
                                  color: const Color(0xFF444550),
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                alignment: Alignment.center,
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
    );
  }
}
