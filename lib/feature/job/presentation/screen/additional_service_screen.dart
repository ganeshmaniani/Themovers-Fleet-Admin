import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../feature.dart';

class AdditionalServiceScreen extends ConsumerStatefulWidget {
  static const String id = 'additional_service_screen';

  final String bookingId;
  final String bookingName;

  const AdditionalServiceScreen(
      {super.key, required this.bookingId, required this.bookingName});

  @override
  ConsumerState<AdditionalServiceScreen> createState() =>
      _AdditionalServiceScreenConsumerState();
}

class _AdditionalServiceScreenConsumerState
    extends ConsumerState<AdditionalServiceScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _discriptionController = TextEditingController();

  bool isLoading = false;

  String selectService = "+";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      appBar: PreferredSize(
        preferredSize: Size(context.deviceSize.width, 50),
        child: CustomAppBar(
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: isLoading
            ? const JobDetailShimmerLoading()
            : Container(
                width: context.deviceSize.width,
                height: context.deviceSize.height / 1.08,
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 4, bottom: 16),
                child: Column(
                  children: [
                    Dimensions.kDivider,
                    Row(
                      children: [
                        Text(widget.bookingName,
                            style: context.textTheme.bodyLarge),
                      ],
                    ),
                    Dimensions.kVerticalSpaceSmaller,
                    Form(
                      key: _formKey,
                      child: Expanded(
                        child: ListView(
                          children: [
                            Dimensions.kVerticalSpaceLarge,
                            Text('Additional Service Amount',
                                style: context.textTheme.bodySmall),
                            Dimensions.kVerticalSpaceSmaller,
                            TextFormField(
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              enableSuggestions: true,
                              obscureText: false,
                              enableInteractiveSelection: true,
                              style: context.textTheme.bodyMedium,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Amount cannot be empty';
                                }
                                return null;
                              },
                              decoration: textInputDecoration(
                                'Amount',
                              ),
                            ),
                            Dimensions.kVerticalSpaceSmall,
                            /*   
                            Text('Select Services *',
                                style: context.textTheme.bodySmall),
                            Dimensions.kVerticalSpaceSmaller,
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectService = "Addition";
                                      if (_amountController.text.isNotEmpty) {
                                        _amountController.text =
                                            "+${_amountController.text}";
                                      } else {
                                        _amountController.text = "+";
                                      }
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 15,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          color: selectService == 'Addition'
                                              ? Colors.red
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(width: 1),
                                        ),
                                      ),
                                      Dimensions.kHorizontalSpaceSmaller,
                                      Text("Addition",
                                          style: context.textTheme.labelLarge)
                                    ],
                                  ),
                                ),
                                
                                Dimensions.kHorizontalSpaceSmall,
                                GestureDetector(
                                  onTap: () => setState(
                                      () => selectService = "Subtraction"),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 15,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          color: selectService == 'Subtraction'
                                              ? Colors.red
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(width: 1),
                                        ),
                                      ),
                                      Dimensions.kHorizontalSpaceSmaller,
                                      Text("Subtraction",
                                          style: context.textTheme.labelLarge)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            
                             */
                            Dimensions.kVerticalSpaceSmall,
                            Text('Remarks', style: context.textTheme.bodySmall),
                            Dimensions.kVerticalSpaceSmaller,
                            TextFormField(
                              controller: _discriptionController,
                              keyboardType: TextInputType.text,
                              enableSuggestions: true,
                              obscureText: false,
                              enableInteractiveSelection: true,
                              style: context.textTheme.bodyMedium,
                              textAlignVertical: TextAlignVertical.top,
                              maxLines: 10,
                              minLines: 5,
                              maxLength: 20,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Description cannot be empty';
                                }
                                return null;
                              },
                              decoration: textInputDecoration(
                                'Remarks',
                              ),
                            ),
                            Dimensions.kVerticalSpaceLarge,
                            isLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : Button(
                                    onTap:
                                        _discriptionController.text.isEmpty &&
                                                _amountController.text.isEmpty
                                            ? () {}
                                            : onSubmit,
                                    height: 56,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(width: 16),
                                        const SizedBox(width: 24),
                                        Dimensions.kSpacer,
                                        Text(
                                          'Update',
                                          style: context.textTheme.bodySmall
                                              ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Dimensions.kSpacer,
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
                          ],
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
      prefix: label == 'Amount'
          ? GestureDetector(
              onTap: () {
                setState(() {
                  if (selectService == '+') {
                    selectService = '-';
                  } else if (selectService == '-') {
                    selectService = '+';
                  }
                });
                log(selectService);
              },
              child: Container(
                width: 30,
                child: Text(
                  selectService,
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          : null,
      border: OutlineInputBorder(
        borderRadius: Dimensions.kBorderRadiusAllSmallest,
        borderSide: BorderSide(color: colorScheme.primary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: Dimensions.kBorderRadiusAllSmallest,
        borderSide: BorderSide(color: colorScheme.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: Dimensions.kBorderRadiusAllSmallest,
        borderSide: BorderSide(color: colorScheme.error),
      ),
      alignLabelWithHint: true,
      contentPadding: Dimensions.kPaddingAllMedium,
      labelText: label,
      labelStyle: textTheme.bodySmall?.copyWith(
        color: colorScheme.secondary,
      ),
      errorStyle: textTheme.labelMedium?.copyWith(color: colorScheme.error),
    );
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      final additionalServiceEntities = AdditionalServiceEntities(
        bookingId: widget.bookingId,
        addOnAmount: _amountController.text,
        service: selectService == "+" ? 'Addition' : "Subtraction",
        description: _discriptionController.text,
      );
      log(_amountController.text.toString());

      ref
          .read(jobProvider.notifier)
          .additionalServiceUpdate(additionalServiceEntities)
          .then(
            (response) => response.fold(
              (l) => {
                setState(() => isLoading = true),
                AppAlerts.displaySnackBar(context, 'Update Failed', false),
                Navigator.pop(context),
              },
              (r) => {
                setState(() => isLoading = true),
                Navigator.pop(context),
                showSuccessfulAlert(),
              },
            ),
          );
    }
  }

  bool _validateAmount(String value) {
    return value.isNotEmpty;
  }

  String? _validateDescription(String value) {
    if (value.isEmpty) {
      return 'Description cannot be empty';
    } else if (value.length > 20) {
      return 'Please enter below 20 characters';
    }
    return null; // Return null if the input is valid
  }

  void showSuccessfulAlert() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColor.secondaryText,
        title: const Text("Additional Service Update Successful",
            textAlign: TextAlign.center),
        titleTextStyle: context.textTheme.headlineMedium,
        actions: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(AppIcon.successful),
                width: 100,
              ),
            ],
          ),
          Dimensions.kVerticalSpaceSmaller,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Button(
                onTap: () => Navigator.pop(ctx),
                width: 150,
                child: Text(
                  'Okay',
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: AppColor.secondaryText,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
