import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../feature.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {
  static const String id = 'forget_password_otp_screen';
  final String email;

  const OtpVerificationScreen({super.key, required this.email});

  @override
  ConsumerState<OtpVerificationScreen> createState() =>
      _OtpVerificationScreenConsumerState();
}

class _OtpVerificationScreenConsumerState
    extends ConsumerState<OtpVerificationScreen> with InputValidationMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _pin1Controller = TextEditingController();
  final _pin2Controller = TextEditingController();
  final _pin3Controller = TextEditingController();
  final _pin4Controller = TextEditingController();
  final _pin5Controller = TextEditingController();
  final _pin6Controller = TextEditingController();

  bool isLoading = false;

  int _secondsRemaining = 20;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    initialCallback();
  }

  void initialCallback() async {
    WidgetsBinding.instance.addPostFrameCallback((__) {
      startTimer();
      ref.read(authProvider.notifier).otpGenerator(widget.email).then(
            (response) => response.fold(
              (l) => {},
              (r) => {},
            ),
          );
    });
  }

  void startTimer() {
    const oneSecond = Duration(seconds: 2);
    _timer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  resentOtp() {
    initialCallback();
    _secondsRemaining = 20;
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Dimensions.kVerticalSpaceLarger,
              Dimensions.kVerticalSpaceSmall,
              const Image(
                image: AssetImage(AppIcon.otpIllustration),
                width: 210,
              ),
              Dimensions.kVerticalSpaceLarge,
              Text(
                'OTP Verification',
                style: textTheme.displayMedium
                    ?.copyWith(fontSize: 30, color: AppColor.accentText),
              ),
              Dimensions.kVerticalSpaceSmall,
              SizedBox(
                width: 225,
                child: Text(
                  'Check your Email to see the verification code',
                  textAlign: TextAlign.center,
                  style: textTheme.bodySmall?.copyWith(
                    fontSize: 15,
                    color: Colors.black.withOpacity(.5),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Dimensions.kVerticalSpaceLarge,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    otpInputFormat(_pin1Controller),
                    otpInputFormat(_pin2Controller),
                    otpInputFormat(_pin3Controller),
                    otpInputFormat(_pin4Controller),
                    otpInputFormat(_pin5Controller),
                    otpInputFormat(_pin6Controller)
                  ],
                ),
              ),
              Dimensions.kVerticalSpaceSmall,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: _secondsRemaining != 0
                      ? Text('Wait $_secondsRemaining seconds remaining',
                          style: textTheme.labelLarge)
                      : GestureDetector(
                          onTap: resentOtp,
                          child: Text(
                            'Resend?',
                            style: textTheme.labelLarge?.copyWith(
                                color: context.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                                letterSpacing: .6),
                          ),
                        ),
                ),
              ),
              Dimensions.kSpacer,
              isLoading
                  ? const CircularProgressIndicator()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Button(
                        onTap: verifyOTPRequest,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Verify',
                              style: context.textTheme.bodySmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 110),
                            SizedBox(
                              child: SvgPicture.asset(
                                AppSvg.arrowRight,
                                width: 18,
                                colorFilter: const ColorFilter.mode(
                                  AppColor.secondaryText,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                          ],
                        ),
                      ),
                    ),
              Dimensions.kVerticalSpaceLarger,
            ],
          ),
        ),
      ),
    );
  }

  otpInputFormat(TextEditingController controller) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: 60,
      width: 50,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: const Border(
          left: BorderSide(color: AppColor.primary),
          top: BorderSide(color: AppColor.primary),
          right: BorderSide(color: AppColor.primary),
          bottom: BorderSide(width: 0.25, color: AppColor.primary),
        ),
      ),
      child: TextFormField(
        maxLength: 1,
        autofocus: true,
        controller: controller,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        style: textTheme.bodyMedium,
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
          contentPadding: Dimensions.kPaddingAllMedium,
        ),
      ),
    );
  }

  Future<void> verifyOTPRequest() async {
    setState(() => isLoading = true);
    final emailOtpEntities = EmailOtpEntities(
        email: widget.email,
        otp: _pin1Controller.text +
            _pin2Controller.text +
            _pin3Controller.text +
            _pin4Controller.text +
            _pin5Controller.text +
            _pin6Controller.text);
    ref.read(authProvider.notifier).otpChecker(emailOtpEntities).then(
          (response) => response.fold(
            (l) => {
              setState(() => isLoading = false),
              AppAlerts.displaySnackBar(context, l.message, false),
              Navigator.pop(context),
            },
            (r) => {
              setState(() => isLoading = false),
              Navigator.pushNamed(context, CreateNewPassword.id,
                  arguments: CreateNewPassword(email: widget.email)),
            },
          ),
        );
  }
}
