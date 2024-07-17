import 'package:flutter/material.dart';

import '../../../config/config.dart';

class PriceCardContainer extends StatelessWidget {
  final String label;
  final String amount;

  const PriceCardContainer(
      {super.key, required this.label, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: context.textTheme.titleMedium,
        ),
        Text(
          "$amount MYR",
          style: context.textTheme.titleSmall,
        ),
      ],
    );
  }
}
