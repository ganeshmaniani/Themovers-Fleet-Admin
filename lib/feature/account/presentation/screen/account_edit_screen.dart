import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../feature.dart';

class AccountEditScreen extends ConsumerStatefulWidget {
  static const String id = "account_edit_screen";
  final UserDetail user;

  const AccountEditScreen({super.key, required this.user});

  @override
  ConsumerState<AccountEditScreen> createState() =>
      _AccountEditScreenConsumerState();
}

class _AccountEditScreenConsumerState extends ConsumerState<AccountEditScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _companyController = TextEditingController();
  late TextEditingController _mobileController = TextEditingController();
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _addressController = TextEditingController();

  bool isLoading = false;

  File? ssmRegistrationPick = null;
  File? nricPick = null;
  File? licensePick = null;
  File? grantPick = null;

  @override
  void initState() {
    super.initState();
    initRequestImage();
  }

  void initRequestImage() async {
    _nameController = TextEditingController(text: widget.user.name ?? '');
    _companyController =
        TextEditingController(text: widget.user.companyName ?? '');
    _mobileController =
        TextEditingController(text: widget.user.mobileNumber ?? '');
    _emailController = TextEditingController(text: widget.user.email ?? '');
    _addressController =
        TextEditingController(text: widget.user.branchAddress ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Account Edit",
          style: context.textTheme.headlineLarge?.copyWith(color: Colors.white),
        ),
        leading: const SizedBox(),
      ),
      body: SingleChildScrollView(
        padding: Dimensions.kPaddingAllMedium,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Dimensions.kVerticalSpaceSmall,
              TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.emailAddress,
                enableSuggestions: true,
                obscureText: false,
                enableInteractiveSelection: true,
                style: context.textTheme.bodyMedium,
                decoration: textInputDecoration('Full Name'),
              ),
              Dimensions.kVerticalSpaceSmall,
              TextFormField(
                controller: _companyController,
                keyboardType: TextInputType.emailAddress,
                enableSuggestions: true,
                obscureText: false,
                enableInteractiveSelection: true,
                style: context.textTheme.bodyMedium,
                decoration: textInputDecoration('Company Name'),
              ),
              Dimensions.kVerticalSpaceSmall,
              TextFormField(
                controller: _mobileController,
                keyboardType: TextInputType.emailAddress,
                enableSuggestions: true,
                obscureText: false,
                enableInteractiveSelection: true,
                style: context.textTheme.bodyMedium,
                decoration: textInputDecoration('Mobile number'),
              ),
              Dimensions.kVerticalSpaceSmall,
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                enableSuggestions: true,
                obscureText: false,
                enableInteractiveSelection: true,
                style: context.textTheme.bodyMedium,
                decoration: textInputDecoration('Email Address'),
              ),
              Dimensions.kVerticalSpaceSmall,
              TextFormField(
                controller: _addressController,
                keyboardType: TextInputType.text,
                enableSuggestions: true,
                obscureText: false,
                enableInteractiveSelection: true,
                style: context.textTheme.bodyMedium,
                decoration: textInputDecoration('Branch Address'),
              ),
              Dimensions.kVerticalSpaceSmall,
              Text(
                'Upload Business SSM Registration picture',
                style: context.textTheme.titleLarge,
              ),
              Dimensions.kVerticalSpaceSmallest,
              pickDocumentStorage(
                image: ssmRegistrationPick,
                networkImage: widget.user.businessSsmRegistration == '' ||
                        widget.user.businessSsmRegistration == null
                    ? ''
                    : '${ApiUrl.baseUrl}public/business_ssm_registration/${widget.user.businessSsmRegistration}',
                onPressed: () {
                  selectFilePickerMode(label: "SSM");
                },
              ),
              Dimensions.kVerticalSpaceSmall,
              Text(
                'Upload NRIC picture',
                style: context.textTheme.titleLarge,
              ),
              Dimensions.kVerticalSpaceSmallest,
              pickDocumentStorage(
                image: nricPick,
                networkImage: widget.user.nric == '' || widget.user.nric == null
                    ? ''
                    : '${ApiUrl.baseUrl}public/nric/${widget.user.nric}',
                onPressed: () {
                  selectFilePickerMode(label: "NRIC");
                },
              ),
              Dimensions.kVerticalSpaceSmall,
              Text(
                'Upload License picture',
                style: context.textTheme.titleLarge,
              ),
              Dimensions.kVerticalSpaceSmallest,
              pickDocumentStorage(
                image: licensePick,
                networkImage: widget.user.license == '' ||
                        widget.user.license == null
                    ? ''
                    : '${ApiUrl.baseUrl}public/license/${widget.user.license}',
                onPressed: () {
                  selectFilePickerMode(label: "License");
                },
              ),
              Dimensions.kVerticalSpaceSmall,
              Text(
                'Upload grant picture',
                style: context.textTheme.titleLarge,
              ),
              Dimensions.kVerticalSpaceSmallest,
              pickDocumentStorage(
                image: grantPick,
                networkImage:
                    widget.user.grant == '' || widget.user.grant == null
                        ? ''
                        : '${ApiUrl.baseUrl}public/grant/${widget.user.grant}',
                onPressed: () {
                  selectFilePickerMode(label: "grant");
                },
              ),
              Dimensions.kVerticalSpaceLarger,
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Row(
                      children: [
                        Expanded(
                          child: Button(
                            onTap: () => Navigator.of(context).pop(),
                            height: 56,
                            color: Colors.white,
                            child: Text(
                              'Cancel',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                                letterSpacing: .7,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Button(
                            onTap: () => saveAccountDetail(widget.user),
                            height: 56,
                            child: Text(
                              'Save',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                letterSpacing: .7,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
              Dimensions.kVerticalSpaceLarger,
            ],
          ),
        ),
      ),
    );
  }

  textInputDecoration(String label) {
    final textTheme = Theme.of(context).textTheme;

    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: Dimensions.kBorderRadiusAllSmallest,
        borderSide: const BorderSide(color: AppColor.primary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: Dimensions.kBorderRadiusAllSmallest,
        borderSide: const BorderSide(color: AppColor.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: Dimensions.kBorderRadiusAllSmallest,
        borderSide: const BorderSide(color: AppColor.error),
      ),
      contentPadding: Dimensions.kPaddingAllMedium,
      labelText: label,
      labelStyle: textTheme.bodySmall?.copyWith(
        color: AppColor.lightGrey,
      ),
      errorStyle: textTheme.labelMedium?.copyWith(color: AppColor.error),
    );
  }

  Widget pickDocumentStorage(
      {required File? image,
      required String networkImage,
      required VoidCallback onPressed}) {
    return Row(
      children: [
        image != null
            ? Container(
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
                      image: FileImage(image),
                      fit: BoxFit.cover,
                    )),
              )
            : networkImage != ''
                ? Container(
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
                        image: NetworkImage(networkImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : const SizedBox(),
        image != null
            ? Dimensions.kHorizontalSpaceSmall
            : networkImage != ''
                ? Dimensions.kHorizontalSpaceSmall
                : const SizedBox(),
        InkWell(
          onTap: onPressed,
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
              image == null && networkImage == ''
                  ? Icons.add
                  : Icons.add_photo_alternate,
              size: Dimensions.iconSizeMedium,
              color: context.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }

  void selectFilePickerMode({required String label}) {
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
                      onTap: () => cameraPicker(label),
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
                      onTap: () => galleryPicker(label),
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

  Future<void> cameraPicker(String label) async {
    final ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      storePickedImage(label, File(pickedImage.path));
    }
  }

  Future<void> galleryPicker(String label) async {
    final ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      storePickedImage(label, File(pickedImage.path));
    }
  }

  storePickedImage(String label, File file) {
    if (label == "SSM") {
      setState(() => ssmRegistrationPick = file);
      // ref.read(accountNotifierProvider).setSsmRegistrationPick(file);
      Navigator.pop(context);
    }
    if (label == "NRIC") {
      // ref.read(accountNotifierProvider).setNricPick(file);
      setState(() => nricPick = file);
      Navigator.pop(context);
    }
    if (label == "License") {
      // ref.read(accountNotifierProvider).setLicensePick(file);
      setState(() => licensePick = file);
      Navigator.pop(context);
    }
    if (label == "grant") {
      // ref.read(accountNotifierProvider).setLicensePick(file);
      setState(() => grantPick = file);
      Navigator.pop(context);
    }
  }

  saveAccountDetail(UserDetail user) async {
    setState(() => isLoading = true);
    final businessSsmRegistration = ssmRegistrationPick != null
        ? base64.encode(ssmRegistrationPick!.readAsBytesSync())
        : await networkImageToBase64(
            '${ApiUrl.baseUrl}public/business_ssm_registration/${widget.user.businessSsmRegistration}');
    final nric = nricPick != null
        ? base64.encode(nricPick!.readAsBytesSync())
        : await networkImageToBase64(
            '${ApiUrl.baseUrl}public/nric/${widget.user.nric}');
    final license = licensePick != null
        ? base64.encode(licensePick!.readAsBytesSync())
        : await networkImageToBase64(
            '${ApiUrl.baseUrl}public/license/${widget.user.license}');
    final grant = grantPick != null
        ? base64.encode(grantPick!.readAsBytesSync())
        : await networkImageToBase64(
            '${ApiUrl.baseUrl}public/grant/${widget.user.grant}');
    AccountEditEntities accountEditEntities = AccountEditEntities(
      name: _nameController.text,
      email: _emailController.text,
      mobileNumber: _mobileController.text,
      companyName: _companyController.text,
      branchAddress: _addressController.text,
      businessSsmRegistration: businessSsmRegistration.toString(),
      nric: nric.toString(),
      license: license.toString(),
      grant: grant.toString(),
    );
    ref.read(accountProvider.notifier).userEdit(accountEditEntities).then(
          (response) => response.fold(
            (l) => {
              setState(() => isLoading = false),
              AppAlerts.displaySnackBar(context, l.message, false),
              Navigator.pop(context),
            },
            (r) => {
              setState(() => isLoading = false),
              Navigator.pop(context),
              AppAlerts.showProfileUpdateSuccessAlert(context),
            },
          ),
        );
  }

  Future<String> networkImageToBase64(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    return base64Encode(bytes);
  }
}
