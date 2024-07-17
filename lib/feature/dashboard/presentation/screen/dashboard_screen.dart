import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../../feature/feature.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  static const String id = 'dashboard_screen';

  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() =>
      _DashboardScreenConsumerState();
}

class _DashboardScreenConsumerState extends ConsumerState<DashboardScreen> {
  String status = "success";
  JobStatusModel jobStatusModel = JobStatusModel();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initialCallback();
  }

  void initialCallback() async {
    WidgetsBinding.instance.addPostFrameCallback((__) {
      setState(() => isLoading = true);
      ref.read(dashboardProvider.notifier).accountActivation().then(
            (response) => response.fold(
              (l) => {setState(() => status = l.message)},
              (r) => {setState(() => status = r.name)},
            ),
          );
      ref.read(dashboardProvider.notifier).jobStatus().then(
            (response) => response.fold(
              (l) => {
                setState(() =>
                    {isLoading = false, jobStatusModel = JobStatusModel()})
              },
              (r) => {
                setState(() => {isLoading = false, jobStatusModel = r})
              },
            ),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final userName = SharedPrefs.instance.getString(AppKeys.name);
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 6),
          child: RichText(
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              text: "Welcome Back! ",
              style: context.textTheme.bodyMedium
                  ?.copyWith(color: AppColor.grey, fontWeight: FontWeight.w400),
              children: [
                TextSpan(
                  text: userName,
                  style: context.textTheme.headlineMedium
                      ?.copyWith(color: AppColor.primary),
                )
              ],
            ),
          ),
        ),
        Dimensions.kVerticalSpaceSmaller,
        const DashboardCarouselSlider(),
        Dimensions.kVerticalSpaceSmallest,
        if (status != "success")
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF1F2),
                borderRadius: Dimensions.kBorderRadiusAllSmaller,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'No Connection Found',
                        style: context.textTheme.bodySmall?.copyWith(
                            color: AppColor.primary,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        'Please check your network connection',
                        style: context.textTheme.labelMedium?.copyWith(
                          color: AppColor.primary,
                        ),
                      ),
                    ],
                  ),
                  Image.asset('assets/icons/no_signal.png',
                      width: 30, color: AppColor.primary)
                ],
              ),
            ),
          )
        else
          const EmptyContainer(),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
          child: Text(
            'Job Status',
            style: context.textTheme.headlineMedium?.copyWith(
                color: AppColor.primaryText.withOpacity(.5),
                fontWeight: FontWeight.w500),
          ),
        ),
        Dimensions.kDivider,
        isLoading
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(height: 350, child: DashboardShimmerLoading()),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 350,
                  child: GridView.builder(
                    // physics: const AlwaysScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8),
                    itemCount: 3, // Number of items
                    itemBuilder: (BuildContext context, int index) {
                      final jobStatusName =
                          jobStatusModel.jobStatus?[index].jobStatusName;
                      if (jobStatusName != null) {
                        return jobStatusCardUI(
                            label: "$jobStatusName Jobs",
                            icon: icon(index + 1),
                            count: count(index + 1, jobStatusModel.jobCount!));
                      }
                      return Container();
                    },
                  ),
                  // child: Wrap(
                  //   runAlignment: WrapAlignment.spaceBetween,
                  //   alignment: WrapAlignment.spaceBetween,
                  //   children: [
                  //     jobStatusCardUI(
                  //       label:
                  //           "${jobStatusModel.jobStatus?[0].jobStatusName} Jobs",
                  //       icon: icon(1),
                  //       count: count(1, jobStatusModel.jobCount!),
                  //     ),
                  //     jobStatusCardUI(
                  //       label:
                  //           "${jobStatusModel.jobStatus?[1].jobStatusName} Jobs",
                  //       icon: icon(2),
                  //       count: count(2, jobStatusModel.jobCount!),
                  //     ),
                  //     jobStatusCardUI(
                  //       label:
                  //           "${jobStatusModel.jobStatus?[2].jobStatusName} Jobs",
                  //       icon: icon(3),
                  //       count: count(3, jobStatusModel.jobCount!),
                  //     ),
                  //     jobStatusCardUI(
                  //       label:
                  //           "${jobStatusModel.jobStatus?[3].jobStatusName} Jobs",
                  //       icon: icon(4),
                  //       count: count(4, jobStatusModel.jobCount!),
                  //     ),
                  //   ],
                  // ),
                ),
              ),
      ],
    );
  }

  Widget jobStatusCardUI(
      {required String label, required String icon, required String count}) {
    return InkWell(
      onTap: () => navigatorToJobScreen(label),
      borderRadius: Dimensions.kBorderRadiusAllSmaller,
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        width: 160,
        height: 170,
        decoration: BoxDecoration(
          color: AppColor.lightGrey,
          borderRadius: Dimensions.kBorderRadiusAllSmaller,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.only(left: 4, bottom: 6),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(60),
                  ),
                ),
                child: SvgPicture.asset(
                  AppSvg.arrowRight,
                  width: 18,
                  colorFilter: const ColorFilter.mode(
                    AppColor.secondaryText,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: Dimensions.kPaddingAllSmaller,
                decoration: const BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(6),
                    topLeft: Radius.circular(6),
                  ),
                ),
                child: Text(
                  label,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: AppColor.secondaryText,
                  ),
                ),
              ),
            ),
            Positioned(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(icon),
                    width: 64,
                  ),
                  Dimensions.kVerticalSpaceSmaller,
                  Text(
                    count,
                    style: context.textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String icon(int position) {
    switch (position) {
      case 1:
        return AppIcon.available;
      case 2:
        return AppIcon.accepted;
      // case 3:
      //   return AppIcon.inprogress;
      case 4:
        return AppIcon.completed;
    }
    return AppIcon.available;
  }

  String count(int position, JobCount jobCount) {
    switch (position) {
      case 1:
        return jobCount.available.toString();
      case 2:
        return jobCount.accepted.toString();
      // case 3:
      //   return jobCount.inProgress.toString();
      case 3:
        return jobCount.completed.toString();
    }
    return "0";
  }

  void navigatorToJobScreen(String label) {
    switch (label) {
      case "Available Jobs":
        Navigator.of(context)
            .pushNamed(JobListScreen.id,
                arguments: const JobListScreen(
                    stageId: '1', stageName: 'Available Jobs'))
            .then((value) => initialCallback());
        break;
      case "Accepted Jobs":
        Navigator.of(context)
            .pushNamed(JobListScreen.id,
                arguments: const JobListScreen(
                    stageId: '2', stageName: 'Accepted Jobs'))
            .then((value) => initialCallback());
        break;
      // case "In Progress Jobs":
      //   Navigator.of(context)
      //       .pushNamed(JobListScreen.id,
      //           arguments: const JobListScreen(
      //               stageId: '3', stageName: 'In Progress Jobs'))
      //       .then((value) => initialCallback());
      //   break;
      case "Completed Jobs":
        Navigator.of(context)
            .pushNamed(JobListScreen.id,
                arguments: const JobListScreen(
                    stageId: '4', stageName: 'Completed Jobs'))
            .then((value) => initialCallback());
        break;
      default:
        break;
    }
  }
}
