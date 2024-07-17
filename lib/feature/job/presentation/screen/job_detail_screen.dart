import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../job.dart';

class JobDetailScreen extends ConsumerStatefulWidget {
  static const String id = 'job_detail_screen';

  final String bookingId;
  final String stageId;
  final String bookingName;

  const JobDetailScreen(
      {super.key,
      required this.bookingName,
      required this.bookingId,
      required this.stageId});

  @override
  ConsumerState<JobDetailScreen> createState() =>
      _JobDetailScreenConsumerState();
}

class _JobDetailScreenConsumerState extends ConsumerState<JobDetailScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();

  JobDetail jobDetail = JobDetail();
  JobDetailModel jobDetailModel = JobDetailModel();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initialCallback();
  }

  void initialCallback() async {
    WidgetsBinding.instance.addPostFrameCallback((__) {
      setState(() => isLoading = true);
      ref.read(jobProvider.notifier).jobDetail(widget.bookingId).then(
            (response) => response.fold(
              (l) => {
                setState(() => {
                      isLoading = false,
                      jobDetail = JobDetail(),
                      jobDetailModel = JobDetailModel(),
                    })
              },
              (r) => {
                setState(() => {
                      isLoading = false,
                      jobDetail = r.jobDetail ?? JobDetail(),
                      jobDetailModel = r
                    })
              },
            ),
          );
    });
  }

  void navigateToEditScreen() {
    switch (widget.bookingName) {
      case "Budget Booking":
        Navigator.pushNamed(context, BudgetBookingEditScreen.id,
            arguments: BudgetBookingEditScreen(
              bookingId: widget.bookingId,
              bookingStageId: widget.stageId,
              distance: jobDetail.distance.toString(),
            )).then((value) => initialCallback());
        break;
      case "Premium Booking":
        Navigator.pushNamed(context, PremiumBookingEditScreen.id,
            arguments: PremiumBookingEditScreen(
              bookingId: widget.bookingId,
              bookingStageId: widget.stageId,
              distance: jobDetail.distance.toString(),
            )).then((value) => initialCallback());
        break;
      case "Disposal Booking":
        Navigator.pushNamed(context, DisposalBookingEditScreen.id,
                arguments: DisposalBookingEditScreen(
                    bookingId: widget.bookingId,
                    bookingStageId: widget.stageId))
            .then((value) => initialCallback());
        break;

      default:
        break;
    }
  }

  void deleteRequest() {
    AppAlerts.showBookingCancelQueryAlert(
      context,
      controller: _controller,
      onPressed: deleteRequestSubmit,
    );
  }

  void deleteRequestSubmit() {
    final userId = SharedPrefs.instance.getInt(AppKeys.userId);
    final jobDeleteEntities = JobDeleteEntities(
      userId: userId!,
      bookingId: jobDetail.id ?? widget.bookingId,
      description: _controller.text,
    );

    ref.read(jobProvider.notifier).deleteRequest(jobDeleteEntities).then(
          (response) => response.fold(
            (l) => {
              Navigator.of(context).pop(),
              AppAlerts.displaySnackBar(context, l.message, false),
            },
            (r) => {
              Navigator.of(context).pop(),
              AppAlerts.showDeleteRequestSuccessfulAlert(context),
            },
          ),
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
      floatingActionButton: widget.stageId != '1' && widget.stageId != '4'
          ? isLoading
              ? const EmptyContainer()
              : SpeedDial(
                  icon: Icons.settings,
                  animatedIcon: AnimatedIcons.menu_close,
                  backgroundColor: AppColor.primary,
                  children: widget.bookingName != "Manpower Booking"
                      ? [
                          SpeedDialChild(
                            child: const Icon(Icons.add),
                            label: 'Additional Service',
                            onTap: () {
                              Navigator.pushNamed(
                                      context, AdditionalServiceScreen.id,
                                      arguments: AdditionalServiceScreen(
                                          bookingId: widget.bookingId,
                                          bookingName: widget.bookingName))
                                  .then((value) => initialCallback());
                            },
                          ),
                          SpeedDialChild(
                            child: const Icon(Icons.edit),
                            label: 'Edit',
                            onTap: navigateToEditScreen,
                          ),
                          SpeedDialChild(
                            child: const Icon(Icons.delete),
                            label: 'Cancel',
                            onTap: deleteRequest,
                          ),
                        ]
                      : [
                          SpeedDialChild(
                            child: const Icon(Icons.add),
                            label: 'Additional Service',
                            onTap: () {
                              Navigator.pushNamed(
                                      context, AdditionalServiceScreen.id,
                                      arguments: AdditionalServiceScreen(
                                          bookingId: widget.bookingId,
                                          bookingName: widget.bookingName))
                                  .then((value) => initialCallback());
                            },
                          ),
                          SpeedDialChild(
                            child: const Icon(Icons.delete),
                            label: 'Cancel',
                            onTap: deleteRequest,
                          ),
                        ],
                )
          : null,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
            width: context.deviceSize.width,
            height: context.deviceSize.height / 1.08,
            child: isLoading
                ? const JobDetailShimmerLoading()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Dimensions.kDivider,
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            Text(
                              widget.bookingName,
                              style: context.textTheme.bodyLarge,
                            ),
                            Dimensions.kSpacer,
                            Text(
                              jobDetail.bookingDateTime == null
                                  ? ''
                                  : jobDetail.bookingDateTime ?? '',
                              style: context.textTheme.labelLarge,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          padding: Dimensions.kPaddingAllMedium,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            // widget.stageId != '1' && widget.stageId != '4'
                            widget.stageId != '1' && widget.stageId != '3'
                                ? customerDetailCardUI(jobDetail)
                                : const EmptyContainer(),
                            widget.stageId != '1' && widget.stageId != '3'
                                // widget.stageId != '1' && widget.stageId != '4'
                                ? Dimensions.kVerticalSpaceSmaller
                                : const EmptyContainer(),
                            addressDetailCardUI(jobDetail),
                            Dimensions.kVerticalSpaceSmaller,
                            widget.bookingName != "Manpower Booking"
                                ? vehicleDetailCardUI(jobDetail)
                                : manpowerDetailCardUI(jobDetail),
                            widget.bookingName != "Manpower Booking"
                                ? Dimensions.kVerticalSpaceSmaller
                                : Dimensions.kVerticalSpaceSmaller,
                            widget.bookingName == "Budget Booking" ||
                                    widget.bookingName == "Premium Booking"
                                ? additionalServiceDetailCardUI(jobDetail)
                                : const EmptyContainer(),
                            widget.bookingName == "Budget Booking" ||
                                    widget.bookingName == "Premium Booking"
                                ? Dimensions.kVerticalSpaceSmaller
                                : const EmptyContainer(),
                            customAdditionalServiceDetailCardUI(jobDetail),
                            totalAmountDetailCardUI(jobDetail),
                            Dimensions.kVerticalSpaceMedium,
                            Button(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                color: Colors.white,
                                child: Text(
                                  'Back',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: AppColor.primary,
                                          fontWeight: FontWeight.w600),
                                )),
                            const SizedBox(height: 16),
                            if (widget.stageId == '1')
                              CustomSliderButton(
                                width: context.deviceSize.width / 1.20,
                                height: 60,
                                text: 'Accept Job',
                                stageId: "1",
                                bookingId: widget.bookingId,
                              ),
                            if (widget.stageId == '2')
                              CustomSliderButton(
                                width: context.deviceSize.width / 1.20,
                                height: 60,
                                text: 'Complete Job',
                                stageId: "2",
                                bookingId: widget.bookingId,
                              ),
                            // if (widget.stageId == '3')
                            //   CustomSliderButton(
                            //     width: context.deviceSize.width / 1.20,
                            //     height: 60,
                            //     text: 'Complete Job',
                            //     stageId: "3",
                            //     bookingId: widget.bookingId,
                            //   ),
                            Dimensions.kVerticalSpaceMedium,
                          ],
                        ),
                      ),
                    ],
                  )),
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
            Container(
              width: 60,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColor.primary.withOpacity(.3),
                borderRadius: Dimensions.kBorderRadiusAllLarge,
              ),
              child: Text(
                jobDetail.customerName == null
                    ? ''
                    : jobDetail.customerName!.split('').first,
                style: context.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w900, color: AppColor.cyanBlue),
              ),
            ),
            Dimensions.kHorizontalSpaceSmall,
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
                    "+60 ${jobDetail.customerMobileNumber ?? ''}",
                    style: context.textTheme.labelLarge,
                  ),
                  Text(
                    jobDetail.customerEmailId ?? '',
                    style: context.textTheme.labelLarge,
                  ),
                ],
              ),
            ),
            Dimensions.kHorizontalSpaceSmall,
            InkWell(
              onTap: () => makePhoneCall(
                  number: "+60${jobDetail.customerMobileNumber ?? ''}"),
              borderRadius: Dimensions.kBorderRadiusAllLarge,
              child: Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.primary.withOpacity(.3),
                  borderRadius: Dimensions.kBorderRadiusAllLarge,
                ),
                child: const Icon(
                  Icons.phone,
                  size: 16,
                  color: AppColor.cyanBlue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void makePhoneCall({required number}) async {
    final Uri url = Uri(
      scheme: 'tel',
      path: number,
    );
    await launchUrl(url);
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
        padding: const EdgeInsets.only(left: 12, right: 16, bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                    widget.bookingName == "Premium Booking"
                ? const EmptyContainer()
                : IconBox(
                    label: 'Manpower',
                    icon: AppIcon.manpower,
                    value: 'x${jobDetail.manpowerCount}',
                  ),
            jobDetail.manpowerCount == null ||
                    jobDetail.manpowerCount == 0 ||
                    widget.bookingName == "Premium Booking"
                ? const EmptyContainer()
                : const SizedBox(width: 8),
            jobDetail.boxCount == null ||
                    jobDetail.boxCount == 0 ||
                    widget.bookingName == "Premium Booking"
                ? const EmptyContainer()
                : IconBox(
                    label: 'Boxes',
                    icon: AppIcon.box,
                    value: 'x${jobDetail.boxCount}',
                  ),
            jobDetail.boxCount == null ||
                    jobDetail.boxCount == 0 ||
                    widget.bookingName == "Premium Booking"
                ? const EmptyContainer()
                : const SizedBox(width: 8),
            jobDetail.wrapping == null ||
                    jobDetail.wrapping == 0 ||
                    widget.bookingName == "Premium Booking"
                ? const EmptyContainer()
                : IconBox(
                    label: 'Shrink Wrapping',
                    icon: AppIcon.shrinkWrapping,
                    value: 'x${jobDetail.wrapping}',
                  ),
            jobDetail.wrapping == null ||
                    jobDetail.wrapping == 0 ||
                    widget.bookingName == "Premium Booking"
                ? const EmptyContainer()
                : const SizedBox(width: 8),
            jobDetail.bubble == null ||
                    jobDetail.bubble == 0 ||
                    widget.bookingName == "Premium Booking"
                ? const EmptyContainer()
                : IconBox(
                    label: 'Bubble Wrapping',
                    icon: AppIcon.bubbleWrapping,
                    value: 'x${jobDetail.bubble}',
                  ),
            jobDetail.bubble == null ||
                    jobDetail.bubble == 0 ||
                    widget.bookingName == "Premium Booking"
                ? const EmptyContainer()
                : const SizedBox(width: 8),
            jobDetail.bedCount == null ||
                    jobDetail.bedCount == 0 ||
                    widget.bookingName == "Premium Booking"
                ? const EmptyContainer()
                : IconBox(
                    label: 'Bed',
                    icon: AppIcon.bed,
                    value: 'x${jobDetail.bedCount}',
                  ),
            jobDetail.bedCount == null ||
                    jobDetail.bedCount == 0 ||
                    widget.bookingName == "Premium Booking"
                ? const EmptyContainer()
                : const SizedBox(width: 8),
            jobDetail.wardrobeCount == null ||
                    jobDetail.wardrobeCount == 0 ||
                    widget.bookingName == "Premium Booking"
                ? const EmptyContainer()
                : IconBox(
                    label: 'Wardrobe',
                    icon: AppIcon.wardrobe,
                    value: 'x${jobDetail.wardrobeCount}',
                  ),
            jobDetail.wardrobeCount == null ||
                    jobDetail.wardrobeCount == 0 ||
                    widget.bookingName == "Premium Booking"
                ? const EmptyContainer()
                : const SizedBox(width: 8),
            jobDetail.tableCount == null ||
                    jobDetail.tableCount == 0 ||
                    widget.bookingName == "Premium Booking"
                ? const EmptyContainer()
                : IconBox(
                    label: 'Office Table',
                    icon: AppIcon.officeTable,
                    value: 'x${jobDetail.tableCount}',
                  ),
            jobDetail.tableCount == null ||
                    jobDetail.tableCount == 0 ||
                    widget.bookingName == "Premium Booking"
                ? const EmptyContainer()
                : const SizedBox(width: 8),
            jobDetail.diningTableCount == null ||
                    jobDetail.diningTableCount == 0 ||
                    widget.bookingName == "Premium Booking"
                ? const EmptyContainer()
                : IconBox(
                    label: 'Dinning Table',
                    icon: AppIcon.dinningTable,
                    value: 'x${jobDetail.diningTableCount}',
                  ),
            jobDetail.diningTableCount == null ||
                    jobDetail.diningTableCount == 0 ||
                    widget.bookingName == "Premium Booking"
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

  customAdditionalServiceDetailCardUI(JobDetail jobDetail) {
    return jobDetail.additionalServiceAmount == '' ||
            jobDetail.additionalServiceAmount == null
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CardContainer(
              isTrue: true,
              topChild: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Additional Services Details',
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
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...(jobDetailModel.additionalAmountHistoryList ??
                                    [])
                                .where((additional) =>
                                    additional.description != null)
                                .map(
                              (additional) {
                                final description = additional.description!;

                                return Text(
                                  description,
                                  style: context.textTheme.bodySmall,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                );
                              },
                            ).toList(),
                          ]),
                    ),
                    Column(
                      children:
                          jobDetailModel.additionalAmountHistoryList!.isNotEmpty
                              ? [
                                  ...jobDetailModel.additionalAmountHistoryList!
                                      .map(
                                    (additional) => Text(
                                        "${additional.additionalAction ?? ''} ${additional.additionalAmount ?? '0.00'} MYR",
                                        style: context.textTheme.bodySmall),
                                  ),
                                ]
                              : [],
                    ),
                  ],
                ),
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
            widget.bookingName == "Manpower Booking"
                ? const EmptyContainer()
                : PriceCardContainer(
                    label: 'Lorry ${jobDetail.vehicleType ?? ''}',
                    amount: jobDetail.vehicleAmount == '' ||
                            jobDetail.vehicleAmount == null
                        ? jobDetail.amount ?? '0'
                        : jobDetail.vehicleAmount ?? '0'),
            widget.bookingName == "Manpower Booking"
                ? const EmptyContainer()
                : const SizedBox(height: 2),
            jobDetail.manpowerCount == null || jobDetail.manpowerCount == 0
                ? const EmptyContainer()
                : PriceCardContainer(
                    label: 'Manpower x${jobDetail.manpowerCount}',
                    amount: jobDetail.manpowerAmount == '' ||
                            jobDetail.manpowerAmount == null
                        ? jobDetail.amount ?? '0'
                        : jobDetail.manpowerAmount ?? '0',
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
            jobDetail.longpushEnabled == null ||
                    jobDetail.longpushEnabled == '0'
                ? const EmptyContainer()
                : const SizedBox(height: 2),
            if (jobDetailModel.additionalAmountHistoryList == null)
              const EmptyContainer()
            else
              for (var i = 0;
                  i < jobDetailModel.additionalAmountHistoryList!.length;
                  i++)
                PriceCardContainer(
                  label: jobDetailModel
                          .additionalAmountHistoryList![i].description ??
                      '',
                  amount:
                      "${jobDetailModel.additionalAmountHistoryList![i].additionalAction ?? ''} ${jobDetailModel.additionalAmountHistoryList![i].additionalAmount ?? ''}",
                ),
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
                onTap: () => {Navigator.pop(ctx)},
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

  void slideToUpdateJobStage(ActionSliderController controller) {
    controller.loading();
    if (widget.stageId == '1') {
      final jobStageUpdateEntities =
          JobStageUpdateEntities(stageId: "2", bookingId: widget.bookingId);
      ref.read(jobProvider.notifier).jobUpdate(jobStageUpdateEntities).then(
            (response) => response.fold(
              (l) => {
                setState(() => controller.reset()),
                AppAlerts.displaySnackBar(context, l.message, false),
              },
              (r) => {
                setState(() => controller.success()),
                AppAlerts.showJobAcceptedAlert(context),
              },
            ),
          );
    }
    // if (widget.stageId == '2') {
    //   final jobStageUpdateEntities =
    //       JobStageUpdateEntities(stageId: "3", bookingId: widget.bookingId);
    //   ref.read(jobProvider.notifier).jobUpdate(jobStageUpdateEntities).then(
    //         (response) => response.fold(
    //           (l) => {
    //             AppAlerts.displaySnackBar(context, l.message, false),
    //             setState(() => controller.reset()),
    //           },
    //           (r) => {
    //             setState(() => controller.success()),
    //             AppAlerts.showJobProgressAlert(context),
    //           },
    //         ),
    //       );
    // }
    if (widget.stageId == '2') {
      final jobStageUpdateEntities =
          JobStageUpdateEntities(stageId: "4", bookingId: widget.bookingId);
      ref
          .read(jobProvider.notifier)
          .jobCompleteStageUpdate(jobStageUpdateEntities)
          .then(
            (response) => response.fold(
              (l) => {
                AppAlerts.displaySnackBar(context, l.message, false),
                setState(() => controller.reset()),
              },
              (r) => {
                setState(() => controller.success()),
                Navigator.pushNamed(context, JobRatingScreen.id,
                    arguments: JobRatingScreen(bookingId: widget.bookingId)),
              },
            ),
          );
    }
  }
}
