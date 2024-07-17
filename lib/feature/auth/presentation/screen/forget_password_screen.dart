import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../feature.dart';

class ForgetPasswordScreen extends ConsumerStatefulWidget {
  static const String id = 'forget_password_screen';

  const ForgetPasswordScreen({super.key});

  @override
  ConsumerState<ForgetPasswordScreen> createState() =>
      _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends ConsumerState<ForgetPasswordScreen>
    with InputValidationMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _emailController = TextEditingController();
  late String phoneNumber = '';
  bool isLoading = false;
  String countryCode = '+60';

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
              Container(
                width: MediaQuery.of(context).size.width,
                height: 212,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: context.colorScheme.primary),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Forget Password',
                      style: textTheme.displayMedium
                          ?.copyWith(color: Colors.white, letterSpacing: .7),
                    ),
                    Dimensions.kVerticalSpaceSmall,
                    Text(
                      'Enter your mobile number to reset',
                      style: textTheme.labelLarge
                          ?.copyWith(color: Colors.white.withOpacity(0.5)),
                    ),
                    Dimensions.kVerticalSpaceLarge,
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: Dimensions.kPaddingAllMedium,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Dimensions.kVerticalSpaceSmall,
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          enableSuggestions: true,
                          obscureText: false,
                          enableInteractiveSelection: true,
                          style: textTheme.bodyMedium,
                          validator: (email) {
                            if (isEmailValid(email!)) {
                              return null;
                            } else {
                              return 'Enter a valid email address';
                            }
                          },
                          decoration: textInputDecoration('Email'),
                        ),
                        Dimensions.kSpacer,
                        isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : Button(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => isLoading = true);
                                    _onSubmit();
                                  }
                                },
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Continue',
                                      style:
                                          context.textTheme.bodySmall?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(width: 95),
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
                        Dimensions.kVerticalSpaceSmall,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  textInputDecoration(String label) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    return InputDecoration(
      suffixIcon:
          Transform.scale(scale: 0.5, child: SvgPicture.asset(AppSvg.message)),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: colorScheme.primary),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: colorScheme.primary),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: colorScheme.error),
      ),
      contentPadding: const EdgeInsets.all(0),
      labelText: label,
      labelStyle: textTheme.bodySmall?.copyWith(
        color: colorScheme.secondary,
      ),
      errorStyle: textTheme.labelMedium?.copyWith(color: colorScheme.error),
    );
  }

  _onSubmit() {
    ref.read(authProvider.notifier).emailChecker(_emailController.text).then(
          (res) => res.fold(
            (l) => {
              setState(() => isLoading = false),
              AppAlerts.displaySnackBar(context, l.message.toString(), false)
            },
            (r) => {
              setState(() => isLoading = false),
              Navigator.pushNamed(context, OtpVerificationScreen.id,
                  arguments: OtpVerificationScreen(
                    email: _emailController.text,
                  )),
            },
          ),
        );
  }
}
