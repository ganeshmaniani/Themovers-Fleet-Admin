import 'package:flutter/material.dart';
import 'package:themovers_fleet_admin/config/config.dart';

class IconBox extends StatelessWidget {
  final String label;
  final String icon;
  final String value;

  const IconBox(
      {super.key,
      required this.label,
      required this.icon,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 100,
      padding: Dimensions.kPaddingAllSmaller,
      decoration: BoxDecoration(
        borderRadius: Dimensions.kBorderRadiusAllSmallest,
        border: Border.all(
          color: AppColor.primary,
          width: 1,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(value, style: context.textTheme.labelMedium),
            ],
          ),
          const SizedBox(height: 4),
          Image(image: AssetImage(icon), width: 36),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: context.textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
