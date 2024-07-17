import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../../feature.dart';

class DashboardCarouselSlider extends ConsumerStatefulWidget {
  const DashboardCarouselSlider({super.key});

  @override
  ConsumerState<DashboardCarouselSlider> createState() =>
      _DashboardCarouselSliderConsumerState();
}

class _DashboardCarouselSliderConsumerState
    extends ConsumerState<DashboardCarouselSlider> {
  List<SlideImages> sliderImage = [];

  bool isLoading = false;
  String path = '';
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  void initState() {
    initialImageSlider();
    super.initState();
  }

  initialImageSlider() {
    setState(() => isLoading = true);
    ref
        .read(dashboardProvider.notifier)
        .dashboardCarouselSlider()
        .then((res) =>
        res.fold(
                (l) =>
            {
              setState(() =>
              {
                sliderImage = [],
                path = '',
                isLoading = false,
              })
            },
                (r) =>
            {
              setState(() =>
              {
                sliderImage = r.slideImages ?? [],
                path = r.path ?? '',
                isLoading = false,
              })
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () => Log.i(currentIndex.toString()),
          child: CarouselSlider(
            items: sliderImage
                .map(
                  (image) =>
                  Image.network(
                      ApiUrl.baseUrl + path + image.file.toString()),
            )
                .toList(),
            carouselController: carouselController,
            options: CarouselOptions(
              scrollPhysics: const BouncingScrollPhysics(),
              autoPlay: true,
              aspectRatio: 16 / 8,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() => currentIndex = index + 1);
              },
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: sliderImage.map((entry) {
              return GestureDetector(
                onTap: () =>
                    carouselController.animateToPage(int.parse(entry.name!)),
                child: Container(
                  width: currentIndex == int.parse(entry.name!) ? 17 : 7,
                  height: 7.0,
                  margin: const EdgeInsets.symmetric(horizontal: 3.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: currentIndex == int.parse(entry.name!)
                        ? AppColor.primary
                        : AppColor.cyanBlue,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
