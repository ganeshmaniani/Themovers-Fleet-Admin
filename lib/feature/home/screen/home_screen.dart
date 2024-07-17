import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:upgrader/upgrader.dart';

import '../../../config/config.dart';
import '../../../core/core.dart';
import '../../../feature/feature.dart';

class NavItem {
  final int id;
  final String icon;
  final String label;

  const NavItem({required this.id, required this.icon, required this.label});
}

class HomeScreen extends ConsumerStatefulWidget {
  static const String id = 'home_screen';

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenConsumerState();
}

class _HomeScreenConsumerState extends ConsumerState<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    initialCallback();
  }

  void initialCallback() async {
    final packageInfo = await PackageInfo.fromPlatform();

    WidgetsBinding.instance.addPostFrameCallback((__) {
      ref.read(dashboardProvider.notifier).versionCode().then(
            (response) => response.fold(
              (_) {},
              (version) {
                final Version currentVersion =
                    Version.parse(packageInfo.version ?? '');
                final Version latestVersion =
                    Version.parse(version.version ?? "");

                final comparison = currentVersion.compareTo(latestVersion);
                log("Comparision $comparison");

                if (comparison < 0) {
                  showUpdateAlert(version.version, packageInfo, 'old');
                } else if (comparison > 0) {
                  showUpdateAlert(version.version, packageInfo, 'new');
                }
              },
            ),
          );
    });
  }

  void showUpdateAlert(
      dynamic appVersion, PackageInfo packageInfo, String label) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AppUpdater(
            appVersion: appVersion, packageInfo: packageInfo, label: label);
      },
    );
  }

  final upgrader = Upgrader(
    debugLogging: false,
    // Disable for production
    debugDisplayAlways: false,
    // Disable for production
    languageCode: 'en',
    messages: UpgraderMessages(code: 'en'),
    minAppVersion: '2.0.0', // Adjust minimum required version
  );

  Widget currentPage(int index) {
    switch (index) {
      case 0:
        return const DashboardScreen();
      case 1:
        return const WalletScreen();
      case 2:
        return const CalendarScreen();
      case 3:
        return const AccountScreen();
    }
    return Container(alignment: Alignment.center, color: AppColor.disable);
  }

  final navigationItem = const [
    NavItem(id: 0, icon: AppSvg.dashboard, label: 'Dashboard'),
    NavItem(id: 1, icon: AppSvg.wallet, label: 'Wallet'),
    NavItem(id: 2, icon: AppSvg.calender, label: 'Calendar'),
    NavItem(id: 3, icon: AppSvg.account, label: 'Account'),
  ];

  @override
  Widget build(BuildContext context) {
    final navIndex = ref.watch(homeProvider);
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      appBar: navIndex.index == 3
          ? null
          : AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              title: const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Image(
                  image: AssetImage(AppIcon.theMoversHorizontalLogo),
                  width: 100,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Button(
                    onTap: () => _scaffoldKey.currentState?.openDrawer(),
                    width: 38,
                    height: 38,
                    child: SvgPicture.asset(AppSvg.menu),
                  ),
                ),
              ],
            ),
      body: currentPage(navIndex.index),
      //UpgradeAlert(
      //dialogStyle: UpgradeDialogStyle.material,
      //showLater: false,
      //  showIgnore: false,
      //  upgrader: upgrader,
      //  child: FutureBuilder<PackageInfo>(
      //     future: PackageInfo.fromPlatform(),
      //    builder: (context, snapshot) {
      //    if (snapshot.hasData) {
      //      final installedVersion = snapshot.data!.version;
      //        if (upgrader.shouldDisplayUpgrade()) {
      //         return const Center(child: Text('Update Available!'));
      //       } else {
      //         return currentPage(navIndex.index);
      //       }
      //    } else if (snapshot.hasError) {
      //       print('Error retrieving version: ${snapshot.error}');
      //       // Display a default widget (optional)
      //       return const Center(child: Text('Error checking for update'));
      //      }
      //       return const Center(child: CircularProgressIndicator());
      //       }),
// ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navIndex.index,
        onTap: (index) {
          ref.read(homeProvider.notifier).onIndexChanged(index);
        },
        elevation: 10,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: AppColor.secondaryText,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: AppColor.secondaryText.withOpacity(.4),
        backgroundColor: AppColor.primary,
        items: [
          ...navigationItem.map(
            (nav) => BottomNavigationBarItem(
              icon: SvgPicture.asset(
                nav.icon,
                width: 22,
                colorFilter: ColorFilter.mode(
                  navIndex.index == nav.id
                      ? AppColor.secondaryText
                      : AppColor.secondaryText.withOpacity(.4),
                  BlendMode.srcIn,
                ),
              ),
              label: nav.label,
            ),
          ),
        ],
      ),
    );
  }
}
