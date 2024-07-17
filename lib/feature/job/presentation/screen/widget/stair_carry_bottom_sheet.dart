import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../../feature.dart';

class StairCarryBottomSheet extends ConsumerStatefulWidget {
  const StairCarryBottomSheet({super.key});

  @override
  ConsumerState<StairCarryBottomSheet> createState() =>
      _StairCarryBottomSheetConsumerState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _StairCarryBottomSheetConsumerState
    extends ConsumerState<StairCarryBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    int stairCarry = ref.watch(budgetNotifierProvider).stairCarry ?? 0;

    final amount = ref.watch(budgetNotifierProvider).budgetPackage?.stairCase;
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Dimensions.kVerticalSpaceLarge,
            CustomAppBar(
                onPressed: () => _scaffoldKey.currentState?.openDrawer()),
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
                      'Stair Carry',
                      style:
                          textTheme.titleMedium!.copyWith(color: Colors.white),
                    ),
                  ),
                  Dimensions.kVerticalSpaceSmallest,
                  const Text(
                    'Do any of your unit gave access to elevator? Would you require manpower to move small to bulky items up or down a flight of stair?',
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
              padding: const EdgeInsets.symmetric(horizontal: 74),
              child: Container(
                padding: Dimensions.kPaddingAllMedium,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFB30205)),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Text(
                      'Manpower will carefully move small to bulky items using stairs when elevator is not accessible.',
                      textAlign: TextAlign.center,
                      style: textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF000000), fontSize: 12),
                    ),
                    Dimensions.kVerticalSpaceSmall,
                    Text(
                      'MYR $amount',
                      textAlign: TextAlign.center,
                      style: textTheme.headlineLarge
                          ?.copyWith(color: const Color(0xFF444550)),
                    ),
                    Dimensions.kVerticalSpaceSmallest,
                    Text(
                      'Stair Level',
                      textAlign: TextAlign.center,
                      style: textTheme.headlineLarge?.copyWith(
                          color: const Color(0xFF444550),
                          fontWeight: FontWeight.w400),
                    ),
                    Dimensions.kVerticalSpaceSmall,
                    CustomProductCounterCard(
                      limited: true,
                      count: stairCarry,
                      increment: () => setState(
                        stairCarry < 5
                            ? () => {
                                  stairCarry = stairCarry + 1,
                                  ref
                                      .read(budgetNotifierProvider)
                                      .setStairCarry(stairCarry)
                                }
                            : () {},
                      ),
                      decrement: () => setState(
                        stairCarry != 0
                            ? () => {
                                  stairCarry = stairCarry - 1,
                                  ref
                                      .read(budgetNotifierProvider)
                                      .setStairCarry(stairCarry)
                                }
                            : () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
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
