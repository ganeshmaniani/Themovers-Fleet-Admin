import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../feature.dart';

class CreateNewPassword extends ConsumerStatefulWidget {
  static const String id = 'create_new_password_screen';
  final String email;

  const CreateNewPassword({super.key, required this.email});

  @override
  ConsumerState<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends ConsumerState<CreateNewPassword>
    with InputValidationMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _passwordController = TextEditingController();
  final _conformPasswordController = TextEditingController();

  bool isPasswordHidden = false;
  bool isConformPasswordHidden = false;

  bool isLoading = false;

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
                      'Create New Password',
                      style: textTheme.displayMedium
                          ?.copyWith(color: Colors.white, letterSpacing: .7),
                    ),
                    Dimensions.kVerticalSpaceSmall,
                    Text(
                      'Create your Password',
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
                      children: [
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
                          decoration: textInputDecoration('New Password'),
                        ),
                        Dimensions.kVerticalSpaceSmall,
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
                                      'Submit',
                                      style:
                                          context.textTheme.bodySmall?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(width: 105),
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
    final isCheckPassword = label == "New Password";
    final isCheckConformPassword = label == "Confirm Password";

    return InputDecoration(
      suffixIcon: isCheckPassword
          ? IconButton(
              onPressed: () =>
                  setState(() => isPasswordHidden = !isPasswordHidden),
              icon: isPasswordHidden
                  ? const Icon(Icons.lock_open, color: AppColor.primary)
                  : const Icon(Icons.lock, color: AppColor.secondary))
          : isCheckConformPassword
              ? IconButton(
                  onPressed: () => setState(
                      () => isConformPasswordHidden = !isConformPasswordHidden),
                  icon: isConformPasswordHidden
                      ? const Icon(Icons.lock_open, color: AppColor.primary)
                      : const Icon(Icons.lock, color: AppColor.secondary))
              : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      labelText: label,
      labelStyle: textTheme.bodySmall?.copyWith(
        color: colorScheme.secondary,
      ),
      errorStyle: textTheme.labelMedium?.copyWith(color: colorScheme.error),
    );
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      final forgetPasswordEntities = ForgetPasswordEntities(
          email: widget.email, password: _conformPasswordController.text);
      ref
          .read(authProvider.notifier)
          .forgetPassword(forgetPasswordEntities)
          .then(
            (response) => response.fold(
                (l) => {
                      setState(() => isLoading = false),
                      AppAlerts.displaySnackBar(context, l.message, false),
                    },
                (r) => {
                      setState(() => isLoading = false),
                      Navigator.pushNamedAndRemoveUntil(
                          context, AuthScreen.id, (route) => false),
                    }),
          );
    }
  }
}
