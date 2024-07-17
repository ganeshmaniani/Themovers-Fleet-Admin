import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../auth.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  static const String id = 'registration_screen';

  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() =>
      _RegistrationScreenConsumerState();
}

class _RegistrationScreenConsumerState extends ConsumerState<RegistrationScreen>
    with InputValidationMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _conformPasswordController = TextEditingController();

  bool isPasswordHidden = false;
  bool isConformPasswordHidden = false;

  bool isEmailAvailable = true;
  bool isMobileNumberAvailable = true;

  String countryCode = '+60';

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
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
                      'Register',
                      style: textTheme.displayMedium
                          ?.copyWith(color: Colors.white, letterSpacing: .7),
                    ),
                    Dimensions.kVerticalSpaceSmall,
                    Text(
                      'Create your account',
                      style: textTheme.labelLarge
                          ?.copyWith(color: Colors.white.withOpacity(0.5)),
                    ),
                    Dimensions.kVerticalSpaceLarge,
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: Dimensions.kPaddingAllMedium,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _fullNameController,
                          keyboardType: TextInputType.text,
                          enableSuggestions: true,
                          obscureText: false,
                          enableInteractiveSelection: true,
                          style: textTheme.bodyMedium,
                          validator: (name) {
                            if (isCheckTextFieldIsEmpty(name!)) {
                              return null;
                            } else {
                              return 'Enter a valid user name';
                            }
                          },
                          decoration: textInputDecoration('Full Name'),
                        ),
                        Dimensions.kVerticalSpaceSmaller,
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
                        Dimensions.kVerticalSpaceSmaller,
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
                                  setState(() => countryCode = print.dialCode!);

                                  debugPrint("Country Code: ${print.dialCode}");
                                },
                                initialSelection: 'MY',
                                favorite: const ['+60', 'MY'],
                                flagWidth: 26,
                                textStyle: textTheme.bodySmall,
                                showFlagDialog: false,
                                showCountryOnly: false,
                                showOnlyCountryWhenClosed: false,
                                alignLeft: false,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                controller: _mobileNumberController,
                                keyboardType: TextInputType.number,
                                enableSuggestions: true,
                                obscureText: false,
                                enableInteractiveSelection: true,
                                style: textTheme.bodyMedium,
                                validator: (name) {
                                  if (isCheckTextFieldIsEmpty(name!)) {
                                    return null;
                                  } else {
                                    return 'Enter a valid Phone Number';
                                  }
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  hintText: '123456789',
                                  // hintStyle: textTheme.bodySmall?.copyWith(
                                  //   color: context.colorScheme.secondary,
                                  // ),
                                  errorStyle: textTheme.labelMedium?.copyWith(
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
                        Dimensions.kVerticalSpaceSmaller,
                        TextFormField(
                          controller: _passwordController,
                          keyboardType: TextInputType.text,
                          obscureText: !isPasswordHidden,
                          enableSuggestions: true,
                          enableInteractiveSelection: true,
                          style: textTheme.bodyMedium,
                          validator: (password) {
                            if (isPasswordValid(password!)) {
                              return null;
                            } else {
                              return 'Enter a valid password';
                            }
                          },
                          decoration: textInputDecoration('Password'),
                        ),
                        Dimensions.kVerticalSpaceSmaller,
                        TextFormField(
                          controller: _conformPasswordController,
                          keyboardType: TextInputType.text,
                          obscureText: !isConformPasswordHidden,
                          enableSuggestions: true,
                          enableInteractiveSelection: true,
                          style: textTheme.bodyMedium,
                          validator: (password) {
                            final newPassword = _passwordController.text;
                            if (isConformPassword(newPassword, password!)) {
                              return null;
                            } else {
                              return 'Enter a valid password';
                            }
                          },
                          decoration: textInputDecoration('Confirm Password'),
                        ),
                        Dimensions.kSpacer,
                        isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : Button(
                                onTap: _onSubmit,
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Register',
                                      style:
                                          context.textTheme.bodySmall?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(width: 100),
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
                              "I have an account - ",
                              style: context.textTheme.bodySmall?.copyWith(
                                color: AppColor.greyText,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 2),
                            GestureDetector(
                              onTap: () => Navigator.pushNamedAndRemoveUntil(
                                  context, AuthScreen.id, (route) => false),
                              child: Text(
                                "Login",
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
    final isName = label == 'Full Name';
    final isEmail = label == 'Email';
    final isCheckPassword = label == "Password";
    final isCheckConformPassword = label == "Confirm Password";
    return InputDecoration(
      suffixIcon: isCheckPassword
          ? GestureDetector(
              onTap: () => setState(() => isPasswordHidden = !isPasswordHidden),
              child: isPasswordHidden
                  ? Icon(Icons.lock_open, color: colorScheme.primary)
                  : const Icon(Icons.lock, color: AppColor.secondary),
            )
          : isCheckConformPassword
              ? GestureDetector(
                  onTap: () => setState(
                      () => isConformPasswordHidden = !isConformPasswordHidden),
                  child: isConformPasswordHidden
                      ? Icon(Icons.lock_open, color: colorScheme.primary)
                      : const Icon(Icons.lock, color: AppColor.secondary),
                )
              : isName
                  ? Transform.scale(
                      scale: 0.5, child: SvgPicture.asset(AppSvg.user))
                  : isEmail
                      ? Transform.scale(
                          scale: 0.5, child: SvgPicture.asset(AppSvg.message))
                      : null,
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
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      RegisterEntities registerEntities = RegisterEntities(
        name: _fullNameController.text,
        email: _emailController.text,
        number: _mobileNumberController.text,
        password: _passwordController.text,
      );
      // Navigator.pushNamed(context, RegistrationOTPScreen.id,
      //     arguments: RegistrationOTPScreen(
      //       email: _emailController.text,
      //       registerEntities: registerEntities,
      //     ));
      // setState(() => isLoading = false);
      ref
          .read(authProvider.notifier)
          .register(registerEntities)
          .then((res) => res.fold(
                (l) => {
                  setState(() => isLoading = false),
                  AppAlerts.displaySnackBar(context, l.message, false),
                },
                (r) => {
                  setState(() => isLoading = false),
                  Navigator.pushNamedAndRemoveUntil(
                      context, AuthScreen.id, (route) => false),
                },
              ));
    }
  }
}
