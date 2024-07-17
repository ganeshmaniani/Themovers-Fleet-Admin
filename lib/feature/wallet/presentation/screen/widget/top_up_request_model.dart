import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:themovers_fleet_admin/feature/feature.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';

class TopUpRequestModel extends ConsumerStatefulWidget {
  const TopUpRequestModel({super.key});

  @override
  ConsumerState<TopUpRequestModel> createState() =>
      _TopUpRequestModelConsumerState();
}

class _TopUpRequestModelConsumerState extends ConsumerState<TopUpRequestModel> {
  late TextEditingController _amountController = TextEditingController();

  late File? pickedImageFile = null;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Dimensions.kPaddingAllMedium,
      width: context.deviceSize.width,
      height: context.deviceSize.height / 1.26,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Dimensions.kVerticalSpaceMedium,
          TextFormField(
            controller: _amountController,
            keyboardType: TextInputType.text,
            enableSuggestions: true,
            obscureText: false,
            enableInteractiveSelection: true,
            style: context.textTheme.bodyMedium,
            decoration: textInputDecoration('Enter Amount'),
          ),
          Dimensions.kVerticalSpaceSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              topUpRequestAmount(amount: "300"),
              topUpRequestAmount(amount: "500"),
              topUpRequestAmount(amount: "1000"),
            ],
          ),
          Dimensions.kVerticalSpaceSmall,
          Text(
            'Please attach payment slip',
            style: context.textTheme.bodySmall,
          ),
          Dimensions.kVerticalSpaceSmallest,
          pickDocumentCaptureImage(),
          Dimensions.kDivider,
          Dimensions.kVerticalSpaceSmall,
          CardContainer(
            isTrue: true,
            topChild: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Account Details',
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColor.secondaryText,
                ),
              ),
            ),
            bottomChild: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  accountDetailTextGroup(
                    title: 'Name',
                    body: 'The Movers Online (M) Sdn Bhd',
                  ),
                  Dimensions.kVerticalSpaceSmallest,
                  accountDetailTextGroup(title: 'Account', body: '32200795096'),
                  Dimensions.kVerticalSpaceSmallest,
                  accountDetailTextGroup(
                      title: 'Bank', body: 'Public Bank Berhad'),
                ],
              ),
            ),
          ),
          Dimensions.kSpacer,
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Button(
                  onTap: onSubmit,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 16),
                      const SizedBox(width: 24),
                      Dimensions.kSpacer,
                      Text(
                        'Request to Topup',
                        style: context.textTheme.bodySmall?.copyWith(
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
          Dimensions.kVerticalSpaceLarge,
        ],
      ),
    );
  }

  textInputDecoration(String label) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    return InputDecoration(
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
      contentPadding: Dimensions.kPaddingAllMedium,
      labelText: label,
      labelStyle: textTheme.bodySmall?.copyWith(
        color: colorScheme.secondary,
      ),
      errorStyle: textTheme.labelMedium?.copyWith(color: colorScheme.error),
    );
  }

  Widget topUpRequestAmount({required String amount}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: () {
          setState(
              () => _amountController = TextEditingController(text: amount));
        },
        child: Container(
          width: 100,
          padding: Dimensions.kPaddingAllSmall,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: Dimensions.kBorderRadiusAllSmallest,
            border: Border.all(
              width: 1,
              color: context.colorScheme.primary,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
          child: Text(
            'MYR $amount',
            style: context.textTheme.bodySmall
                ?.copyWith(color: context.colorScheme.primary),
          ),
        ),
      ),
    );
  }

  Widget accountDetailTextGroup({required String title, required String body}) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text('$title:', style: context.textTheme.bodySmall),
        ),
        Expanded(
          flex: 5,
          child: Text(body, style: context.textTheme.titleLarge),
        ),
      ],
    );
  }

  Widget pickDocumentCaptureImage() {
    return Row(
      children: [
        pickedImageFile == null
            ? const EmptyContainer()
            : Container(
                width: 60,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: Dimensions.kBorderRadiusAllSmaller,
                    border: Border.all(
                      width: 1,
                      color: context.colorScheme.primary,
                    ),
                    image: DecorationImage(
                      image: FileImage(pickedImageFile!),
                      fit: BoxFit.cover,
                    )),
              ),
        pickedImageFile != null
            ? Dimensions.kHorizontalSpaceSmall
            : const SizedBox(),
        InkWell(
          onTap: selectFilePickerMode,
          borderRadius: Dimensions.kBorderRadiusAllSmaller,
          child: Container(
            width: 60,
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: Dimensions.kBorderRadiusAllSmaller,
              border: Border.all(
                width: 1,
                color: context.colorScheme.primary,
              ),
            ),
            child: Icon(
              pickedImageFile == null ? Icons.add : Icons.add_photo_alternate,
              size: Dimensions.iconSizeMedium,
              color: context.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }

  void selectFilePickerMode() {
    showModalBottomSheet(
        context: context,
        enableDrag: false,
        isDismissible: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) {
          return Container(
            height: 150,
            padding: Dimensions.kPaddingAllMedium,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: cameraPicker,
                      borderRadius: Dimensions.kBorderRadiusAllSmaller,
                      child: Container(
                        width: 60,
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: Dimensions.kBorderRadiusAllSmaller,
                          border: Border.all(
                            width: 1,
                            color: context.colorScheme.primary,
                          ),
                        ),
                        child: Icon(
                          Icons.camera,
                          size: Dimensions.iconSizeMedium,
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ),
                    Dimensions.kVerticalSpaceSmallest,
                    Text(
                      'Camera',
                      style: context.textTheme.titleLarge,
                    ),
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: galleryPicker,
                      borderRadius: Dimensions.kBorderRadiusAllSmaller,
                      child: Container(
                        width: 60,
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: Dimensions.kBorderRadiusAllSmaller,
                          border: Border.all(
                            width: 1,
                            color: context.colorScheme.primary,
                          ),
                        ),
                        child: Icon(
                          Icons.image,
                          size: Dimensions.iconSizeMedium,
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ),
                    Dimensions.kVerticalSpaceSmallest,
                    Text(
                      'Gallery',
                      style: context.textTheme.titleLarge,
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Future<void> cameraPicker() async {
    final ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      storePickedImage(File(pickedImage.path));
    }
  }

  Future<void> galleryPicker() async {
    final ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      storePickedImage(File(pickedImage.path));
    }
  }

  storePickedImage(File file) {
    setState(() => pickedImageFile = file);
    Navigator.pop(context);
  }

  void onSubmit() {
    setState(() => isLoading = true);

    final walletTopUpEntities = WalletTopUpEntities(
      paymentMode: '1',
      amount: _amountController.text,
      paymentAttachment: pickedImageFile!,
    );
    ref
        .read(walletProvider.notifier)
        .topUpRequest(walletTopUpEntities)
        .then((response) => response.fold(
              (l) => {
                setState(() => isLoading = false),
              },
              (r) => {
                setState(() => isLoading = false),
                Navigator.pop(context),
                AppAlerts.showTopUpRequestSuccessAlert(context),
              },
            ));
  }
}
