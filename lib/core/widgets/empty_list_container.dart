import 'package:flutter/material.dart';

import '../core.dart';

class EmptyListContainer extends StatelessWidget {
  const EmptyListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: const Image(
        image: AssetImage(AppIcon.listEmpty),
        width: 250,
      ),
    );
  }
}
