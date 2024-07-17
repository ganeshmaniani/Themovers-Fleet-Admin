import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/config.dart';
import '../../feature/feature.dart';
import '../core.dart';

class CustomSliderButton extends ConsumerStatefulWidget {
  final double width;
  final double height;
  final String text;
  final String stageId;
  final String bookingId;
  final bool isNotification;

  const CustomSliderButton(
      {super.key,
      this.isNotification = true,
      required this.width,
      required this.height,
      required this.text,
      required this.bookingId,
      required this.stageId});

  @override
  ConsumerState<CustomSliderButton> createState() =>
      _CustomSliderButtonConsumerState();
}

class _CustomSliderButtonConsumerState extends ConsumerState<CustomSliderButton>
    with SingleTickerProviderStateMixin {
  double _value = 0.0;
  bool _isDragging = false;
  bool _isSliderCompleted = false;
  bool _isLoading = false;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  /// New value gets the new update of horizontal drag every times updates value
  void _updateValue(double newValue) {
    setState(() {
      _value = newValue.clamp(0, 1);
      if (_value >= 0.6) {
        _isSliderCompleted = true;
        _isLoading = true;
      } else {
        _isSliderCompleted = false;
        _isLoading = false;
        _controller.reset();
      }
    });
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    _isDragging = true;
    _updateValue(details.localPosition.dx / widget.width);
  }

  /// Function to get the slider at initial position if slider is released mid way
  void _onHorizontalDragEnd(DragEndDetails details) {
    _isDragging = false;
    if (_value >= 0.6) {
      slideToUpdateJobStage();
    }
    if (!_isSliderCompleted) {
      _updateValue(0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.height / 6),
          color: _isSliderCompleted ? AppColor.background : AppColor.background,
          border: Border.all(
            width: 2,
            color: _isSliderCompleted || _isDragging
                ? AppColor.cyanBlue
                : AppColor.primary,
          ),
        ),
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 0),
              width: _isSliderCompleted
                  ? widget.width
                  : _value < 0.1
                      ? _value * widget.width
                      : (_value * 0.5) * widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.height / 6),
                // color: _isDragging ? AppColor.cyanBlue : AppColor.primary,
              ),
              child: _isSliderCompleted
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _isLoading
                            ? const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: CircularProgressIndicator(
                                  color: AppColor.cyanBlue,
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.cyanBlue,
                                ),
                                child: const Icon(Icons.check,
                                    color: AppColor.secondaryText, size: 18),
                              ),
                        const SizedBox(width: 8),
                        Text(
                          widget.text,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: AppColor.cyanBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ),
            if (!_isSliderCompleted)
              Positioned(
                top: widget.height * 0.07,
                left: _value * (widget.width - widget.height) +
                    widget.height * 0.07,
                child: Container(
                  height: widget.height * 0.8,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.height / 6),
                    color: _isDragging ? AppColor.cyanBlue : AppColor.primary,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 12),
                      SvgPicture.asset(
                        AppSvg.arrowRight,
                        colorFilter: const ColorFilter.mode(
                            AppColor.secondaryText, BlendMode.srcIn),
                      ),
                    ],
                  ),
                ),
              ),
            // if (!_isSliderCompleted)
            //   Positioned(
            //     top: widget.height * 0.25,
            //     right: _value * (widget.width - widget.height) +
            //         widget.height * 0.1,
            //     child: Container(
            //       width: widget.width - widget.height,
            //       height: widget.height * 0.8,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(widget.height / 6),
            //         color: Colors.transparent,
            //       ),
            //       child: Text(
            //         widget.text,
            //         textAlign: TextAlign.center,
            //         style: const TextStyle(
            //           color: Colors.deepPurple,
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ),
            //   ),
            // if (_isSliderCompleted)
            //   Positioned(
            //     top: 0,
            //     left: 0,
            //     child: FadeTransition(
            //       opacity: _animation,
            //       child: SizedBox(
            //         width: widget.width,
            //         height: widget.height,
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Container(
            //               padding: const EdgeInsets.all(4),
            //               decoration: const BoxDecoration(
            //                   shape: BoxShape.circle, color: Colors.white),
            //               child: const Icon(Icons.check,
            //                   color: Colors.white, size: 18),
            //             ),
            //             const SizedBox(width: 8),
            //             Text(
            //               widget.text,
            //               style: const TextStyle(
            //                 fontSize: 16,
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }

  void slideToUpdateJobStage() {
    if (widget.stageId == '1') {
      final jobStageUpdateEntities =
          JobStageUpdateEntities(stageId: "2", bookingId: widget.bookingId);
      ref.read(jobProvider.notifier).jobUpdate(jobStageUpdateEntities).then(
            (response) => response.fold(
              (l) => {
                setState(() {
                  _isSliderCompleted = false;
                  _isLoading = false;
                  _controller.reset();
                  _updateValue(0.0);
                }),
                AppAlerts.displaySnackBar(context, l.message, false),
              },
              (r) => {
                setState(() => _isLoading = false),
                widget.isNotification
                    ? AppAlerts.showJobAcceptedAlert(context)
                    : AppAlerts.showJobAcceptedAlertForNotification(context),
              },
            ),
          );
    }
    // if (widget.stageId == '2') {
    //   final jobStageUpdateEntities =
    //       JobStageUpdateEntities(stageId: "3", bookingId: widget.bookingId);
    //   ref.read(jobProvider.notifier).jobUpdate(jobStageUpdateEntities).then(
    //         (response) => response.fold(
    //           (l) => {
    //             setState(() => {
    //                   _isSliderCompleted = false,
    //                   _isLoading = false,
    //                   _controller.reset(),
    //                   _updateValue(0.0),
    //                 }),
    //             AppAlerts.displaySnackBar(context, l.message, false),
    //           },
    //           (r) => {
    //             setState(() => _isLoading = false),
    //             AppAlerts.showJobProgressAlert(context),
    //           },
    //         ),
    //       );
    // }
    if (widget.stageId == '2') {
      final jobStageUpdateEntities =
          JobStageUpdateEntities(stageId: "4", bookingId: widget.bookingId);
      ref
          .read(jobProvider.notifier)
          .jobCompleteStageUpdate(jobStageUpdateEntities)
          .then(
            (response) => response.fold(
              (l) => {
                setState(() {
                  _isSliderCompleted = false;
                  _isLoading = false;
                  _controller.reset();
                  _updateValue(0.0);
                }),
                AppAlerts.displaySnackBar(context, l.message, false),
              },
              (r) => {
                setState(() => _isLoading = false),
                Navigator.pushNamed(context, JobRatingScreen.id,
                    arguments: JobRatingScreen(bookingId: widget.bookingId)),
              },
            ),
          );
    }
  }
}
