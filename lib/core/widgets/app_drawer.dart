import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../feature/feature.dart';

class AppDrawer extends ConsumerStatefulWidget {
  const AppDrawer({super.key});

  @override
  ConsumerState<AppDrawer> createState() => _AppDrawerConsumerState();
}

class _AppDrawerConsumerState extends ConsumerState<AppDrawer> {
  bool isLoading = true;
  UserDetail user = UserDetail();

  @override
  void initState() {
    super.initState();
    initialCallback();
  }

  void initialCallback() async {
    WidgetsBinding.instance.addPostFrameCallback((__) {
      setState(() => isLoading = true);

      ref.read(accountProvider.notifier).userDetail().then(
            (response) => response.fold(
              (l) => {
                setState(() => {isLoading = false, user = UserDetail()})
              },
              (r) => {
                setState(() =>
                    {isLoading = false, user = r.userDetail ?? UserDetail()})
              },
            ),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const BeveledRectangleBorder(),
      child: SizedBox(
        height: context.deviceSize.height / 1.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 160,
              width: MediaQuery.of(context).size.width,
              color:
                  isLoading ? AppColor.lightGrey : context.colorScheme.primary,
              padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isLoading
                            ? const ShimmerSkeleton(width: 150, height: 20)
                            : Text(
                                user.name ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.headlineSmall
                                    ?.copyWith(color: Colors.white),
                              ),
                        const SizedBox(height: 4),
                        isLoading
                            ? const ShimmerSkeleton(width: 150, height: 20)
                            : Text(
                                "+60 ${user.mobileNumber ?? ''}",
                                style: context.textTheme.labelLarge
                                    ?.copyWith(color: Colors.white),
                              ),
                        const SizedBox(height: 1),
                        isLoading
                            ? const ShimmerSkeleton(width: 150, height: 20)
                            : Text(
                                user.email ?? '',
                                style: context.textTheme.labelLarge
                                    ?.copyWith(color: Colors.white),
                              ),
                      ],
                    ),
                  ),
                  isLoading
                      ? Shimmer.fromColors(
                          baseColor: AppColor.grey.withOpacity(.3),
                          highlightColor: AppColor.lightGrey,
                          child: Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              color: AppColor.cyanBlue,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: AppColor.secondaryText,
                                width: 2,
                                strokeAlign: isLoading
                                    ? BorderSide.strokeAlignInside
                                    : BorderSide.strokeAlignOutside,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: AppColor.cyanBlue,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: AppColor.secondaryText,
                              width: 2,
                              strokeAlign: BorderSide.strokeAlignOutside,
                            ),
                            image: user.profileImage == null
                                ? null
                                : DecorationImage(
                                    image: NetworkImage(
                                        "${ApiUrl.baseUrl}public/profile_uploads/${user.profileImage}"),
                                  ),
                          ),
                        ),
                ],
              ),
            ),
            Container(
              padding: Dimensions.kPaddingAllMedium,
              child: Column(
                children: [
                  // navigatorListCard(
                  //   context: context,
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, FAQScreen.id);
                  //   },
                  //   icon: AppIcon.theMoversHorizontalLogo,
                  //   label: 'FAQ',
                  // ),
                  Dimensions.kVerticalSpaceSmaller,
                  navigatorListCard(
                    context: context,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const HotLineNumberScreen()));
                    },
                    icon: AppIcon.theMoversHorizontalLogo,
                    label: 'Help & Support',
                  ),
                ],
              ),
            ),
            Dimensions.kVerticalSpaceLargest,
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Spacer(),
                  InkWell(
                    onTap: () async {
                      SharedPrefs.instance.remove(AppKeys.userId);
                      Navigator.pushNamedAndRemoveUntil(
                          context, AuthScreen.id, (route) => false);
                    },
                    child: Container(
                      height: 30,
                      width: 87,
                      decoration: BoxDecoration(
                          color: const Color(0xFF1B293D),
                          borderRadius: BorderRadius.circular(5)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                            image: AssetImage(AppIcon.logout),
                            width: 16,
                          ),
                          Text(
                            'Logout',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Dimensions.kVerticalSpaceMedium,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  navigatorListCard({
    required BuildContext context,
    required VoidCallback onPressed,
    required String icon,
    required String label,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          // Image(image: AssetImage(icon), width: 18),
          // Dimensions.kHorizontalSpaceMedium,
          Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class HotLineNumberScreen extends StatelessWidget {
  const HotLineNumberScreen({super.key});

  void openWhatsapp({required number, required message}) async {
    String url = 'whatsapp://send?phone=$number&text=$message';
    await launchUrl(Uri.parse(url));
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
        child: Container(
          padding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Dimensions.kDivider,
              Text('Help & Support', style: context.textTheme.bodyLarge),
              Dimensions.kVerticalSpaceSmaller,
              hotLineNumberBox(
                context,
                label: 'Help center(FAQ)',
                icon: Icons.help_center,
                onTap: () => Navigator.pushNamed(context, FAQScreen.id),
              ),
              hotLineNumberBox(
                context,
                label: 'Chat with us',
                icon: Icons.chat,
                onTap: () {
                  openWhatsapp(
                      number: " +60123244261",
                      message:
                          'Good day The Movers Online,we would like to request for a quote for our Moving!');
                },
              ),
              hotLineNumberBox(
                context,
                label: 'Terms & Conditions',
                icon: Icons.assignment,
                onTap: () =>
                    Navigator.pushNamed(context, TermConditionScreen.id),
              ),
              hotLineNumberBox(
                context,
                label: 'Privacy Policies',
                icon: Icons.policy,
                onTap: () => Navigator.pushNamed(context, TermPolicyScreen.id),
              ),
            ],
          ),
        ),
      ),
    );
  }

  hotLineNumberBox(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                icon,
                size: 18,
                color: AppColor.secondaryText,
              ),
            ),
            Dimensions.kHorizontalSpaceSmaller,
            Text(label, style: context.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
