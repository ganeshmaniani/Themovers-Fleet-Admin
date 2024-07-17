import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../auth.dart';

class RegistrationOTPScreen extends ConsumerStatefulWidget {
  static const String id = 'registration_otp_screen';

  final RegisterEntities registerEntities;
  final String email;

  const RegistrationOTPScreen(
      {super.key, required this.email, required this.registerEntities});

  @override
  ConsumerState<RegistrationOTPScreen> createState() =>
      _RegistrationOTPScreenState();
}

class _RegistrationOTPScreenState extends ConsumerState<RegistrationOTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var otp1Controller = TextEditingController();
  var otp2Controller = TextEditingController();
  var otp3Controller = TextEditingController();
  var otp4Controller = TextEditingController();
  var otp5Controller = TextEditingController();
  var otp6Controller = TextEditingController();

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
    final textTheme = Theme.of(context).textTheme;
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
                    otpInputFormat(otp1Controller),
                    otpInputFormat(otp2Controller),
                    otpInputFormat(otp3Controller),
                    otpInputFormat(otp4Controller),
                    otpInputFormat(otp5Controller),
                    otpInputFormat(otp6Controller)
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
    final emailOtpEntities = EmailOtpEntities(
        email: widget.email,
        otp: otp1Controller.text +
            otp2Controller.text +
            otp3Controller.text +
            otp4Controller.text +
            otp5Controller.text +
            otp6Controller.text);
    ref.read(authProvider.notifier).otpChecker(emailOtpEntities).then(
          (response) => response.fold(
            (l) => {AppAlerts.displaySnackBar(context, l.message, false)},
            (r) => {submitRegister()},
          ),
        );
  }

  void submitRegister() {
    ref
        .read(authProvider.notifier)
        .register(widget.registerEntities)
        .then((res) => res.fold(
              (l) => {
                setState(() => isLoading = false),
                AppAlerts.displaySnackBar(context, l.message, false),
                Navigator.pop(context),
              },
              (r) => {
                setState(() => isLoading = false),
                Navigator.pushNamedAndRemoveUntil(
                    context, AuthScreen.id, (route) => false),
              },
            ));
  }
}
