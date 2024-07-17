import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../feature.dart';

class PremiumService {
  String icon;
  String label;

  PremiumService({required this.icon, required this.label});
}

class PremiumBookingEditScreen extends ConsumerStatefulWidget {
  static const String id = 'premium_booking_edit_screen';

  final String bookingId;
  final String bookingStageId;
  final String distance;

  const PremiumBookingEditScreen(
      {super.key,
      required this.bookingId,
      required this.bookingStageId,
      required this.distance});

  @override
  ConsumerState<PremiumBookingEditScreen> createState() =>
      _PremiumBookingEditScreenConsumerState();
}

class _PremiumBookingEditScreenConsumerState
    extends ConsumerState<PremiumBookingEditScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isVehicleLoading = false;
  bool isBudgetLoading = false;
  bool isPremiumLoading = false;
  JobDetail jobDetail = JobDetail();
  JobDetailModel jobDetailModel = JobDetailModel();

  bool isLoading = false;

  int selectedIndex = 0;
  DateTime? selectedDate;
  PremiumBookingModel premiumBooking = PremiumBookingModel();

  List<PremiumService> serviceList = [
    PremiumService(icon: AppIcon.stairCarry, label: 'Stair Carry'),
    PremiumService(icon: AppIcon.tailGate, label: 'Tail-Gate'),
    PremiumService(icon: AppIcon.longPush, label: 'Long Push'),
  ];

  @override
  void initState() {
    super.initState();
    initialCallback();
    initialBookingDetails();
  }

  initialBookingDetails() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(premiumNotifierProvider).setLoading(true);
      ref
          .read(jobProvider.notifier)
          .premiumBookingDetail(widget.bookingId)
          .then(
            (response) => response.fold(
              (l) => {
                setState(() => premiumBooking = PremiumBookingModel()),
                ref.read(premiumNotifierProvider).setLoading(false),
              },
              (r) => {
                setState(() => {
                      premiumBooking = r,
                      selectedIndex = vehicleType(
                          r.premiumPackageList ?? [],
                          r.bookingPremiumEditDetails?.vehicleType ??
                              '1 Tonne'),
                    }),
                ref.read(premiumNotifierProvider).setLongPushIndex(int.parse(
                    r.bookingPremiumEditDetails?.longpushEnabled ?? "0")),
                ref.read(premiumNotifierProvider).setStairCarry(int.parse(
                    r.bookingPremiumEditDetails?.stairCarryEnabled ?? "0")),
                ref.read(premiumNotifierProvider).setTailGate(
                    r.bookingPremiumEditDetails?.tailGate == "Yes"
                        ? true
                        : false),
                ref
                    .read(premiumNotifierProvider)
                    .setLongPushType(r.longPushTypeList ?? []),
                ref.read(premiumNotifierProvider).setLoading(false),
              },
            ),
          );
    });
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

  int vehicleType(List<PremiumPackageList> premiumPackage, String label) {
    if (label == '1 Tonne') {
      ref.read(premiumNotifierProvider).setVehicleType(0);
      ref.read(premiumNotifierProvider).setPremiumPackage(premiumPackage[0]);
      return 1;
    }
    if (label == '3 Tonne') {
      ref.read(premiumNotifierProvider).setVehicleType(1);
      ref.read(premiumNotifierProvider).setPremiumPackage(premiumPackage[1]);
      return 2;
    }
    if (label == '5 Tonne') {
      ref.read(premiumNotifierProvider).setVehicleType(2);
      ref.read(premiumNotifierProvider).setPremiumPackage(premiumPackage[2]);
      return 3;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(premiumNotifierProvider).isLoading;

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
          padding: isLoading
              ? const EdgeInsets.all(0)
              : Dimensions.kPaddingAllMedium,
          child: isLoading
              ? const JobDetailShimmerLoading()
              : Column(
                  children: [
                    Dimensions.kDivider,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Premium Booking Edit",
                          style: context.textTheme.bodyLarge,
                        ),
                        GestureDetector(
                          onTap: () {
                            showEditDateTimeDialog();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xFFB10205),
                            ),
                            child: Text(
                              selectedDate == null
                                  ? 'Change Date'
                                  : DateFormat('dd/MM/yyyy')
                                      .format(selectedDate!),
                              style: context.textTheme.labelLarge
                                  ?.copyWith(color: Colors.white
                                      // Customize the color as needed
                                      ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Dimensions.kVerticalSpaceSmaller,
                    Expanded(
                      child: ListView(
                        children: [
                          vehicleTypeDetailUI(),
                          Dimensions.kVerticalSpaceSmallest,
                          additionalServicesDetailUI(),
                          Dimensions.kVerticalSpaceSmallest,
                          totalAmountDetailCardUI(),
                          Dimensions.kVerticalSpaceMedium,
                          isPremiumLoading
                              ? const Center(child: CircularProgressIndicator())
                              : Row(
                                  children: [
                                    Expanded(
                                      child: Button(
                                        onTap: () =>
                                            Navigator.of(context).pop(),
                                        height: 56,
                                        color: Colors.white,
                                        child: Text(
                                          'Cancel',
                                          style: context.textTheme.bodyMedium
                                              ?.copyWith(
                                            color: AppColor.primary,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: .7,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Button(
                                      onTap: onSubmit,
                                      child: Text(
                                        'Update',
                                        style: context.textTheme.bodySmall
                                            ?.copyWith(
                                                color: Colors.white,
                                                letterSpacing: .2),
                                      ),
                                    ),
                                  ],
                                ),
                          Dimensions.kVerticalSpaceLargest,
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  vehicleTypeDetailUI() {
    return CardContainer(
      isTrue: true,
      topChild: Padding(
        padding: Dimensions.kPaddingAllSmall,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Vehicle ?',
              style: context.textTheme.titleLarge
                  ?.copyWith(color: AppColor.secondaryText),
            ),
          ],
        ),
      ),
      bottomChild: Padding(
        padding: Dimensions.kPaddingAllSmall,
        child: SizedBox(
          height: 80,
          child: premiumBooking.premiumPackageList!.isEmpty
              ? const EmptyContainer()
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: premiumBooking.premiumPackageList?.length,
                  itemBuilder: (_, i) {
                    final vehicleType = premiumBooking.premiumPackageList![i];
                    final res = i + 1;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: InkWell(
                        onTap: () => {
                          setState(() => selectedIndex = res),
                          ref
                              .read(premiumNotifierProvider)
                              .setVehicleType(vehicleType.id!),
                          ref
                              .read(premiumNotifierProvider)
                              .setPremiumPackage(vehicleType),
                        },
                        borderRadius: Dimensions.kBorderRadiusAllSmaller,
                        child: Container(
                          width: 90,
                          padding: Dimensions.kPaddingAllSmaller,
                          decoration: BoxDecoration(
                            borderRadius: Dimensions.kBorderRadiusAllSmaller,
                            color: selectedIndex == res
                                ? Colors.white
                                : Colors.transparent,
                            border: Border.all(
                              width: 1,
                              color: selectedIndex == res
                                  ? context.colorScheme.primary
                                  : Colors.white,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage(selectVehicleTypeImage(i)),
                                width: Dimensions.iconSizeLarge,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                vehicleType.tonne ?? '',
                                style: context.textTheme.labelMedium?.copyWith(
                                  color: selectedIndex == res
                                      ? context.colorScheme.primary
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }

  additionalServicesDetailUI() {
    return CardContainer(
      isTrue: true,
      topChild: Padding(
        padding: Dimensions.kPaddingAllSmall,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What do you like to add on additional services ?',
              style: context.textTheme.titleLarge
                  ?.copyWith(color: AppColor.secondaryText),
            ),
            Dimensions.kVerticalSpaceSmallest,
            Text(
              'For stair carry, tail gate and long push services.',
              style: context.textTheme.labelLarge
                  ?.copyWith(color: AppColor.secondaryText),
            ),
          ],
        ),
      ),
      bottomChild: Padding(
        padding: Dimensions.kPaddingAllSmall,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: serviceList.length,
            itemBuilder: (_, i) {
              final service = serviceList[i];
              return InkWell(
                onTap: () => servicesBottomSheetAction(i),
                borderRadius: Dimensions.kBorderRadiusAllSmall,
                child: Container(
                  width: 110,
                  height: 106,
                  padding: Dimensions.kPaddingAllSmall,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: Dimensions.kBorderRadiusAllSmall,
                    border: Border.all(
                      width: 1,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(service.icon),
                        width: Dimensions.iconSizeLarger,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        service.label,
                        textAlign: TextAlign.center,
                        style: context.textTheme.labelLarge?.copyWith(
                          color: const Color(0xA0000000),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String selectVehicleTypeImage(int i) {
    final res = i + 1;
    if (res == 1) {
      return AppIcon.oneTonne;
    }
    if (res == 2) {
      return AppIcon.threeTonne;
    }
    if (res == 3) {
      return AppIcon.fiveTonne;
    }
    return AppIcon.oneTonne;
  }

  void servicesBottomSheetAction(int i) {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      isDismissible: false,
      isScrollControlled: true,
      builder: (_) {
        return selectedWidget(i)!;
      },
    );
  }

  Widget? selectedWidget(int i) {
    final res = i + 1;
    if (res == 1) {
      return const PremiumStairCarryBottomSheet();
    } else if (res == 2) {
      return const PremiumTailGateBottomSheet();
    } else if (res == 3) {
      return const PremiumLongPushBottomSheet();
    } else {
      return Container();
    }
  }

  Widget totalAmountDetailCardUI() {
    final vehicleSpecification =
        ref.watch(premiumNotifierProvider).vehicleSpecification;

    final budgetPackage = ref.watch(premiumNotifierProvider).premiumPackage;
    final longPushType = ref.watch(premiumNotifierProvider).longPushType ?? [];

    final stairCarry = ref.watch(premiumNotifierProvider).stairCarry ?? 0;
    final tailGate = ref.watch(premiumNotifierProvider).tailGate ?? false;

    final longPush = ref.watch(premiumNotifierProvider).longPush ?? 0;

    final amountList = [
      Calculator.premiumDistanceAmount(
          int.parse(widget.distance), budgetPackage!),
      Calculator.premiumStairCarryAmount(stairCarry, budgetPackage),
      Calculator.premiumTailGateAmount(tailGate, budgetPackage),
      Calculator.premiumLongPushAmount(longPush, longPushType)
    ];

    final totalAmount = Calculator.totalAmount(amountList);

    return CardContainer(
      isTrue: false,
      topChild: Padding(
        padding: Dimensions.kPaddingAllSmall,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Amount',
              style: context.textTheme.headlineSmall,
            ),
            Dimensions.kVerticalSpaceSmaller,
            PriceCardContainer(
              label: 'Lorry',
              amount: amountList[0].toString(),
            ),
            const SizedBox(height: 2),
            stairCarry == 0
                ? const EmptyContainer()
                : PriceCardContainer(
                    label: 'Stair Carry',
                    amount: amountList[1].toString(),
                  ),
            stairCarry == 0
                ? const EmptyContainer()
                : const SizedBox(height: 2),
            tailGate == false
                ? const EmptyContainer()
                : PriceCardContainer(
                    label: 'Tail Gate',
                    amount: amountList[2].toString(),
                  ),
            tailGate == false
                ? const EmptyContainer()
                : const SizedBox(height: 2),
            longPush == 0
                ? const EmptyContainer()
                : PriceCardContainer(
                    label: 'Long Push',
                    amount: amountList[3].toString(),
                  ),
            longPush == 0 ? const EmptyContainer() : const SizedBox(height: 2),
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
              '$totalAmount MYR',
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
        title: const Text("Premium Booking Successfully Updated",
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

  void onSubmit() {
    setState(() => isPremiumLoading = true);
    final userId = SharedPrefs.instance.getInt(AppKeys.userId) ?? 0;

    final vehicleType = ref.read(premiumNotifierProvider).selectVehicleType;

    final premiumPackage = ref.read(premiumNotifierProvider).premiumPackage;
    final longPushType = ref.read(premiumNotifierProvider).longPushType ?? [];

    int stairCarry = ref.read(premiumNotifierProvider).stairCarry ?? 0;
    bool tailGate = ref.read(premiumNotifierProvider).tailGate ?? false;

    int longPush = ref.read(premiumNotifierProvider).longPush ?? 0;

    List amountList = [
      Calculator.premiumDistanceAmount(
          int.parse(widget.distance), premiumPackage!),
      Calculator.premiumStairCarryAmount(stairCarry, premiumPackage),
      Calculator.premiumTailGateAmount(tailGate, premiumPackage),
      Calculator.premiumLongPushAmount(longPush, longPushType)
    ];

    double totalAmount = Calculator.totalAmount(amountList);
    if (jobDetailModel.additionalAmountHistoryList != null) {
      for (var entry in jobDetailModel.additionalAmountHistoryList!) {
        String? action = entry.additionalAction;
        double amount = double.tryParse(entry.additionalAmount ?? '0') ?? 0;
        if (action != null) {
          if (action.startsWith('+')) {
            totalAmount += amount;
          } else if (action.startsWith('-')) {
            totalAmount -= amount;
          }
        }
      }
    }
    final String formattedDate;
    if (selectedDate != null) {
      formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedDate!);
    } else {
      formattedDate = jobDetail.bookingDateTime ?? '';
    }

    final premiumEntities = PremiumEntities(
      bookingId: widget.bookingId,
      userId: userId,
      bookingDate: formattedDate,
      customerId:
          premiumBooking.bookingPremiumEditDetails!.customerId.toString(),
      serviceType: 2,
      vehicleType: vehicleType.toString(),
      amount: double.parse(premiumPackage.basePrice.toString()),
      stairCarryCount: stairCarry,
      longPushType: longPush,
      tailGate: tailGate == true ? 'Yes' : 'No',
      vehicleAmount: amountList[0],
      stairCarryAmount: amountList[1],
      tailgateAmount: amountList[2],
      longPushAmount: amountList[3],
      totalAmount: double.parse(totalAmount.toStringAsFixed(2)),
    );

    ref.read(jobProvider.notifier).premiumBookingUpdate(premiumEntities).then(
          (res) => res.fold(
            (l) => {
              setState(() => isPremiumLoading = false),
              AppAlerts.displaySnackBar(context, 'Update Failed', false),
            },
            (r) => {
              setState(() => isPremiumLoading = false),
              Navigator.pop(context),
              showRequestSuccessfulAlert(),
            },
          ),
        );
  }

  void showEditDateTimeDialog() async {
    final DateTime currentDate = DateTime.now();
    final DateTime nextDay = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
      0, // Setting hours to 0 for midnight
      0, // Setting minutes to 0
    );

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: nextDay,
      firstDate: nextDay,
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget? child) {
        return child!;
      },
    );

    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(currentDate),
      );

      if (pickedTime != null) {
        final DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          selectedDate = selectedDateTime;
        });

        // Format the selected date
        String formattedDate =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedDate!);
        print('Selected date: $formattedDate');

        // Handle the selected date here
      }
    }
  }
}
