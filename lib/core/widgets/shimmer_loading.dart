import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/config.dart';

class ShimmerSkeleton extends StatelessWidget {
  const ShimmerSkeleton(
      {super.key,
      this.width,
      this.height,
      this.color,
      this.radius,
      this.child});

  final double? width;
  final double? height;
  final double? radius;
  final Color? color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.grey.withOpacity(.3),
      highlightColor: AppColor.lightGrey,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? AppColor.secondary,
          border: Border.all(width: 1, color: AppColor.secondaryText),
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
        ),
        child: child,
      ),
    );
  }
}

class DashboardShimmerLoading extends StatelessWidget {
  const DashboardShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 2 / 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: 3,
      itemBuilder: (_, i) {
        return Container(
          decoration: BoxDecoration(
            color: AppColor.lightGrey,
            borderRadius: Dimensions.kBorderRadiusAllSmaller,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                right: 0,
                top: 0,
                child: Shimmer.fromColors(
                  baseColor: AppColor.grey.withOpacity(.3),
                  highlightColor: AppColor.lightGrey,
                  child: Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.only(left: 4, bottom: 6),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(60),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Shimmer.fromColors(
                  baseColor: AppColor.grey.withOpacity(.3),
                  highlightColor: AppColor.lightGrey,
                  child: Container(
                    width: 130,
                    height: 30,
                    padding: Dimensions.kPaddingAllSmall,
                    decoration: const BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        topLeft: Radius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              const Positioned(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShimmerSkeleton(width: 60, height: 60),
                    Dimensions.kVerticalSpaceSmaller,
                    ShimmerSkeleton(width: 80, height: 30),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class WalletShimmerLoading extends StatelessWidget {
  const WalletShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 24),
        itemCount: 6,
        itemBuilder: (_, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Container(
              width: context.deviceSize.width,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColor.lightGrey,
                borderRadius: Dimensions.kBorderRadiusAllSmall,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerSkeleton(width: 100, height: 40),
                      ShimmerSkeleton(width: 150, height: 40),
                    ],
                  ),
                  Dimensions.kVerticalSpaceSmaller,
                  ShimmerSkeleton(width: 120, height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CalenderShimmerLoading extends StatelessWidget {
  const CalenderShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 24),
      itemCount: 6,
      itemBuilder: (_, i) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Container(
            width: context.deviceSize.width,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppColor.lightGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerSkeleton(width: 120, height: 30),
                    ShimmerSkeleton(width: 150, height: 30),
                  ],
                ),
                Dimensions.kVerticalSpaceSmaller,
                ShimmerSkeleton(width: 180, height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FaqShimmerLoading extends StatelessWidget {
  const FaqShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 24),
        itemCount: 12,
        itemBuilder: (_, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Container(
              width: context.deviceSize.width,
              padding: Dimensions.kPaddingAllMedium,
              decoration: BoxDecoration(
                color: AppColor.lightGrey,
                borderRadius: Dimensions.kBorderRadiusAllSmaller,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerSkeleton(width: 180, height: 30),
                      ShimmerSkeleton(width: 70, height: 30),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class JobDetailShimmerLoading extends StatelessWidget {
  const JobDetailShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  ShimmerSkeleton(width: 150, height: 30),
                  Dimensions.kSpacer,
                  ShimmerSkeleton(width: 150, height: 20),
                ],
              ),
            ),
            Dimensions.kVerticalSpaceSmaller,
            Container(
              decoration: BoxDecoration(
                borderRadius: Dimensions.kBorderRadiusAllSmall,
                color: AppColor.lightGrey,
              ),
              child: Column(
                children: [
                  Shimmer.fromColors(
                    baseColor: AppColor.grey.withOpacity(.3),
                    highlightColor: AppColor.lightGrey,
                    child: Container(
                      height: 40,
                      padding: Dimensions.kPaddingAllSmall,
                      width: context.deviceSize.width,
                      decoration: const BoxDecoration(
                        color: AppColor.cyanBlue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: Dimensions.kPaddingAllSmall,
                    width: context.deviceSize.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: const Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerSkeleton(width: 180, height: 20),
                            ShimmerSkeleton(width: 70, height: 30),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerSkeleton(width: 140, height: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Dimensions.kVerticalSpaceSmaller,
            Container(
              decoration: BoxDecoration(
                borderRadius: Dimensions.kBorderRadiusAllSmall,
                color: AppColor.lightGrey,
              ),
              child: Column(
                children: [
                  Shimmer.fromColors(
                    baseColor: AppColor.grey.withOpacity(.3),
                    highlightColor: AppColor.lightGrey,
                    child: Container(
                      height: 40,
                      padding: Dimensions.kPaddingAllSmall,
                      width: context.deviceSize.width,
                      decoration: const BoxDecoration(
                        color: AppColor.cyanBlue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: Dimensions.kPaddingAllSmall,
                    width: context.deviceSize.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerSkeleton(width: 150, height: 30),
                        ShimmerSkeleton(width: 90, height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Dimensions.kVerticalSpaceSmaller,
            Container(
              decoration: BoxDecoration(
                borderRadius: Dimensions.kBorderRadiusAllSmall,
                color: AppColor.lightGrey,
              ),
              child: Column(
                children: [
                  Shimmer.fromColors(
                    baseColor: AppColor.grey.withOpacity(.3),
                    highlightColor: AppColor.lightGrey,
                    child: Container(
                      height: 40,
                      padding: Dimensions.kPaddingAllSmall,
                      width: context.deviceSize.width,
                      decoration: const BoxDecoration(
                        color: AppColor.cyanBlue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: Dimensions.kPaddingAllSmall,
                    width: context.deviceSize.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerSkeleton(width: 70, height: 70),
                        ShimmerSkeleton(width: 70, height: 70),
                        ShimmerSkeleton(width: 70, height: 70),
                        ShimmerSkeleton(width: 70, height: 70),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Dimensions.kVerticalSpaceSmaller,
            Container(
              decoration: BoxDecoration(
                borderRadius: Dimensions.kBorderRadiusAllSmall,
                color: AppColor.lightGrey,
              ),
              child: Column(
                children: [
                  Container(
                    padding: Dimensions.kPaddingAllSmall,
                    width: context.deviceSize.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: const Column(
                      children: [
                        Dimensions.kVerticalSpaceSmaller,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerSkeleton(width: 180, height: 20),
                            ShimmerSkeleton(width: 70, height: 20),
                          ],
                        ),
                        Dimensions.kVerticalSpaceSmaller,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerSkeleton(width: 180, height: 20),
                            ShimmerSkeleton(width: 70, height: 20),
                          ],
                        ),
                        Dimensions.kVerticalSpaceSmaller,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerSkeleton(width: 180, height: 20),
                            ShimmerSkeleton(width: 70, height: 20),
                          ],
                        ),
                        Dimensions.kVerticalSpaceSmaller,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerSkeleton(width: 180, height: 20),
                            ShimmerSkeleton(width: 70, height: 20),
                          ],
                        ),
                        Dimensions.kVerticalSpaceSmaller,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerSkeleton(width: 180, height: 20),
                            ShimmerSkeleton(width: 70, height: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: AppColor.grey.withOpacity(.3),
                    highlightColor: AppColor.lightGrey,
                    child: Container(
                      height: 40,
                      padding: Dimensions.kPaddingAllSmall,
                      width: context.deviceSize.width,
                      decoration: const BoxDecoration(
                        color: AppColor.cyanBlue,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Dimensions.kVerticalSpaceSmall,
            Shimmer.fromColors(
              baseColor: AppColor.grey.withOpacity(.3),
              highlightColor: AppColor.lightGrey,
              child: Container(
                height: 60,
                padding: Dimensions.kPaddingAllSmall,
                width: context.deviceSize.width,
                decoration: BoxDecoration(
                  color: AppColor.cyanBlue,
                  borderRadius: Dimensions.kBorderRadiusAllSmaller,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JobListShimmerLoading extends StatelessWidget {
  const JobListShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding:
            const EdgeInsets.only(bottom: 24, left: 16, right: 16, top: 16),
        itemCount: 6,
        itemBuilder: (_, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Container(
              width: context.deviceSize.width,
              decoration: BoxDecoration(
                color: AppColor.lightGrey,
                borderRadius: Dimensions.kBorderRadiusAllSmall,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Dimensions.kVerticalSpaceSmall,
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShimmerSkeleton(width: 160, height: 30, radius: 0),
                      Dimensions.kSpacer,
                      ShimmerSkeleton(width: 120, height: 30),
                      SizedBox(width: 18),
                    ],
                  ),
                  Dimensions.kVerticalSpaceSmall,
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ShimmerSkeleton(width: 150, height: 20),
                      ShimmerSkeleton(width: 150, height: 20),
                    ],
                  ),
                  Dimensions.kVerticalSpaceSmallest,
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ShimmerSkeleton(width: 150, height: 50),
                      ShimmerSkeleton(width: 150, height: 50),
                    ],
                  ),
                  Dimensions.kVerticalSpaceSmall,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Shimmer.fromColors(
                        baseColor: AppColor.grey.withOpacity(.3),
                        highlightColor: AppColor.lightGrey,
                        child: Container(
                          width: 150,
                          height: 30,
                          padding: Dimensions.kPaddingAllSmall,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: AppColor.cyanBlue,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class AccountShimmerLoading extends StatelessWidget {
  const AccountShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          width: context.deviceSize.width,
          padding:
              const EdgeInsets.only(top: 46, left: 16, right: 16, bottom: 16),
          decoration: const BoxDecoration(color: AppColor.lightGrey),
          child: Column(
            children: [
              Shimmer.fromColors(
                baseColor: AppColor.grey.withOpacity(.3),
                highlightColor: AppColor.lightGrey,
                child: Container(
                  height: 120,
                  width: 120,
                  padding: Dimensions.kPaddingAllMedium,
                  decoration: BoxDecoration(
                    color: AppColor.cyanBlue,
                    borderRadius: Dimensions.kBorderRadiusAllSmall,
                    border: Border.all(
                      color: AppColor.lightGrey,
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                  ),
                ),
              ),
              Dimensions.kVerticalSpaceSmaller,
              const ShimmerSkeleton(width: 150, height: 30),
              const SizedBox(height: 4),
              const ShimmerSkeleton(width: 200, height: 20),
              Dimensions.kVerticalSpaceSmallest,
              const ShimmerSkeleton(width: 100, height: 40),
            ],
          ),
        ),
        Dimensions.kVerticalSpaceMedium,
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ShimmerSkeleton(height: 60),
        ),
        Dimensions.kVerticalSpaceSmaller,
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ShimmerSkeleton(height: 60),
        ),
        Dimensions.kVerticalSpaceSmaller,
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ShimmerSkeleton(height: 60),
        ),
        Dimensions.kVerticalSpaceSmaller,
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ShimmerSkeleton(height: 60),
        ),
        Dimensions.kVerticalSpaceSmaller,
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerSkeleton(width: 100, height: 90),
              ShimmerSkeleton(width: 100, height: 90),
              ShimmerSkeleton(width: 100, height: 90),
            ],
          ),
        ),
        Dimensions.kVerticalSpaceLarge,
        const ShimmerSkeleton(width: 250, height: 30),
      ],
    );
  }
}
