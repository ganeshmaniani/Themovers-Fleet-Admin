import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../feature.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  static const String id = 'calendar_screen';

  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenConsumerState();
}

class _CalendarScreenConsumerState extends ConsumerState<CalendarScreen> {
  DateTime today = DateTime.now();

  List<CalenderBooking> _calenderBooking = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initialCallback();
  }

  void initialCallback() async {
    WidgetsBinding.instance.addPostFrameCallback((__) {
      setState(() => isLoading = true);
      ref
          .read(calenderProvider.notifier)
          .calenderList(DateFormat('yyyy-MM-dd').format(today))
          .then(
            (response) => response.fold(
              (l) => {
                setState(() => {_calenderBooking = [], isLoading = false}),
              },
              (r) => {
                setState(() => {
                      _calenderBooking = r.calenderBooking ?? [],
                      isLoading = false
                    }),
              },
            ),
          );
    });
  }

  void handleCalenderBookingList(DateTime date) async {
    WidgetsBinding.instance.addPostFrameCallback((__) {
      ref
          .read(calenderProvider.notifier)
          .calenderList(DateFormat('yyyy-MM-dd').format(date))
          .then(
            (response) => response.fold(
              (l) => {setState(() => _calenderBooking = [])},
              (r) => {
                setState(() => _calenderBooking = r.calenderBooking ?? []),
              },
            ),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: SizedBox(
        width: context.deviceSize.width,
        height: context.deviceSize.height / 1.16,
        // padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Dimensions.kDivider,
            Padding(
              padding:
                  const EdgeInsets.only(left: 16, right: 16, bottom: 4, top: 4),
              child: Text('Calendar', style: context.textTheme.bodyLarge),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColor.lightGrey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: EasyDateTimeLine(
                  initialDate: DateTime.now(),
                  onDateChange: (date) => handleCalenderBookingList(date),
                  activeColor: AppColor.primary,
                  headerProps: const EasyHeaderProps(
                    monthPickerType: MonthPickerType.switcher,
                    selectedDateFormat: SelectedDateFormat.fullDateDayAsStrMY,
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  ),
                  dayProps: EasyDayProps(
                    width: 40,
                    height: 80,
                    landScapeMode: true,
                    activeDayStyle: DayStyle(
                      decoration: BoxDecoration(
                        color: AppColor.primary,
                        border: Border.all(width: 1, color: AppColor.primary),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    inactiveDayStyle: DayStyle(
                      // borderRadius: 4,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: AppColor.primary),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    inactiveDayStrStyle: context.textTheme.labelLarge?.copyWith(
                      color: AppColor.primaryText,
                    ),
                    inactiveMothStrStyle:
                        context.textTheme.labelLarge?.copyWith(
                      color: AppColor.primaryText,
                      fontWeight: FontWeight.bold,
                    ),
                    inactiveDayNumStyle: context.textTheme.bodySmall?.copyWith(
                      color: AppColor.primaryText,
                      fontWeight: FontWeight.bold,
                    ),
                    activeDayStrStyle: context.textTheme.labelLarge?.copyWith(
                      color: AppColor.secondaryText,
                    ),
                    activeMothStrStyle: context.textTheme.labelLarge?.copyWith(
                      color: AppColor.secondaryText,
                      fontWeight: FontWeight.bold,
                    ),
                    activeDayNumStyle: context.textTheme.bodySmall?.copyWith(
                      color: AppColor.secondaryText,
                      fontWeight: FontWeight.bold,
                    ),
                    dayStructure: DayStructure.dayStrDayNum,
                  ),
                  timeLineProps: const EasyTimeLineProps(
                    hPadding: 4.0,
                    separatorPadding: 4.0,
                  ),
                ),
              ),
            ),
            Dimensions.kVerticalSpaceSmall,
            Container(
              width: context.deviceSize.width,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColor.lightGrey,
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: AppColor.primaryText.withOpacity(.2),
                  ),
                ),
              ),
              child: Text('History', style: context.textTheme.bodyMedium),
            ),
            Expanded(
              child: isLoading
                  ? const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: CalenderShimmerLoading(),
                    )
                  : _calenderBooking.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: EmptyListContainer(),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          itemCount: _calenderBooking.length,
                          itemBuilder: (_, i) {
                            return calendarHistoryUI(_calenderBooking[i]);
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget calendarHistoryUI(CalenderBooking calenderBooking) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => CalenderBookingDetailScreen(
                        bookingId: calenderBooking.id.toString(),
                        bookingName: selectServiceType(
                            calenderBooking.serviceType.toString()),
                      )));
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: context.deviceSize.width,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppColor.lightGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    serviceType(calenderBooking.serviceType.toString()),
                    style: context.textTheme.titleLarge
                        ?.copyWith(color: AppColor.cyanBlue),
                  ),
                  Text(
                    calenderBooking.totalAmount == null ||
                            calenderBooking.totalAmount == 'null' ||
                            calenderBooking.totalAmount == '0'
                        ? '0.00 MYR'
                        : '${calenderBooking.totalAmount} MYR',
                    style: context.textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w900, color: AppColor.cyanBlue),
                  ),
                ],
              ),
              calenderBooking.createdAt == null
                  ? const SizedBox()
                  : Dimensions.kVerticalSpaceSmallest,
              Text(
                calenderBooking.createdAt! == ''
                    ? ''
                    : calenderBooking.createdAt.toString().split(' ').first,
                style: context.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String serviceType(String type) {
    switch (type) {
      case '1':
        return "Budget\nBooking";
      case '2':
        return "Premium\nBooking";
      case '3':
        return "Disposal\nService";
      case '4':
        return "Tumpang\nService";
      case '5':
        return "Manpower\nBooking";
    }
    return '';
  }

  String selectServiceType(String type) {
    switch (type) {
      case '1':
        return "Budget Booking";
      case '2':
        return "Premium Booking";
      case '3':
        return "Disposal Service";
      case '4':
        return "Tumpang Service";
      case '5':
        return "Manpower Booking";
    }
    return '';
  }
}
