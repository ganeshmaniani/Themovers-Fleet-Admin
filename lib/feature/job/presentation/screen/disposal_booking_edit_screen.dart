import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../feature.dart';

class DisposalBookingEditScreen extends ConsumerStatefulWidget {
  static const String id = 'disposal_booking_edit_screen';

  final String bookingId;
  final String bookingStageId;

  const DisposalBookingEditScreen(
      {super.key, required this.bookingId, required this.bookingStageId});

  @override
  ConsumerState<DisposalBookingEditScreen> createState() =>
      _DisposalBookingEditScreenConsumerState();
}

class _DisposalBookingEditScreenConsumerState
    extends ConsumerState<DisposalBookingEditScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isDisposalLoading = false;

  DisposalBookingModel disposalBookings = DisposalBookingModel();

  int selectedIndex = 0;
  DateTime? selectedDate;
  JobDetail jobDetail = JobDetail();
  JobDetailModel jobDetailModel = JobDetailModel();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initialBookingDetails();
    initialCallback();
  }

  void initialBookingDetails() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(disposalNotifierProvider).setLoading(true);
      ref
          .read(jobProvider.notifier)
          .disposalBookingDetail(widget.bookingId)
          .then(
            (response) => response.fold(
              (l) => {
                setState(() => disposalBookings = DisposalBookingModel()),
                ref.read(disposalNotifierProvider).setLoading(false),
              },
              (r) => {
                setState(() => {
                      disposalBookings = r,
                      selectedIndex = vehicleType(
                          disposalBookings.disposalPackageList ?? [],
                          disposalBookings
                                  .bookingDisposalEditDetails?.vehicleType ??
                              '1 Tonne')
                    }),
                ref.read(disposalNotifierProvider).setLoading(false),
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

  int vehicleType(List<DisposalPackageList> disposalPackage, String label) {
    if (label == '1 Tonne') {
      ref.read(disposalNotifierProvider).setVehicleType(0);
      ref
          .read(disposalNotifierProvider)
          .setVehicleSpecification(disposalPackage[0].tonne ?? '');
      ref.read(disposalNotifierProvider).setDisposalPackage(disposalPackage[0]);
      return 1;
    }
    if (label == '3 Tonne') {
      ref.read(disposalNotifierProvider).setVehicleType(1);
      ref
          .read(disposalNotifierProvider)
          .setVehicleSpecification(disposalPackage[1].tonne ?? '');
      ref.read(disposalNotifierProvider).setDisposalPackage(disposalPackage[1]);
      return 2;
    }
    if (label == '5 Tonne') {
      ref.read(disposalNotifierProvider).setVehicleType(2);
      ref
          .read(disposalNotifierProvider)
          .setVehicleSpecification(disposalPackage[2].tonne ?? '');
      ref.read(disposalNotifierProvider).setDisposalPackage(disposalPackage[2]);
      return 3;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(disposalNotifierProvider).isLoading;
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Dimensions.kDivider,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Disposal Booking Edit",
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
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Dimensions.kVerticalSpaceSmall,
                          Text('Select Vehicle',
                              style: context.textTheme.titleLarge),
                          Dimensions.kVerticalSpaceSmallest,
                          Text(
                            'Price includes transport, manpower and disposal fee. we reserve the right to not accept wet waste or oil-based products.',
                            style: context.textTheme.labelLarge
                                ?.copyWith(color: AppColor.grey),
                          ),
                          Dimensions.kVerticalSpaceSmall,
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 420,
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 4 / 5,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                              itemCount:
                                  disposalBookings.disposalPackageList!.length -
                                      1,
                              itemBuilder: (_, i) {
                                final vehicle =
                                    disposalBookings.disposalPackageList![i];
                                final res = i + 1;
                                return InkWell(
                                  onTap: () => {
                                    setState(() => selectedIndex = res),
                                    // debugPrint(disposalPackage[i].basePrice),
                                    ref
                                        .read(disposalNotifierProvider)
                                        .setVehicleType(res),
                                    ref
                                        .read(disposalNotifierProvider)
                                        .setVehicleSpecification(
                                            vehicle.tonne ?? ''),
                                    ref
                                        .read(disposalNotifierProvider)
                                        .setDisposalPackage(vehicle),
                                  },
                                  borderRadius:
                                      Dimensions.kBorderRadiusAllSmaller,
                                  child: Container(
                                    padding: Dimensions.kPaddingAllSmaller,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          Dimensions.kBorderRadiusAllSmaller,
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: selectedIndex == res
                                            ? context.colorScheme.primary
                                            : Colors.black12,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Image(
                                              image: AssetImage(
                                                  selectVehicleTypeImage(i))),
                                        ),
                                        Dimensions.kVerticalSpaceSmallest,
                                        Text(
                                          selectVehicleTypeLabel(i),
                                          textAlign: TextAlign.center,
                                          style: context.textTheme.labelLarge
                                              ?.copyWith(
                                            color: selectedIndex == res
                                                ? context.colorScheme.primary
                                                : Colors.black54,
                                          ),
                                        ),
                                        Dimensions.kVerticalSpaceSmallest,
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Dimensions.kVerticalSpaceSmall,
                          totalAmountDetailCardUI(),
                          Dimensions.kVerticalSpaceMedium,
                          isDisposalLoading
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

  String selectVehicleTypeLabel(int i) {
    final res = i + 1;
    if (res == 1) {
      return '1 Tonne Lorry with 2 Manpower';
    }
    if (res == 2) {
      return '3 Tonne Lorry with 3 Manpower';
    }
    if (res == 3) {
      return '5 Tonne Lorry with 3 Manpower';
    }
    return '';
  }

  Widget totalAmountDetailCardUI() {
    final disposalPackage = ref.read(disposalNotifierProvider).disposalPackage;
    final totalAmount = double.parse(disposalPackage?.basePrice ?? '0');

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
            PriceCardContainer(label: 'Lorry ', amount: totalAmount.toString()),
            const SizedBox(height: 2),
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
              '${totalAmount.toString()} MYR',
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
        title: const Text("Disposal Booking Successfully Updated",
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
    setState(() => isDisposalLoading = true);
    final userId = SharedPrefs.instance.getInt(AppKeys.userId);

    final vehicleType =
        ref.read(disposalNotifierProvider).selectVehicleType ?? 0;

    final disposalPackage = ref.read(disposalNotifierProvider).disposalPackage;

    var totalAmount = double.parse(disposalPackage!.basePrice.toString());
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

    final disposalEntities = DisposalEntities(
      userId: userId ?? 0,
      bookingDate: formattedDate,
      customerId:
          disposalBookings.bookingDisposalEditDetails!.customerId.toString(),
      bookingId: widget.bookingId,
      serviceType: '3',
      vehicleType: vehicleType.toString(),
      amount: totalAmount,
      totalAmount: totalAmount,
    );

    ref.read(jobProvider.notifier).disposalBookingUpdate(disposalEntities).then(
          (response) => response.fold(
            (l) => {
              setState(() => isDisposalLoading = false),
              AppAlerts.displaySnackBar(context, 'Update Failed', false),
            },
            (r) => {
              setState(() => isDisposalLoading = false),
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
