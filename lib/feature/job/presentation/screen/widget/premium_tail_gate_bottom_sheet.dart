import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../../feature.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class PremiumTailGateBottomSheet extends ConsumerWidget {
  const PremiumTailGateBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = context.textTheme;
    bool isAgree = ref.watch(premiumNotifierProvider).tailGate ?? false;
    final amount = ref.watch(premiumNotifierProvider).premiumPackage?.stairCase;

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
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),
            Padding(
              padding: Dimensions.kPaddingAllMedium,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Premium Booking',
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
                      'Tail Gate',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 74),
              child: GestureDetector(
                onTap: isAgree != true
                    ? () => {
                          isAgree = !isAgree,
                          ref
                              .read(premiumNotifierProvider)
                              .setTailGate(isAgree),
                        }
                    : () => {
                          isAgree = !isAgree,
                          ref
                              .read(premiumNotifierProvider)
                              .setTailGate(isAgree),
                        },
                child: Container(
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
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    Dimensions.kBorderRadiusAllSmallest,
                                border: Border.all(
                                  width: 2,
                                  color: isAgree
                                      ? context.colorScheme.primary
                                      : const Color(0xFF969696),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 2,
                            right: 2,
                            child: isAgree
                                ? Image(
                                    image: const AssetImage(AppIcon.checkMark),
                                    width: Dimensions.iconSizeSmall,
                                    color: context.colorScheme.primary,
                                  )
                                : const SizedBox(),
                          ),
                        ],
                      ),
                      Dimensions.kHorizontalSpaceSmall,
                      Text(
                        'Manpower will carefully move small to bulky items using stairs when elevator is not accessible',
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
                        'Tail Gate',
                        textAlign: TextAlign.center,
                        style: textTheme.headlineLarge?.copyWith(
                            color: const Color(0xFF444550),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
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
