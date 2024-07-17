import 'package:flutter/material.dart';

import '../config.dart';

@immutable
class Dimensions {
  //padding
  static const kPaddingAllLargest = EdgeInsets.all(50.0);
  static const kPaddingAllLarger = EdgeInsets.all(30.0);
  static const kPaddingAllLarge = EdgeInsets.all(20.0);
  static const kPaddingAllMedium = EdgeInsets.all(16.0);
  static const kPaddingAllSmall = EdgeInsets.all(8.0);
  static const kPaddingAllSmaller = EdgeInsets.all(4.0);

  //BorderRadius
  static final kBorderRadiusAllLarger = BorderRadius.circular(50);
  static final kBorderRadiusAllLarge = BorderRadius.circular(30);
  static final kBorderRadiusAllMedium = BorderRadius.circular(20);
  static final kBorderRadiusAllSmall = BorderRadius.circular(16);
  static final kBorderRadiusAllSmaller = BorderRadius.circular(12);
  static final kBorderRadiusAllSmallest = BorderRadius.circular(6);
  static const kRadiusAllSmallest = Radius.circular(6);

  //VerticalSpace
  static const kVerticalSpaceLargest = SizedBox(height: 100);
  static const kVerticalSpaceLarger = SizedBox(height: 50);
  static const kVerticalSpaceLarge = SizedBox(height: 30);
  static const kVerticalSpaceMedium = SizedBox(height: 20);
  static const kVerticalSpaceSmall = SizedBox(height: 16);
  static const kVerticalSpaceSmaller = SizedBox(height: 10);
  static const kVerticalSpaceSmallest = SizedBox(height: 8);

  //Horizontal Space
  static const kHorizontalSpaceLargest = SizedBox(width: 30);
  static const kHorizontalSpaceLarger = SizedBox(width: 24);
  static const kHorizontalSpaceLarge = SizedBox(width: 20);
  static const kHorizontalSpaceMedium = SizedBox(width: 16);
  static const kHorizontalSpaceSmall = SizedBox(width: 10);
  static const kHorizontalSpaceSmaller = SizedBox(width: 8);

  // Size
  static const double iconSizeLargest = 80;
  static const double iconSizeLarger = 48;
  static const double iconSizeLarge = 36;
  static const double iconSizeMedium = 30;
  static const double iconSizeSmall = 24;
  static const double iconSizeSmallest = 16;

  static const double sizeLargest = 50;
  static const double sizeLarger = 20;
  static const double sizeLarge = 18;
  static const double sizeMedium = 16;
  static const double sizeSmall = 12;
  static const double sizeSmaller = 8;
  static const double sizeSmallest = 6;

  static const double kAuthorTextFieldSize = 35;

  static const kSpacer = Spacer();

  static final kDivider = Divider(color: AppColor.primaryText.withOpacity(.2));
}
