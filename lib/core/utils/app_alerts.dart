import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/config.dart';
import '../../core/core.dart';

class AppAlerts {
  const AppAlerts._();

  static displaySnackBar(BuildContext context, String message, bool isSuccess) {
    final colorScheme = context.colorScheme;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: context.textTheme.bodyMedium
              ?.copyWith(color: AppColor.secondaryText),
        ),
        backgroundColor: isSuccess ? AppColor.success : colorScheme.error,
      ),
    );
  }

  static showBookingCancelQueryAlert(BuildContext context,
      {required TextEditingController controller,
      required VoidCallback onPressed}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          "Booking Cancel Reason",
          textAlign: TextAlign.center,
        ),
        actions: [
          TextFormField(
            autofocus: true,
            controller: controller,
            keyboardType: TextInputType.text,
            maxLines: 2,
            enableSuggestions: true,
            obscureText: false,
            enableInteractiveSelection: true,
            style: context.textTheme.bodyMedium,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Description',
            ),
          ),
          Dimensions.kVerticalSpaceSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColor.grey.withOpacity(.4),
                    borderRadius: Dimensions.kBorderRadiusAllSmaller,
                  ),
                  child: Text(
                    "cancel",
                    style: context.textTheme.labelLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
              TextButton(
                onPressed: onPressed,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: Dimensions.kBorderRadiusAllSmaller,
                  ),
                  child: Text(
                    "confirm",
                    style: context.textTheme.labelLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static showBookingCancelAlert(BuildContext context,
      {required VoidCallback onPressed}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          "Booking Cancel Request",
          textAlign: TextAlign.center,
        ),
        content: const Text("Are you sure confirm booking cancel!"),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColor.grey.withOpacity(.4),
                    borderRadius: Dimensions.kBorderRadiusAllSmaller,
                  ),
                  child: Text(
                    "cancel",
                    style: context.textTheme.labelLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
              TextButton(
                onPressed: onPressed,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: Dimensions.kBorderRadiusAllSmaller,
                  ),
                  child: Text(
                    "confirm",
                    style: context.textTheme.labelLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static showJobAcceptedAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
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
                onTap: () => {
                  Navigator.pop(ctx),
                  Navigator.pop(ctx),
                  Navigator.pop(ctx)
                },
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

  static showJobAcceptedAlertForNotification(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
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
                onTap: () => {
                  Navigator.pop(ctx),
                  Navigator.pop(ctx),
                },
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

  static showJobProgressAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColor.secondaryText,
        title:
            const Text("Job Successfully Started", textAlign: TextAlign.center),
        titleTextStyle: context.textTheme.headlineMedium,
        contentPadding: const EdgeInsets.all(0),
        actionsPadding: const EdgeInsets.only(bottom: 8),
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    "You can find in progress page",
                    textAlign: TextAlign.center,
                    style: context.textTheme.labelLarge
                        ?.copyWith(color: AppColor.grey),
                  ),
                  Dimensions.kVerticalSpaceSmall,
                  const Image(
                    image: AssetImage(AppIcon.successful),
                    width: 100,
                  ),
                ],
              )
            ],
          ),
          Dimensions.kVerticalSpaceSmaller,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Button(
                onTap: () => {
                  Navigator.pop(ctx),
                  Navigator.pop(ctx),
                  Navigator.pop(ctx),
                },
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

  static showJobCompleteAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColor.secondaryText,
        title: const Text("Job Successfully Complete",
            textAlign: TextAlign.center),
        titleTextStyle: context.textTheme.headlineMedium,
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    "Please receive full payment\nfrom customer",
                    textAlign: TextAlign.center,
                    style: context.textTheme.labelLarge
                        ?.copyWith(color: AppColor.grey),
                  ),
                  const Image(
                    image: AssetImage(AppIcon.successful),
                    width: 100,
                  ),
                ],
              ),
            ],
          ),
          Dimensions.kVerticalSpaceSmaller,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Button(
                onTap: () => {
                  Navigator.pop(ctx),
                  Navigator.pop(ctx),
                  Navigator.pop(ctx),
                  Navigator.pop(ctx),
                },
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

  static showTopUpRequestSuccessAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColor.secondaryText,
        title: const Text("Request Successfully", textAlign: TextAlign.center),
        titleTextStyle: context.textTheme.headlineMedium,
        actions: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(AppIcon.successful),
                width: 100,
              )
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

  static showProfileUpdateSuccessAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColor.secondaryText,
        title: const Text("Profile Successfully Updated",
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
              )
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

  static showDeleteRequestSuccessfulAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColor.secondaryText,
        title: const Text("Job Delete Request Successfully",
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
                onTap: () => {Navigator.pop(ctx), Navigator.pop(ctx)},
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

class AppUpdater extends StatefulWidget {
  final String label;
  final dynamic appVersion;
  final PackageInfo packageInfo;

  const AppUpdater(
      {super.key,
      required this.appVersion,
      required this.packageInfo,
      required this.label});

  @override
  State<AppUpdater> createState() => _AppUpdaterState();
}

class _AppUpdaterState extends State<AppUpdater> {
  double? progress = 0;
  int? status = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.secondaryText,
      alignment: Alignment.center,
      title: Text(
        "Update Available",
        style: context.textTheme.headlineMedium,
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              'A new version of the app is available. Please update to the new version now',
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall),
          // RichText(
          //   text: TextSpan(
          //     style: context.textTheme.labelLarge,
          //     children: [
          //       TextSpan(
          //           text: 'A ${widget.label} version of ',
          //           style: context.textTheme.bodySmall),
          //       TextSpan(
          //         text: '${widget.packageInfo.appName} ',
          //         style: context.textTheme.bodySmall
          //             ?.copyWith(fontWeight: FontWeight.bold),
          //       ),
          //       TextSpan(
          //           text: 'is available! Version ',
          //           style: context.textTheme.bodySmall),
          //       TextSpan(
          //         text: '${widget.appVersion} ',
          //         style: context.textTheme.bodySmall
          //             ?.copyWith(fontWeight: FontWeight.bold),
          //       ),
          //       TextSpan(
          //           text: ' is now available you have ',
          //           style: context.textTheme.bodySmall),
          //       TextSpan(
          //         text: widget.packageInfo.version,
          //         style: context.textTheme.bodySmall
          //             ?.copyWith(fontWeight: FontWeight.bold),
          //       ),
          //     ],
          //   ),
          // ),
          // Dimensions.kVerticalSpaceSmaller,
          // Text("Would you like to upgrade it now?",
          //     style: context.textTheme.bodySmall),
          Dimensions.kVerticalSpaceSmall,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TextButton(
              //   onPressed: () => {Navigator.pop(context)},
              //   child: Text(
              //     "LATER",
              //     style: context.textTheme.labelLarge?.copyWith(
              //         fontWeight: FontWeight.w500,
              //         color: appColor.warning600),
              //   ),
              // ),
              Button(
                onTap: () {
                  _launchPlayStore();
                },
                width: 150,
                child: Text(
                  "UPDATE NOW",
                  style: context.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _launchPlayStore() async {
    ///Android

    final packageInfo = await PackageInfo.fromPlatform();
    String url =
        'https://play.google.com/store/apps/details?id=${packageInfo.packageName}';

    ///IOS
    // String bundleId = "com.example.myapp"; // Replace with the Bundle ID of your app
    // String url = 'https://apps.apple.com/app/$bundleId';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
