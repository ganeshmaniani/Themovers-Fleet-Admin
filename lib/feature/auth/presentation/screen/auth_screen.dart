import 'package:country_code_picker/country_code_picker.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../feature.dart';

class AuthScreen extends ConsumerStatefulWidget {
  static const String id = 'auth_screen';

  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenConsumerState();
}

class _AuthScreenConsumerState extends ConsumerState<AuthScreen>
    with InputValidationMixin {
  final facebookAppEvents = FacebookAppEvents();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isPasswordHidden = false;
  bool isLoading = false;

  String countryCode = '+60';

  int selectTapIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: context.deviceSize.height,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  height: 380,
                  width: context.deviceSize.width,
                  decoration: const BoxDecoration(color: AppColor.primary),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 167,
                        height: 167,
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 11,
                          right: 11,
                          bottom: 19,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 145,
                              height: 128,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage(AppIcon.theMoversVerticalLogo),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Dimensions.kVerticalSpaceMedium,
                      Text(
                        'Signing to Your\nAccount',
                        textAlign: TextAlign.center,
                        style: context.textTheme.displayMedium?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      Dimensions.kVerticalSpaceSmall,
                      Text(
                        'Enter your email or phone to login',
                        style: context.textTheme.labelLarge
                            ?.copyWith(color: Colors.white.withOpacity(0.5)),
                      ),
                      Dimensions.kVerticalSpaceSmall,
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: context.deviceSize.width,
                  padding: Dimensions.kPaddingAllMedium,
                  decoration: const BoxDecoration(color: AppColor.background),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _emailOrMobileNumberBox(),
                        Dimensions.kVerticalSpaceSmall,
                        if (selectTapIndex == 2)
                          Row(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Color(0x3FB30205),
                                    ),
                                  ),
                                ),
                                child: CountryCodePicker(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  onChanged: (print) {
                                    setState(
                                        () => countryCode = print.dialCode!);

                                    debugPrint(
                                        "Country Code: ${print.dialCode}");
                                  },
                                  initialSelection: 'MY',
                                  favorite: const ['+60', 'MY'],
                                  flagWidth: 26,
                                  textStyle: context.textTheme.bodySmall,
                                  showFlagDialog: false,
                                  showCountryOnly: false,
                                  showOnlyCountryWhenClosed: false,
                                  alignLeft: false,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.number,
                                  enableSuggestions: true,
                                  obscureText: false,
                                  enableInteractiveSelection: true,
                                  style: context.textTheme.bodyMedium,
                                  validator: (name) {
                                    if (isCheckTextFieldIsEmpty(name!)) {
                                      return null;
                                    } else {
                                      return 'Enter a valid Phone Number';
                                    }
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    hintText: '12345678',
                                    // hintStyle:
                                    //     context.textTheme.bodySmall?.copyWith(
                                    //   color: context.colorScheme.secondary,
                                    // ),
                                    errorStyle: context.textTheme.labelMedium
                                        ?.copyWith(
                                            color: context.colorScheme.error),
                                    suffixIcon: Transform.scale(
                                      scale: 0.5,
                                      child: SvgPicture.asset(AppSvg.phone),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if (selectTapIndex == 1)
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            enableSuggestions: true,
                            obscureText: false,
                            enableInteractiveSelection: true,
                            style: context.textTheme.bodyMedium,
                            validator: (email) {
                              if (isCheckTextFieldIsEmpty(email!)) {
                                return null;
                              } else {
                                return 'Enter a valid email address or mobile number';
                              }
                            },
                            decoration: textInputDecoration('Email'),
                          ),
                        Dimensions.kVerticalSpaceSmaller,
                        TextFormField(
                          controller: _passwordController,
                          keyboardType: TextInputType.text,
                          obscureText: !isPasswordHidden,
                          enableSuggestions: true,
                          enableInteractiveSelection: true,
                          style: context.textTheme.bodyMedium,
                          validator: (password) {
                            if (isPasswordValid(password!)) {
                              return null;
                            } else {
                              return 'Enter a valid password';
                            }
                          },
                          decoration: textInputDecoration('Password'),
                        ),
                        Dimensions.kVerticalSpaceSmall,
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              ForgetPasswordScreen.id,
                            );
                          },
                          child: Text(
                            'Forget Password?',
                            style: context.textTheme.labelLarge?.copyWith(
                              color: AppColor.primary,
                              fontWeight: FontWeight.w600,
                              letterSpacing: .6,
                            ),
                          ),
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
                                      'Login',
                                      style:
                                          context.textTheme.bodySmall?.copyWith(
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
                        Dimensions.kVerticalSpaceLarger,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don’t have an account? ",
                              style: context.textTheme.bodySmall?.copyWith(
                                color: AppColor.greyText,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 2),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, RegistrationScreen.id),
                              child: Text(
                                "Register",
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: AppColor.accentText,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Dimensions.kVerticalSpaceSmallest,
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
    final isCheckPassword = label == "Password";

    return InputDecoration(
      suffixIcon: isCheckPassword
          ? GestureDetector(
              onTap: () => setState(() => isPasswordHidden = !isPasswordHidden),
              child: isPasswordHidden
                  ? const Icon(Icons.lock_open_rounded)
                  : const Icon(Icons.lock, color: AppColor.secondary),
            )
          : Transform.scale(scale: 0.5, child: SvgPicture.asset(AppSvg.user)),
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

  _emailOrMobileNumberBox() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () =>
                setState(() => {_emailController.clear(), selectTapIndex = 1}),
            child: Container(
              height: 42,
              padding: Dimensions.kPaddingAllSmall,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:
                    selectTapIndex == 1 ? AppColor.primary : Colors.transparent,
                borderRadius: Dimensions.kBorderRadiusAllSmallest,
                border: Border.all(
                  width: 1,
                  color: selectTapIndex == 1
                      ? AppColor.primary
                      : AppColor.secondary,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
              child: Text(
                "Email",
                style: context.textTheme.bodySmall?.copyWith(
                  color: selectTapIndex == 1
                      ? AppColor.secondaryText
                      : AppColor.primaryText.withOpacity(.6),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: InkWell(
            onTap: () => setState(() => {
                  _emailController.clear(),
                  selectTapIndex = 2,
                }),
            child: Container(
              height: 42,
              padding: Dimensions.kPaddingAllSmall,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:
                    selectTapIndex == 2 ? AppColor.primary : Colors.transparent,
                borderRadius: Dimensions.kBorderRadiusAllSmallest,
                border: Border.all(
                  width: 1,
                  color: selectTapIndex == 2
                      ? AppColor.primary
                      : AppColor.secondary,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
              child: Text(
                "Phone number",
                style: context.textTheme.bodySmall?.copyWith(
                  color: selectTapIndex == 2
                      ? AppColor.secondaryText
                      : AppColor.primaryText.withOpacity(.6),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _onSubmit() {
    ref
        .read(authProvider.notifier)
        .signIn(LoginEntities(
            userId: _emailController.text, password: _passwordController.text))
        .then(
          (res) => {
            res.fold(
              (l) => {
                setState(() => isLoading = false),
                AppAlerts.displaySnackBar(context, l.message, false),
                Log.e("Log In", error: l.message)
              },
              (r) => {
                setState(() => isLoading = false),
                _emailController.clear(),
                _passwordController.clear(),
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(HomeScreen.id, (route) => false),
              },
            ),
          },
        );
  }

  void sendFacebookAppEventLog() async {
    await facebookAppEvents.logEvent(
      name: 'login_user',
      parameters: <String, dynamic>{
        'user_id': SharedPrefs.instance.getInt(AppKeys.userId),
        'user_phone_number': SharedPrefs.instance.getString(AppKeys.number),
      },
    );

    facebookAppEvents.setUserData(
      email: SharedPrefs.instance.getString(AppKeys.email),
      firstName: SharedPrefs.instance.getString(AppKeys.name),
    );

    Log.i('Successfully Sent loginEvent');
  }
}
