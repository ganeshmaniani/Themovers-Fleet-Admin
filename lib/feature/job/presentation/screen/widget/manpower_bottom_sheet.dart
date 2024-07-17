import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../../feature.dart';

class ManpowerBottomSheet extends ConsumerStatefulWidget {
  const ManpowerBottomSheet({super.key});

  @override
  ConsumerState<ManpowerBottomSheet> createState() =>
      _ManpowerBottomSheetConsumerState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _ManpowerBottomSheetConsumerState
    extends ConsumerState<ManpowerBottomSheet> {
  void sendResponse(String service, dynamic val) async {
    switch (service) {
      case 'count':
        ref.read(budgetNotifierProvider).setManPowerCount(val);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    int manPowerCount = ref.watch(budgetNotifierProvider).manPowerCount ?? 0;
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
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),
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

                  // Dimensions.kVerticalSpaceLarge,
                  // const CustomBottomSheetAppBar(),

                  // Dimensions.kVerticalSpaceMedium,
                  Dimensions.kVerticalSpaceSmall,
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Color(0xFFB40205),
                    ),
                    child: Text(
                      'Manpower',
                      style:
                          textTheme.titleMedium!.copyWith(color: Colors.white),
                    ),
                  ),
                  Dimensions.kVerticalSpaceSmall,
                  Text(
                      'Experience the most Affordable and seamless Moving service.Choose ',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF000000),
                      )),

                  Dimensions.kVerticalSpaceLarge,
                  customTextCard(
                    title: '1 - ManPower',
                    discription:
                        'The driver is a manpower. Suitable for moving light items such as boxes, chairs, bags, etc.',
                  ),
                  Dimensions.kVerticalSpaceSmallest,
                  customTextCard(
                    title: '2 - ManPower',
                    discription:
                        'Driver and 1 helper. Suitable for moving light items such as boxes, tables, chairs, bags, etc.',
                  ),
                  Dimensions.kVerticalSpaceSmallest,
                  customTextCard(
                    title: '3 - ManPower',
                    discription:
                        'Driver and 2 helpers. Suitable for moving medium items such as refrigerator, tables, small room items, etc.',
                  ),
                  Dimensions.kVerticalSpaceSmallest,
                  customTextCard(
                    title: '4 - ManPower',
                    discription:
                        'Driver and 3 helpers. Suitable for moving heavy items such as refrigerator, wardrobe, piano, house items, etc.',
                  ),
                  Dimensions.kVerticalSpaceSmallest,
                  customTextCard(
                    title: '5 - ManPower',
                    discription:
                        'Driver and 4 helpers. Suitable for moving heavy items such as refrigerator, wardrobe, piano, house items, etc.',
                  ),
                  Dimensions.kVerticalSpaceSmall,
                  CustomProductCounterCard(
                    limited: true,
                    count: manPowerCount,
                    increment: () => setState(
                      manPowerCount < 5
                          ? () => {
                                manPowerCount = manPowerCount + 1,
                                sendResponse('count', manPowerCount),
                              }
                          : () {},
                    ),
                    decrement: () => setState(
                      manPowerCount != 0
                          ? () => {
                                manPowerCount = manPowerCount - 1,
                                sendResponse('count', manPowerCount),
                              }
                          : () {},
                    ),
                  ),
                  Spacer(),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.titleLarge?.copyWith(
                color: const Color(0xFF000000),
                fontSize: 14,
                fontWeight: FontWeight.w700),
          ),
          Dimensions.kVerticalSpaceSmallest,
          Text(
            discription,
            style: textTheme.labelLarge?.copyWith(
                color: Colors.black54,
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
