import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../feature.dart';

class NotificationJobDetailScreen extends ConsumerStatefulWidget {
  static const String id = 'notification_alert_screen';
  final String bookingId;

  const NotificationJobDetailScreen({super.key, required this.bookingId});

  @override
  ConsumerState<NotificationJobDetailScreen> createState() =>
      _NotificationJobDetailScreenConsumerState();
}

class _NotificationJobDetailScreenConsumerState
    extends ConsumerState<NotificationJobDetailScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();

  void deleteRequest() {
    AppAlerts.showBookingCancelQueryAlert(
      context,
      controller: _controller,
      onPressed: () {
        Navigator.of(context).pop();
        AppAlerts.showBookingCancelAlert(context, onPressed: () {
          Navigator.of(context).pop();
        });
      },
    );
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
        child: SizedBox(
          width: context.deviceSize.width,
          height: context.deviceSize.height / 1.08,
          child: Consumer(
            builder: (context, ref, child) {
              AsyncValue leagueInfo =
                  ref.watch(jobDetailStreamProvider(widget.bookingId));
              return leagueInfo.when(
                data: (response) {
                  JobDetail jobDetail = JobDetail();
                  response.fold((l) => {jobDetail = JobDetail()},
                      (r) => {jobDetail = r.jobDetail});
                  return Padding(
                    padding: Dimensions.kPaddingAllMedium,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${jobDetail.serviceType} Booking",
                              style: context.textTheme.headlineMedium?.copyWith(
                                color: AppColor.accentText,
                              ),
                            ),
                            Dimensions.kSpacer,
                            Text(
                              jobDetail.createdAt ?? '',
                              style: context.textTheme.labelLarge,
                            ),
                          ],
                        ),
                        Dimensions.kDivider,
                        Expanded(
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            children: [
                              addressDetailCardUI(jobDetail),
                              Dimensions.kVerticalSpaceSmaller,
                              "${jobDetail.serviceType} Booking" !=
                                      "Manpower Booking"
                                  ? vehicleDetailCardUI(jobDetail)
                                  : manpowerDetailCardUI(jobDetail),
                              "${jobDetail.serviceType} Booking" !=
                                      "Manpower Booking"
                                  ? Dimensions.kVerticalSpaceSmaller
                                  : Dimensions.kVerticalSpaceSmaller,
                              "${jobDetail.serviceType} Booking" ==
                                          "Budget Booking" ||
                                      "${jobDetail.serviceType} Booking" ==
                                          "Premium Booking"
                                  ? additionalServiceDetailCardUI(jobDetail)
                                  : const EmptyContainer(),
                              "${jobDetail.serviceType} Booking" ==
                                          "Budget Booking" ||
                                      "${jobDetail.serviceType} Booking" ==
                                          "Premium Booking"
                                  ? Dimensions.kVerticalSpaceSmaller
                                  : const EmptyContainer(),
                              totalAmountDetailCardUI(jobDetail),
                              Dimensions.kVerticalSpaceMedium,
                              CustomSliderButton(
                                width: context.deviceSize.width / 1.20,
                                height: 60,
                                text: 'Accept Job',
                                stageId: "1",
                                bookingId: widget.bookingId,
                                isNotification: false,
                              ),
                              Dimensions.kVerticalSpaceMedium,
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                loading: () => const JobDetailShimmerLoading(),
                error: (err, stack) => const EmptyContainer(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget customerDetailCardUI(JobDetail jobDetail) {
    return CardContainer(
      isTrue: true,
      topChild: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'Customer Details',
          style: context.textTheme.bodySmall?.copyWith(
            color: AppColor.secondaryText,
          ),
        ),
      ),
      bottomChild: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jobDetail.customerName ?? '',
                    style: context.textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w900),
                  ),
                  Text(
                    jobDetail.customerMobileNumber ?? '',
                    style: context.textTheme.labelLarge,
                  ),
                  Text(
                    jobDetail.customerEmailId ?? '',
                    style: context.textTheme.labelLarge,
                  ),
                ],
              ),
            ),
            Dimensions.kHorizontalSpaceSmaller,
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColor.cyanBlue,
                borderRadius: Dimensions.kBorderRadiusAllLarge,
                border: Border.all(
                  color: AppColor.primary,
                  width: 2,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget addressDetailCardUI(JobDetail jobDetail) {
    return CardContainer(
      isTrue: true,
      topChild: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'Address Details',
          style: context.textTheme.bodySmall?.copyWith(
            color: AppColor.secondaryText,
          ),
        ),
      ),
      bottomChild: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  jobDetail.pickupAddress == null
                      ? const EmptyContainer()
                      : AddressCardContainer(
                          isFirst: true,
                          isLast:
                              jobDetail.dropOffAddress == null ? true : false,
                          isPass: false,
                          child: RichText(
                            text: TextSpan(
                              text: 'Pickup Address',
                              style: context.textTheme.labelMedium
                                  ?.copyWith(fontWeight: FontWeight.w900),
                              children: [
                                const TextSpan(text: '\n'),
                                TextSpan(
                                  text: jobDetail.pickupAddress ?? '',
                                  style: context.textTheme.labelMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                  jobDetail.dropOffAddress == null
                      ? const EmptyContainer()
                      : AddressCardContainer(
                          isFirst:
                              jobDetail.pickupAddress == null ? true : false,
                          isLast: true,
                          isPass: false,
                          child: RichText(
                            text: TextSpan(
                              text: 'Drop off Address',
                              style: context.textTheme.labelMedium
                                  ?.copyWith(fontWeight: FontWeight.w900),
                              children: [
                                const TextSpan(text: '\n'),
                                TextSpan(
                                  text: jobDetail.dropOffAddress ?? '',
                                  style: context.textTheme.labelMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
            Dimensions.kHorizontalSpaceSmaller,
            jobDetail.distance == null
                ? const EmptyContainer()
                : RichText(
                    text: TextSpan(
                      text: 'Distance',
                      style: context.textTheme.labelMedium,
                      children: [
                        const TextSpan(text: '\n'),
                        TextSpan(
                          text: "${jobDetail.distance} Km",
                          style: context.textTheme.headlineLarge
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget vehicleDetailCardUI(JobDetail jobDetail) {
    return CardContainer(
      isTrue: true,
      topChild: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'Lorry Size',
          style: context.textTheme.bodySmall?.copyWith(
            color: AppColor.secondaryText,
          ),
        ),
      ),
      bottomChild: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                jobDetail.vehicleType ?? '',
                style: context.textTheme.displayMedium
                    ?.copyWith(fontWeight: FontWeight.w900),
              ),
            ),
            SvgPicture.asset(AppSvg.vehicleSize, width: 70),
          ],
        ),
      ),
    );
  }

  Widget manpowerDetailCardUI(JobDetail jobDetail) {
    return CardContainer(
      isTrue: true,
      topChild: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'Manpower Detail',
          style: context.textTheme.bodySmall?.copyWith(
            color: AppColor.secondaryText,
          ),
        ),
      ),
      bottomChild: Padding(
        padding: const EdgeInsets.only(left: 12, right: 16, bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              jobDetail.manpowerCount == null
                  ? ''
                  : "${jobDetail.manpowerCount} Manpower",
              style: context.textTheme.displayMedium
                  ?.copyWith(fontWeight: FontWeight.w900),
            ),
            Dimensions.kSpacer,
            const Image(
              image: AssetImage(AppIcon.manpowerPackage),
              width: 70,
            ),
          ],
        ),
      ),
    );
  }

  Widget additionalServiceDetailCardUI(JobDetail jobDetail) {
    return CardContainer(
      isTrue: true,
      topChild: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'Additional Services',
          style: context.textTheme.bodySmall?.copyWith(
            color: AppColor.secondaryText,
          ),
        ),
      ),
      bottomChild: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            jobDetail.manpowerCount == null ||
                    jobDetail.manpowerCount == 0 ||
                    "${jobDetail.serviceType} Booking" == "Premium Booking"
                ? const EmptyContainer()
                : IconBox(
                    label: 'Manpower',
                    icon: AppIcon.manpower,
                    value: 'x${jobDetail.manpowerCount}',
                  ),
            jobDetail.manpowerCount == null ||
                    jobDetail.manpowerCount == 0 ||
                    "${jobDetail.serviceType} Booking" == "Premium Booking"
                ? const EmptyContainer()
                : const SizedBox(width: 8),
            jobDetail.boxCount == null ||
                    jobDetail.boxCount == 0 ||
                    "${jobDetail.serviceType} Booking" == "Premium Booking"
                ? const EmptyContainer()
                : IconBox(
                    label: 'Boxes',
                    icon: AppIcon.box,
                    value: 'x${jobDetail.boxCount}',
                  ),
            jobDetail.boxCount == null ||
                    jobDetail.boxCount == 0 ||
                    "${jobDetail.serviceType} Booking" == "Premium Booking"
                ? const EmptyContainer()
                : const SizedBox(width: 8),
            jobDetail.shrinkWrapping == null ||
                    jobDetail.shrinkWrapping == 'No' ||
                    "${jobDetail.serviceType} Booking" == "Premium Booking"
                ? const EmptyContainer()
                : IconBox(
                    label: 'Shrink Wrapping',
                    icon: AppIcon.shrinkWrapping,
                    value: 'x${jobDetail.shrinkWrapping}',
                  ),
            jobDetail.shrinkWrapping == null ||
                    jobDetail.shrinkWrapping == 'No' ||
                    "${jobDetail.serviceType} Booking" == "Premium Booking"
                ? const EmptyContainer()
                : const SizedBox(width: 8),
            jobDetail.bubbleWrapping == null ||
                    jobDetail.bubbleWrapping == 'No' ||
                    "${jobDetail.serviceType} Booking" == "Premium Booking"
                ? const EmptyContainer()
                : IconBox(
                    label: 'Bubble Wrapping',
                    icon: AppIcon.bubbleWrapping,
                    value: 'x${jobDetail.bubbleWrapping}',
                  ),
            jobDetail.bubbleWrapping == null ||
                    jobDetail.bubbleWrapping == 'No' ||
                    "${jobDetail.serviceType} Booking" == "Premium Booking"
                ? const EmptyContainer()
                : const SizedBox(width: 8),
            jobDetail.bedCount == null ||
                    jobDetail.bedCount == 0 ||
                    "${jobDetail.serviceType} Booking" == "Premium Booking"
                ? const EmptyContainer()
                : IconBox(
                    label: 'Bed',
                    icon: AppIcon.bed,
                    value: 'x${jobDetail.bedCount}',
                  ),
            jobDetail.bedCount == null ||
                    jobDetail.bedCount == 0 ||
                    "${jobDetail.serviceType} Booking" == "Premium Booking"
                ? const EmptyContainer()
                : const SizedBox(width: 8),
            jobDetail.wardrobeCount == null ||
                    jobDetail.wardrobeCount == 0 ||
                    "${jobDetail.serviceType} Booking" == "Premium Booking"
                ? const EmptyContainer()
                : IconBox(
                    label: 'Wardrobe',
                    icon: AppIcon.wardrobe,
                    value: 'x${jobDetail.wardrobeCount}',
                  ),
            jobDetail.wardrobeCount == null ||
                    jobDetail.wardrobeCount == 0 ||
                    "${jobDetail.serviceType} Booking" == "Premium Booking"
                ? const EmptyContainer()
                : const SizedBox(width: 8),
            jobDetail.tableCount == null ||
                    jobDetail.tableCount == 0 ||
                    "${jobDetail.serviceType} Booking" == "Premium Booking"
                ? const EmptyContainer()
                : IconBox(
                    label: 'Office Table',
                    icon: AppIcon.officeTable,
                    value: 'x${jobDetail.tableCount}',
                  ),
            jobDetail.tableCount == null ||
                    jobDetail.tableCount == 0 ||
                    "${jobDetail.serviceType} Booking" == "Premium Booking"
                ? const EmptyContainer()
                : const SizedBox(width: 8),
            jobDetail.diningTableCount == null ||
                    jobDetail.diningTableCount == 0 ||
                    "${jobDetail.serviceType} Booking" == "Premium Booking"
                ? const EmptyContainer()
                : IconBox(
                    label: 'Dinning Table',
                    icon: AppIcon.dinningTable,
                    value: 'x${jobDetail.diningTableCount}',
                  ),
            jobDetail.diningTableCount == null ||
                    jobDetail.diningTableCount == 0 ||
                    "${jobDetail.serviceType} Booking" == "Premium Booking"
                ? const EmptyContainer()
                : const SizedBox(width: 8),
            jobDetail.stairCarryEnabled == null ||
                    jobDetail.stairCarryEnabled == '0'
                ? const EmptyContainer()
                : IconBox(
                    label: 'Stair Carry',
                    icon: AppIcon.stairCarry,
                    value: 'x${jobDetail.stairCarryEnabled}',
                  ),
            jobDetail.stairCarryEnabled == null ||
                    jobDetail.stairCarryEnabled == '0'
                ? const EmptyContainer()
                : const SizedBox(width: 8),
            jobDetail.tailGate == null || jobDetail.tailGate == "No"
                ? const EmptyContainer()
                : IconBox(
                    label: 'Tail Gate',
                    icon: AppIcon.tailGate,
                    value: '${jobDetail.tailGate}',
                  ),
            jobDetail.tailGate == null || jobDetail.tailGate == "No"
                ? const EmptyContainer()
                : const SizedBox(width: 8),
            jobDetail.longpushEnabled == null ||
                    jobDetail.longpushEnabled == '0'
                ? const EmptyContainer()
                : IconBox(
                    label: 'Long Push',
                    icon: AppIcon.longPush,
                    value: 'x${jobDetail.longpushEnabled}',
                  ),
          ],
        ),
      ),
    );
  }

  Widget totalAmountDetailCardUI(JobDetail jobDetail) {
    return CardContainer(
      isTrue: false,
      topChild: Padding(
        padding: Dimensions.kPaddingAllSmall,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Amount', style: context.textTheme.headlineSmall),
            Dimensions.kVerticalSpaceSmaller,
            PriceCardContainer(
                label: 'Lorry ${jobDetail.vehicleType ?? ''}',
                amount: jobDetail.amount ?? '0'),
            const SizedBox(height: 2),
            jobDetail.manpowerCount == null || jobDetail.manpowerCount == 0
                ? const EmptyContainer()
                : PriceCardContainer(
                    label: 'Manpower x${jobDetail.manpowerCount}',
                    amount: jobDetail.manpowerAmount ?? '0',
                  ),
            jobDetail.manpowerCount == null || jobDetail.manpowerCount == 0
                ? const EmptyContainer()
                : const SizedBox(height: 2),
            jobDetail.boxCount == null || jobDetail.boxCount == 0
                ? const EmptyContainer()
                : PriceCardContainer(
                    label: 'Boxes x${jobDetail.boxCount}',
                    amount: jobDetail.boxAmount ?? '0',
                  ),
            jobDetail.boxCount == null || jobDetail.boxCount == 0
                ? const EmptyContainer()
                : const SizedBox(height: 2),
            jobDetail.shrinkWrapping == null || jobDetail.shrinkWrapping == 'No'
                ? const EmptyContainer()
                : PriceCardContainer(
                    label: 'Shrink Wrapping ',
                    amount: jobDetail.shrinkWrapAmount ?? '0'),
            jobDetail.shrinkWrapping == null || jobDetail.shrinkWrapping == 'No'
                ? const EmptyContainer()
                : const SizedBox(height: 2),
            jobDetail.bubbleWrapping == null || jobDetail.bubbleWrapping == 'No'
                ? const EmptyContainer()
                : PriceCardContainer(
                    label: 'Bubble Wrapping ',
                    amount: jobDetail.bubbleWrapAmount ?? '0'),
            jobDetail.bubbleWrapping == null || jobDetail.bubbleWrapping == 'No'
                ? const EmptyContainer()
                : const SizedBox(height: 2),
            jobDetail.bedCount == null || jobDetail.bedCount == 0
                ? const EmptyContainer()
                : PriceCardContainer(
                    label: 'Bed x${jobDetail.bedCount}',
                    amount: jobDetail.bedAmount ?? '0'),
            jobDetail.bedCount == null || jobDetail.bedCount == 0
                ? const EmptyContainer()
                : const SizedBox(height: 2),
            jobDetail.wardrobeCount == null || jobDetail.wardrobeCount == 0
                ? const EmptyContainer()
                : PriceCardContainer(
                    label: 'Wardrobe x${jobDetail.wardrobeCount}',
                    amount: jobDetail.wardrobeAmount ?? '0'),
            jobDetail.wardrobeCount == null || jobDetail.wardrobeCount == 0
                ? const EmptyContainer()
                : const SizedBox(height: 2),
            jobDetail.tableCount == null || jobDetail.tableCount == 0
                ? const EmptyContainer()
                : PriceCardContainer(
                    label: 'Office Table x${jobDetail.tableCount}',
                    amount: jobDetail.tableAmount ?? '0'),
            jobDetail.tableCount == null || jobDetail.tableCount == 0
                ? const EmptyContainer()
                : const SizedBox(height: 2),
            jobDetail.diningTableCount == null ||
                    jobDetail.diningTableCount == 0
                ? const EmptyContainer()
                : PriceCardContainer(
                    label: 'Dinning Table x${jobDetail.diningTableCount}',
                    amount: jobDetail.diningTableAmount ?? '0'),
            jobDetail.diningTableCount == null ||
                    jobDetail.diningTableCount == 0
                ? const EmptyContainer()
                : const SizedBox(height: 2),
            jobDetail.stairCarryEnabled == null ||
                    jobDetail.stairCarryEnabled == '0'
                ? const EmptyContainer()
                : PriceCardContainer(
                    label: 'Stair Carry x${jobDetail.stairCarryEnabled}',
                    amount: jobDetail.stairCarryEnabledAmount ?? '0'),
            jobDetail.stairCarryEnabled == null ||
                    jobDetail.stairCarryEnabled == '0'
                ? const EmptyContainer()
                : const SizedBox(height: 2),
            jobDetail.tailGate == null || jobDetail.tailGate == "No"
                ? const EmptyContainer()
                : PriceCardContainer(
                    label: 'Tail Gate',
                    amount: jobDetail.tailgateAmount ?? '0'),
            jobDetail.tailGate == null || jobDetail.tailGate == "No"
                ? const EmptyContainer()
                : const SizedBox(height: 2),
            jobDetail.longpushEnabled == null ||
                    jobDetail.longpushEnabled == '0'
                ? const EmptyContainer()
                : PriceCardContainer(
                    label: 'Long Push',
                    amount: jobDetail.longpushEnabledAmount ?? '0'),
          ],
        ),
      ),
      bottomChild: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: context.textTheme.headlineMedium?.copyWith(
                color: AppColor.secondaryText,
              ),
            ),
            Text(
              jobDetail.totalAmount == null
                  ? '0.00 MYR'
                  : '${jobDetail.totalAmount} MYR',
              style: context.textTheme.headlineMedium?.copyWith(
                color: AppColor.secondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showRequestSuccessfulAlert() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColor.secondaryText,
        title: const Text("Job Successfully Accepted",
            textAlign: TextAlign.center),
        titleTextStyle: context.textTheme.headlineMedium,
        actions: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(AppIcon.successful),
                width: 100,
              ),
            ],
          ),
          Dimensions.kVerticalSpaceSmaller,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Button(
                onTap: () => Navigator.pop(ctx),
                width: 150,
                child: Text(
                  'Okay',
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: AppColor.secondaryText,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
