import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../feature.dart';

class Service {
  String icon;
  String label;

  Service({required this.icon, required this.label});
}

class BudgetBookingEditScreen extends ConsumerStatefulWidget {
  static const String id = 'budget_booking_edit_screen';

  final String bookingId;
  final String bookingStageId;
  final String distance;

  const BudgetBookingEditScreen({
    super.key,
    required this.bookingId,
    required this.bookingStageId,
    required this.distance,
  });

  @override
  ConsumerState<BudgetBookingEditScreen> createState() =>
      _BudgetBookingEditScreenConsumerState();
}

class _BudgetBookingEditScreenConsumerState
    extends ConsumerState<BudgetBookingEditScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isBudgetLoading = false;

  int selectedIndex = 0;

  BudgetBookingModel budgetBookingModel = BudgetBookingModel();
  DateTime? selectedDate;
  JobDetail jobDetail = JobDetail();
  JobDetailModel jobDetailModel = JobDetailModel();

  bool isLoading = false;

  List<Service> serviceList = [
    Service(icon: AppIcon.manpower, label: 'Manpower'),
    Service(icon: AppIcon.box, label: 'Boxes'),
    Service(icon: AppIcon.wrapping, label: 'Wrapping'),
    Service(icon: AppIcon.assembly, label: 'Assembly / Disassembly'),
    Service(icon: AppIcon.stairCarry, label: 'Stair Carry'),
    Service(icon: AppIcon.tailGate, label: 'Tail-Gate'),
    Service(icon: AppIcon.longPush, label: 'Long Push'),
  ];

  @override
  void initState() {
    super.initState();
    initialCallback();
    initialBudgetBookings();
  }

  void initialBudgetBookings() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(budgetNotifierProvider).setLoading(true);
      ref.read(jobProvider.notifier).budgetBookingDetail(widget.bookingId).then(
            (response) => response.fold(
              (l) => {
                setState(() => budgetBookingModel = BudgetBookingModel()),
                ref.read(budgetNotifierProvider).setLoading(false),
              },
              (r) => {
                setState(() => {
                      budgetBookingModel = r,
                      selectedIndex = vehicleType(r.budgetPackageList ?? [],
                          r.bookingBudgetEditDetails?.vehicleType ?? '1 Tonne'),
                    }),
                ref.read(budgetNotifierProvider).setBudgetBookingDetail(
                    r.bookingBudgetEditDetails, r.longPushTypeList ?? []),
                ref.read(budgetNotifierProvider).setLoading(false),
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

  int vehicleType(List<BudgetPackageList> budgetPackageList, String label) {
    if (label == '1 Tonne') {
      ref.read(budgetNotifierProvider).setVehicleType(0);
      ref.read(budgetNotifierProvider).setBudgetMoving(budgetPackageList[0]);
      return 1;
    }
    if (label == '3 Tonne') {
      ref.read(budgetNotifierProvider).setVehicleType(1);
      ref.read(budgetNotifierProvider).setBudgetMoving(budgetPackageList[1]);
      return 2;
    }
    if (label == '5 Tonne') {
      ref.read(budgetNotifierProvider).setVehicleType(2);
      ref.read(budgetNotifierProvider).setBudgetMoving(budgetPackageList[2]);
      return 3;
    } else {
      ref.read(budgetNotifierProvider).setVehicleType(3);
      ref.read(budgetNotifierProvider).setBudgetMoving(budgetPackageList[3]);
      return 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.read(budgetNotifierProvider).isLoading;
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
        child: isLoading
            ? const JobDetailShimmerLoading()
            : Container(
                width: context.deviceSize.width,
                height: context.deviceSize.height / 1.08,
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 4, bottom: 16),
                child: Column(
                  children: [
                    Dimensions.kDivider,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Budget Booking Edit",
                            style: context.textTheme.bodyLarge),
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
                                  ? 'Change date'
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
                          changeVehicleUI(),
                          Dimensions.kVerticalSpaceSmallest,
                          changeAdditionalServicesUI(),
                          Dimensions.kVerticalSpaceSmallest,
                          totalAmountDetailCardUI(),
                          Dimensions.kVerticalSpaceMedium,
                          isBudgetLoading
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
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Button(
                                        height: 56,
                                        onTap: onSubmit,
                                        child: Text(
                                          'Update',
                                          style: context.textTheme.bodySmall
                                              ?.copyWith(
                                                  color: Colors.white,
                                                  letterSpacing: .2),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                          Dimensions.kVerticalSpaceLarge,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget changeVehicleUI() {
    return CardContainer(
      isTrue: true,
      topChild: Padding(
        padding: Dimensions.kPaddingAllSmall,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select vehicle',
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
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: budgetBookingModel.budgetPackageList?.length,
            itemBuilder: (_, i) {
              final budget = budgetBookingModel.budgetPackageList![i];
              final res = i + 1;

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: InkWell(
                  onTap: () => {
                    setState(() => selectedIndex = res),
                    ref.read(budgetNotifierProvider).setVehicleType(budget.id!),
                    ref.read(budgetNotifierProvider).setBudgetMoving(budget),
                  },
                  borderRadius: Dimensions.kBorderRadiusAllSmaller,
                  child: Container(
                    width: 82,
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
                            : context.colorScheme.primary.withOpacity(.3),
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
                        Text(
                          budget.tonne ?? '',
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

  Widget changeAdditionalServicesUI() {
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
              'For wrapping, assembly, stair carry and long push service you need to use manpower service',
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
          height: 500,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2.4,
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

  Widget totalAmountDetailCardUI() {
    final selectVehicleType =
        ref.watch(budgetNotifierProvider).selectVehicleType ?? 0;

    final budgetPackage = ref.watch(budgetNotifierProvider).budgetPackage;
    final longPushType = ref.watch(budgetNotifierProvider).longPushType ?? [];

    final manPower = ref.watch(budgetNotifierProvider).manPowerCount ?? 0;
    final box = ref.watch(budgetNotifierProvider).boxCount ?? 0;

    final shrinkWrap = ref.watch(budgetNotifierProvider).shrinkWrap ?? 0;
    final bubbleWrap = ref.watch(budgetNotifierProvider).bubbleWrap ?? 0;

    final diningTable = ref.watch(budgetNotifierProvider).diningTable ?? 0;
    final bed = ref.watch(budgetNotifierProvider).bed ?? 0;
    final officeTable = ref.watch(budgetNotifierProvider).officeTable ?? 0;
    final wardrobe = ref.watch(budgetNotifierProvider).wardrobe ?? 0;

    final stairCarry = ref.watch(budgetNotifierProvider).stairCarry ?? 0;

    final tailGate = ref.watch(budgetNotifierProvider).tailGate ?? false;

    final longPush = ref.watch(budgetNotifierProvider).longPush ?? 0;

    final amountList = [
      Calculator.distanceAmount(int.parse(widget.distance), budgetPackage!),
      Calculator.manpowerAmount(manPower, budgetPackage),
      Calculator.boxAmount(box, budgetPackage),
      Calculator.shrinkWrapAmount(shrinkWrap, budgetPackage),
      Calculator.bubbleWrapAmount(bubbleWrap, budgetPackage),
      Calculator.diningTableAmount(diningTable, budgetPackage),
      Calculator.bedAmount(bed, budgetPackage),
      Calculator.officeTableAmount(officeTable, budgetPackage),
      Calculator.wardrobeAmount(wardrobe, budgetPackage),
      Calculator.stairCarryAmount(stairCarry, budgetPackage),
      Calculator.tailGateAmount(tailGate, budgetPackage),
      Calculator.longPushAmount(longPush, longPushType)
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
                amount: amountList[0].toStringAsFixed(2).toString()),
            const SizedBox(height: 2),
            manPower == 0
                ? const EmptyContainer()
                : PriceCardContainer(
                    label: 'Manpower x$manPower',
                    amount: amountList[1].toString(),
                  ),
            manPower == 0 ? const EmptyContainer() : const SizedBox(height: 2),
            box == 0
                ? const EmptyContainer()
                : PriceCardContainer(
                    label: 'Boxes x$box',
                    amount: amountList[2].toString(),
                  ),
            box == 0 ? const EmptyContainer() : const SizedBox(height: 2),
            shrinkWrap == 0
                ? const EmptyContainer()
                : PriceCardContainer(
                    label: 'Shrink Wrapping ',
                    amount: amountList[3].toString()),
            shrinkWrap == 0
                ? const EmptyContainer()
                : const SizedBox(height: 2),
            bubbleWrap == 0
                ? const EmptyContainer()
                : PriceCardContainer(
                    label: 'Bubble Wrapping ',
                    amount: amountList[4].toString()),
            bubbleWrap == 0
                ? const EmptyContainer()
                : const SizedBox(height: 2),
            bed == 0
                ? const EmptyContainer()
                : PriceCardContainer(
                    label: 'Bed x$bed', amount: amountList[5].toString()),
            bed == 0 ? const EmptyContainer() : const SizedBox(height: 2),
            wardrobe == 0
                ? const EmptyContainer()
                : PriceCardContainer(
                    label: 'Wardrobe x$wardrobe',
                    amount: amountList[6].toString()),
            wardrobe == 0 ? const EmptyContainer() : const SizedBox(height: 2),
            officeTable == 0
                ? const EmptyContainer()
                : PriceCardContainer(
                    label: 'Office Table x$officeTable',
                    amount: amountList[7].toString()),
            officeTable == 0
                ? const EmptyContainer()
                : const SizedBox(height: 2),
            diningTable == 0
                ? const EmptyContainer()
                : PriceCardContainer(
                    label: 'Dinning Table x$diningTable',
                    amount: amountList[8].toString()),
            diningTable == 0
                ? const EmptyContainer()
                : const SizedBox(height: 2),
            stairCarry == 0
                ? const EmptyContainer()
                : PriceCardContainer(
                    label: 'Stair Carry x$stairCarry',
                    amount: amountList[9].toString()),
            stairCarry == 0
                ? const EmptyContainer()
                : const SizedBox(height: 2),
            tailGate == false
                ? const EmptyContainer()
                : PriceCardContainer(
                    label: 'Tail Gate', amount: amountList[10].toString()),
            tailGate == false
                ? const EmptyContainer()
                : const SizedBox(height: 2),
            longPush == 0
                ? const EmptyContainer()
                : PriceCardContainer(
                    label: 'Long Push', amount: amountList[11].toString()),
            // if (jobDetailModel.additionalAmountHistoryList == null)
            //   const EmptyContainer()
            // else
            //   for (var i = 0;
            //       i < jobDetailModel.additionalAmountHistoryList!.length;
            //       i++)
            //     PriceCardContainer(
            //       label: 'Addition Service',
            //       amount:
            //           "${jobDetailModel.additionalAmountHistoryList![i].additionalAction ?? ''} ${jobDetailModel.additionalAmountHistoryList![i].additionalAmount ?? ''}",
            //     ),
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
              '${totalAmount.toStringAsFixed(2)} MYR',
              style: context.textTheme.headlineMedium?.copyWith(
                color: AppColor.secondaryText,
              ),
            ),
          ],
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
    if (res == 4) {
      return AppIcon.fourNotFour;
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
      return const ManpowerBottomSheet();
    } else if (res == 2) {
      return const BoxBottomSheet();
    } else if (res == 3) {
      return const WrappingBottomSheet();
    } else if (res == 4) {
      return const AssemblyDisassemblyBottomSheet();
    } else if (res == 5) {
      return const StairCarryBottomSheet();
    } else if (res == 6) {
      return const TailGateBottomSheet();
    } else if (res == 7) {
      return const LongPushBottomSheet();
    } else {
      return Container();
    }
  }

  void showRequestSuccessfulAlert() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColor.secondaryText,
        title: const Text("Budget Booking Successfully Updated",
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
    setState(() => isBudgetLoading = true);
    final userId = SharedPrefs.instance.getInt(AppKeys.userId) ?? 0;

    final selectVehicleType =
        ref.read(budgetNotifierProvider).selectVehicleType ?? 0;

    final budgetPackage = ref.read(budgetNotifierProvider).budgetPackage;
    final longPushType = ref.read(budgetNotifierProvider).longPushType ?? [];

    final manPower = ref.read(budgetNotifierProvider).manPowerCount ?? 0;
    final box = ref.read(budgetNotifierProvider).boxCount ?? 0;

    final shrinkWrap = ref.read(budgetNotifierProvider).shrinkWrap ?? 0;
    final bubbleWrap = ref.read(budgetNotifierProvider).bubbleWrap ?? 0;

    final diningTable = ref.read(budgetNotifierProvider).diningTable ?? 0;
    final bed = ref.read(budgetNotifierProvider).bed ?? 0;
    final officeTable = ref.read(budgetNotifierProvider).officeTable ?? 0;
    final wardrobe = ref.read(budgetNotifierProvider).wardrobe ?? 0;

    final stairCarry = ref.read(budgetNotifierProvider).stairCarry ?? 0;

    final tailGate = ref.read(budgetNotifierProvider).tailGate ?? false;

    final longPush = ref.read(budgetNotifierProvider).longPush ?? 0;

    final amountList = [
      Calculator.distanceAmount(int.parse(widget.distance), budgetPackage!),
      Calculator.manpowerAmount(manPower, budgetPackage),
      Calculator.boxAmount(box, budgetPackage),
      Calculator.shrinkWrapAmount(shrinkWrap, budgetPackage),
      Calculator.bubbleWrapAmount(bubbleWrap, budgetPackage),
      Calculator.diningTableAmount(diningTable, budgetPackage),
      Calculator.bedAmount(bed, budgetPackage),
      Calculator.officeTableAmount(officeTable, budgetPackage),
      Calculator.wardrobeAmount(wardrobe, budgetPackage),
      Calculator.stairCarryAmount(stairCarry, budgetPackage),
      Calculator.tailGateAmount(tailGate, budgetPackage),
      Calculator.longPushAmount(longPush, longPushType)
    ];

    var totalAmount = Calculator.totalAmount(amountList);
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
      formattedDate = jobDetail.bookingDateTime ?? "";
    }

    final budgetEntities = BudgetEntities(
      userId: userId,
      bookingId: widget.bookingId,
      bookingDate: formattedDate,
      customerId:
          budgetBookingModel.bookingBudgetEditDetails!.customerId.toString(),
      serviceType: 1,
      vehicleType: selectVehicleType.toString(),
      amount: double.parse(budgetPackage.basePrice ?? '0'),
      manpowerCount: manPower,
      boxCount: box,
      shrinkWrappingCount: shrinkWrap,
      bubbleWrappingCount: bubbleWrap,
      diningTableCount: diningTable,
      tableCount: officeTable,
      bedsCount: bed,
      wardrobeCount: wardrobe,
      stairCarrCount: stairCarry.toString(),
      tailGateEnabled: tailGate == true ? "Yes" : "No",
      longPushType: longPush,
      vehicleAmount: double.parse(amountList[0].toStringAsFixed(2)),
      manpowerAmount: amountList[1],
      boxAmount: amountList[2],
      shrinkWrapAmount: amountList[3],
      bubbleWrapAmount: amountList[4],
      diningAmount: amountList[5],
      bedAmount: amountList[6],
      tableAmount: amountList[7],
      wardrobeAmount: amountList[8],
      stairAmount: amountList[9],
      tailgateAmount: amountList[10],
      longPushAmount: amountList[11],
      totalAmount: double.parse(totalAmount.toStringAsFixed(2)),
    );

    ref.read(jobProvider.notifier).budgetBookingUpdate(budgetEntities).then(
          (response) => response.fold(
            (l) => {
              setState(() => isBudgetLoading = true),
              AppAlerts.displaySnackBar(context, 'Update Failed', false),
              Navigator.pop(context),
            },
            (r) => {
              setState(() => isBudgetLoading = true),
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
