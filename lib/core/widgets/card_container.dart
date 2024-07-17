import 'package:flutter/material.dart';

import '../../../config/config.dart';

class CardContainer extends StatelessWidget {
  final Widget topChild;
  final Widget bottomChild;
  final bool isTrue;

  const CardContainer(
      {super.key,
      required this.topChild,
      required this.bottomChild,
      required this.isTrue});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: Dimensions.kBorderRadiusAllSmall,
        color: AppColor.lightGrey,
      ),
      child: Column(
        children: [
          Container(
            padding: Dimensions.kPaddingAllSmall,
            width: context.deviceSize.width,
            decoration: BoxDecoration(
              color: isTrue ? AppColor.primary : Colors.transparent,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: topChild,
          ),
          Container(
            padding: Dimensions.kPaddingAllSmall,
            width: context.deviceSize.width,
            decoration: BoxDecoration(
              color: isTrue ? Colors.transparent : AppColor.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: bottomChild,
          ),
        ],
      ),
    );
  }
}
