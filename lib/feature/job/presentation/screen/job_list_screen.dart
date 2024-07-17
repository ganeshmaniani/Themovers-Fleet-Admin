import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../feature.dart';

class JobListScreen extends ConsumerStatefulWidget {
  static const String id = 'job_screen';

  final String stageId;
  final String stageName;

  const JobListScreen(
      {super.key, required this.stageId, required this.stageName});

  @override
  ConsumerState<JobListScreen> createState() => _JobListScreenConsumerState();
}

class _JobListScreenConsumerState extends ConsumerState<JobListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = true;

  List<JobList> jobList = [];

  @override
  void initState() {
    super.initState();
    initialCallback();
  }

  Future<void> initialCallback() async {
    WidgetsBinding.instance.addPostFrameCallback((__) {
      setState(() => isLoading = true);
      ref.read(jobProvider.notifier).jobList(widget.stageId).then(
            (response) => response.fold(
              (l) => {
                setState(() => {isLoading = false, jobList = []})
              },
              (r) => {
                setState(() => {isLoading = false, jobList = r.jobList ?? []})
              },
            ),
          );
    });
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
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          alignment: Alignment.center,
          height: 50,
          width: MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
              color: AppColor.primary, borderRadius: BorderRadius.circular(12)),
          child: Text(
            'Back',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          width: context.deviceSize.width,
          height: context.deviceSize.height / 1.1,
          // padding: Dimensions.kPaddingAllMedium,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Dimensions.kDivider,
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    // InkWell(
                    //   onTap: () => Navigator.pop(context),
                    //   child: const Icon(
                    //     Icons.arrow_back,
                    //     color: AppColor.accentText,
                    //   ),
                    // ),
                    // const SizedBox(width: 12),
                    Text(
                      widget.stageName,
                      style: context.textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              isLoading
                  ? const JobListShimmerLoading()
                  : Expanded(
                      child: jobList.isEmpty
                          ? const EmptyListContainer()
                          : RefreshIndicator(
                              onRefresh: () => initialCallback(),
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                padding: Dimensions.kPaddingAllMedium,
                                itemCount: jobList.length,
                                itemBuilder: (_, i) {
                                  return jobListCardUI(jobList[i]);
                                },
                              ),
                            ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget jobListCardUI(JobList job) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(
                JobDetailScreen.id,
                arguments: JobDetailScreen(
                  bookingId: job.id.toString(),
                  stageId: widget.stageId,
                  bookingName: "${job.serviceType} Booking",
                ),
              )
              .then((value) => initialCallback());
        },
        borderRadius: Dimensions.kBorderRadiusAllSmall,
        child: Container(
          width: context.deviceSize.width,
          decoration: BoxDecoration(
            color: AppColor.lightGrey,
            borderRadius: Dimensions.kBorderRadiusAllSmall,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Dimensions.kVerticalSpaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        top: 5, left: 16, right: 5, bottom: 5),
                    decoration: const BoxDecoration(color: AppColor.primary),
                    child: Text(
                      "${job.serviceType} Booking",
                      style: context.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColor.secondaryText),
                    ),
                  ),
                  Dimensions.kSpacer,
                  Text(
                    job.totalAmount == null
                        ? 'MYR 0.00'
                        : 'MYR ${job.totalAmount}',
                    style: context.textTheme.headlineMedium
                        ?.copyWith(color: AppColor.accentText),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
              Dimensions.kVerticalSpaceSmallest,
              Row(
                children: [
                  const SizedBox(width: 12),
                  job.pickupAddress == null
                      ? const EmptyContainer()
                      : SvgPicture.asset(
                          AppSvg.locationMark,
                          width: 14,
                          colorFilter: const ColorFilter.mode(
                            AppColor.accentText,
                            BlendMode.srcIn,
                          ),
                        ),
                  job.pickupAddress == null
                      ? const EmptyContainer()
                      : const SizedBox(width: 2),
                  job.pickupAddress == null
                      ? const EmptyContainer()
                      : Text(
                          'Pickup Address',
                          style: context.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.accentText),
                        ),
                  const SizedBox(width: 4),
                  job.dropOffAddress == null
                      ? const EmptyContainer()
                      : const Expanded(flex: 1, child: DottedDivider()),
                  job.dropOffAddress == null
                      ? const EmptyContainer()
                      : const SizedBox(width: 4),
                  job.dropOffAddress == null
                      ? const EmptyContainer()
                      : SvgPicture.asset(
                          AppSvg.locationMark,
                          width: 14,
                          colorFilter: const ColorFilter.mode(
                            AppColor.accentText,
                            BlendMode.srcIn,
                          ),
                        ),
                  job.dropOffAddress == null
                      ? const EmptyContainer()
                      : const SizedBox(width: 4),
                  job.dropOffAddress == null
                      ? const EmptyContainer()
                      : Text(
                          'Drop off Address',
                          style: context.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.accentText),
                        ),
                  const SizedBox(width: 12),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 28),
                  job.pickupAddress == null
                      ? const EmptyContainer()
                      : Expanded(
                          flex: 5,
                          child: Text(
                            job.pickupAddress ?? '',
                            style: context.textTheme.labelLarge
                                ?.copyWith(color: AppColor.accentText),
                          ),
                        ),
                  job.pickupAddress == null
                      ? const EmptyContainer()
                      : const SizedBox(width: 30),
                  job.dropOffAddress == null
                      ? const EmptyContainer()
                      : Expanded(
                          flex: 4,
                          child: Text(
                            job.dropOffAddress ?? '',
                            style: context.textTheme.labelLarge
                                ?.copyWith(color: AppColor.accentText),
                          ),
                        ),
                  const SizedBox(width: 12),
                ],
              ),
              Dimensions.kVerticalSpaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        top: 8, left: 8, right: 16, bottom: 8),
                    alignment: Alignment.center,
                    // height: 27,
                    decoration: const BoxDecoration(
                      color: AppColor.cyanBlue,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Text(
                      job.bookingDateTime == ''
                          ? ''
                          : job.bookingDateTime.toString(),
                      style: context.textTheme.labelMedium?.copyWith(
                        color: AppColor.secondaryText,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
