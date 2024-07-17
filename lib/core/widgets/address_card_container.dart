import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../../../config/config.dart';
import '../core.dart';

class AddressCardContainer extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPass;
  final Widget child;

  const AddressCardContainer({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.isPass,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: const LineStyle(color: AppColor.accent, thickness: 2),
      indicatorStyle: IndicatorStyle(
        drawGap: true,
        indicator: Padding(
          padding: const EdgeInsets.all(2),
          child: SvgPicture.asset(
            AppSvg.locationMark,
            width: 12,
            colorFilter:
                const ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
          ),
        ),
      ),
      endChild: Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: Dimensions.kBorderRadiusAllSmaller,
          ),
          child: child,
        ),
      ),
    );
  }
}
