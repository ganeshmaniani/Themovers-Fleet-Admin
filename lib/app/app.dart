import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers_fleet_admin/feature/feature.dart';
import 'package:upgrader/upgrader.dart';

import '../config/config.dart';
import '../core/core.dart';

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey<NavigatorState>(debugLabel: "Main Navigator Key");

class FleetAdmin extends ConsumerStatefulWidget {
  const FleetAdmin({super.key});

  @override
  ConsumerState<FleetAdmin> createState() => _FleetAdminConsumerState();
}

class _FleetAdminConsumerState extends ConsumerState<FleetAdmin> {
  LocalNotificationServices localNotificationServices =
      LocalNotificationServices();

  @override
  void initState() {
    super.initState();
    initialCallBack();
  }

  void initialCallBack() {
    localNotificationServices.requestNotificationPermission();
    localNotificationServices.firebaseInit(context);
    localNotificationServices.setupInteractMessage(context);

    localNotificationServices.getDeviceToken().then((token) {
      Log.i(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'The Movers Online - Fleet  Admin',
      debugShowCheckedModeBanner: false,
      theme: GeneratorTheme.lightTheme,
      darkTheme: GeneratorTheme.darkTheme,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: SplashScreen.id,
      home: UpgradeAlert(
        child: SplashScreen(),
      ),
    );
  }
}
