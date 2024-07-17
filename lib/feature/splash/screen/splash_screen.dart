import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:themovers_fleet_admin/config/config.dart';

import '../../../core/core.dart';
import '../../feature.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late GifController _gifController;

  @override
  void initState() {
    super.initState();
    _gifController = GifController(vsync: this);
    initialAppRoute();
  }

  void initialAppRoute() async {
    final userId = SharedPrefs.instance.getInt(AppKeys.userId);
    final auth = userId != null ? true : false;

    Future.delayed(
        const Duration(seconds: 5),
        () => {
              if (auth)
                {
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomeScreen.id, (route) => false)
                }
              else
                {
                  Navigator.pushNamedAndRemoveUntil(
                      context, AuthScreen.id, (route) => false)
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Gif(
          fps: 80,
          image: const AssetImage(AppIcon.introAnimation),
          controller: _gifController,
          autostart: Autostart.once,
          width: context.deviceSize.width,
        ),
      ),
    );
  }
}
