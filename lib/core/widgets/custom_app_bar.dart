import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomAppBar({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      // automaticallyImplyLeading: false,
      // centerTitle: true,
      // leading: Padding(
      //   padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
      //   child: Button(
      //     onTap: () => Navigator.pop(context),
      //     width: 20,
      //     height: 20,
      //     child: const Icon(
      //       Icons.arrow_back_ios_rounded,
      //       color: AppColor.secondary,
      //     ),
      //   ),
      // ),
      title: const Image(
        image: AssetImage(AppIcon.theMoversHorizontalLogo),
        width: 100,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Button(
            onTap: onPressed,
            width: 38,
            height: 38,
            child: SvgPicture.asset(AppSvg.menu),
          ),
        ),
      ],
    );
  }
}
