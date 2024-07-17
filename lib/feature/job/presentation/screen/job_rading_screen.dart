import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../feature.dart';

class JobRatingScreen extends ConsumerStatefulWidget {
  static const String id = 'job_rating_screen';
  final String bookingId;

  const JobRatingScreen({super.key, required this.bookingId});

  @override
  ConsumerState<JobRatingScreen> createState() =>
      _JobRatingScreenConsumerState();
}

class _JobRatingScreenConsumerState extends ConsumerState<JobRatingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();

  int selectedStar = 0;
  bool isLoading = false;

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
        child: Container(
          width: context.deviceSize.width,
          height: context.deviceSize.height / 1.08,
          padding: Dimensions.kPaddingAllMedium,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Dimensions.kVerticalSpaceMedium,
              Dimensions.kDivider,
              Dimensions.kVerticalSpaceMedium,
              Text(
                'Please Rate your Experience',
                style: context.textTheme.headlineMedium,
              ),
              Dimensions.kVerticalSpaceMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  starShape(
                    color: selectedStar >= 1 ? AppColor.primary : AppColor.grey,
                    onTap: () {
                      if (selectedStar == 1) {
                        setState(() => selectedStar = 0);
                      } else {
                        setState(() => selectedStar = 1);
                      }
                    },
                  ),
                  const SizedBox(width: 4),
                  starShape(
                    color: selectedStar >= 2 ? AppColor.primary : AppColor.grey,
                    onTap: () {
                      setState(() => selectedStar = 2);
                    },
                  ),
                  const SizedBox(width: 4),
                  starShape(
                    color: selectedStar >= 3 ? AppColor.primary : AppColor.grey,
                    onTap: () {
                      setState(() => selectedStar = 3);
                    },
                  ),
                  const SizedBox(width: 4),
                  starShape(
                    color: selectedStar >= 4 ? AppColor.primary : AppColor.grey,
                    onTap: () {
                      setState(() => selectedStar = 4);
                    },
                  ),
                  const SizedBox(width: 4),
                  starShape(
                    color: selectedStar == 5 ? AppColor.primary : AppColor.grey,
                    onTap: () {
                      setState(() => selectedStar = 5);
                    },
                  ),
                ],
              ),
              Dimensions.kVerticalSpaceLargest,
              TextFormField(
                autofocus: true,
                controller: _controller,
                keyboardType: TextInputType.text,
                enableSuggestions: true,
                obscureText: false,
                enableInteractiveSelection: true,
                style: context.textTheme.bodyMedium,
                textAlignVertical: TextAlignVertical.top,
                // expands: true,
                // maxLines: null,
                maxLines: 10,
                minLines: 5,
                // maxLines: 5,
                decoration: textInputDecoration('Description'),
              ),
              Dimensions.kSpacer,
              isLoading
                  ? const CircularProgressIndicator()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Button(
                            onTap: onSubmit,
                            // width: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Submit Feedback',
                                  style: context.textTheme.bodySmall?.copyWith(
                                      color: AppColor.secondaryText,
                                      letterSpacing: .2),
                                ),
                                const SizedBox(width: 16),
                                const Icon(
                                  Icons.arrow_forward,
                                  color: AppColor.secondaryText,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 1,
                          child: Button(
                            onTap: () =>
                                AppAlerts.showJobCompleteAlert(context),
                            color: Colors.white,
                            child: Text(
                              'Skip',
                              style: context.textTheme.bodySmall?.copyWith(
                                  color: AppColor.primary, letterSpacing: .2),
                            ),
                          ),
                        ),
                      ],
                    ),
              Dimensions.kVerticalSpaceLargest,
            ],
          ),
        ),
      ),
    );
  }

  textInputDecoration(String label) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: Dimensions.kBorderRadiusAllSmallest,
        borderSide: BorderSide(color: colorScheme.primary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: Dimensions.kBorderRadiusAllSmallest,
        borderSide: BorderSide(color: colorScheme.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: Dimensions.kBorderRadiusAllSmallest,
        borderSide: BorderSide(color: colorScheme.error),
      ),
      alignLabelWithHint: true,
      contentPadding: Dimensions.kPaddingAllMedium,
      // label: Text(label),
      labelText: label,
      labelStyle: textTheme.bodySmall?.copyWith(
        color: colorScheme.secondary,
      ),
      errorStyle: textTheme.labelMedium?.copyWith(color: colorScheme.error),
    );
  }

  Widget starShape({required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: ShapeDecoration(
          color: color,
          shape: const StarBorder(
            points: 5,
            innerRadiusRatio: 0.35,
            pointRounding: 0,
            valleyRounding: 0,
            rotation: 0,
            squash: 0,
          ),
        ),
      ),
    );
  }

  void onSubmit() {
    setState(() => isLoading = true);
    final userId = SharedPrefs.instance.getInt(AppKeys.userId);
    final ratingEntities = RatingEntities(
      userId: userId.toString(),
      bookingId: widget.bookingId,
      ratings: selectedStar.toString(),
      feedback: _controller.text,
    );

    ref.read(jobProvider.notifier).ratingUpdate(ratingEntities).then(
          (response) => response.fold(
            (l) => {
              AppAlerts.displaySnackBar(context, l.message, false),
              setState(() => isLoading = false),
            },
            (r) => {
              setState(() => isLoading = false),
              AppAlerts.showJobCompleteAlert(context),
            },
          ),
        );
  }
}
