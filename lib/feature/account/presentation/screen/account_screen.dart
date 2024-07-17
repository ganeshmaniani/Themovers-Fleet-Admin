import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../../feature/feature.dart';

class AccountScreen extends ConsumerStatefulWidget {
  static const String id = 'account_screen';

  const AccountScreen({super.key});

  @override
  ConsumerState<AccountScreen> createState() => _AccountScreenConsumerState();
}

class _AccountScreenConsumerState extends ConsumerState<AccountScreen> {
  bool isLoading = true;
  UserDetail user = UserDetail();

  @override
  void initState() {
    super.initState();
    initialCallback();
  }

  void initialCallback() async {
    WidgetsBinding.instance.addPostFrameCallback((__) {
      setState(() => isLoading = true);

      ref.read(accountProvider.notifier).userDetail().then(
            (response) => response.fold(
              (l) => {
                setState(() => {isLoading = false, user = UserDetail()})
              },
              (r) => {
                setState(() =>
                    {isLoading = false, user = r.userDetail ?? UserDetail()}),
                SharedPrefs.instance
                    .setString(AppKeys.name, r.userDetail?.name ?? ''),
              },
            ),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    // AsyncValue leagueInfo = ref.watch(userDetailStreamProvider);
    return SizedBox(
      width: context.deviceSize.width,
      height: context.deviceSize.height,
      child: SingleChildScrollView(
        child: isLoading
            ? const AccountShimmerLoading()
            : Column(
                children: [
                  profileViewAndEdit(user),
                  Dimensions.kVerticalSpaceSmall,
                  accountLabel(label: 'User Name', value: user.name ?? ''),
                  Dimensions.kVerticalSpaceSmallest,
                  accountLabel(
                      label: 'Company Name', value: user.companyName ?? ''),
                  Dimensions.kVerticalSpaceSmallest,
                  accountLabel(
                      label: 'Mobile Number',
                      value: '+60 ${user.mobileNumber}' ?? ''),
                  Dimensions.kVerticalSpaceSmallest,
                  accountLabel(label: 'Email Address', value: user.email ?? ''),
                  Dimensions.kVerticalSpaceSmallest,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Documents',
                          style: context.textTheme.labelLarge
                              ?.copyWith(color: AppColor.greyText),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            showImage(
                              context: context,
                              image: user.businessSsmRegistration ?? '',
                              filePath: "public/business_ssm_registration/",
                              title: "SSM",
                            ),
                            showImage(
                              context: context,
                              image: user.nric ?? '',
                              filePath: "public/nric/",
                              title: "NRIC",
                            ),
                            showImage(
                              context: context,
                              image: user.license ?? '',
                              filePath: "public/license/",
                              title: "GDL",
                            ),
                            showImage(
                              context: context,
                              image: user.grant ?? '',
                              filePath: "public/grant/",
                              title: "GRANT",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Dimensions.kVerticalSpaceMedium,
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16),
                  //   child: Container(
                  //     padding: Dimensions.kPaddingAllMedium,
                  //     decoration: BoxDecoration(
                  //       border: Border.all(
                  //         color: AppColor.primary,
                  //         width: 1,
                  //       ),
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text(
                  //           'Show more',
                  //           style: context.textTheme.titleLarge,
                  //         ),
                  //         SvgPicture.asset(AppSvg.arrowRight, width: 22)
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Dimensions.kVerticalSpaceMedium,
                  GestureDetector(
                    onTap: showDeleteAccountRequestAlert,
                    child: Text(
                      "Delete Account Request",
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        decorationThickness: 2,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Dimensions.kVerticalSpaceMedium,
                ],
              ),
      ),
    );
  }

  Widget profileViewAndEdit(UserDetail user) {
    return Container(
      height: 310,
      width: context.deviceSize.width,
      padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 16),
      decoration: const BoxDecoration(color: AppColor.primary),
      child: Column(
        children: [
          Stack(
            children: [
              InkWell(
                onTap: selectFilePickerMode,
                child: Container(
                  height: 120,
                  width: 120,
                  padding: Dimensions.kPaddingAllMedium,
                  decoration: BoxDecoration(
                    color: AppColor.cyanBlue,
                    borderRadius: Dimensions.kBorderRadiusAllSmall,
                    border: Border.all(
                      color: AppColor.secondaryText,
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                    image: user.profileImage == null
                        ? null
                        : DecorationImage(
                            image: NetworkImage(
                                "${ApiUrl.baseUrl}public/profile_uploads/${user.profileImage}"),
                          ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 4,
                child: InkWell(
                  onTap: selectFilePickerMode,
                  child: ClipOval(
                    child: Container(
                      padding: Dimensions.kPaddingAllSmaller,
                      child: Icon(
                        user.profileImage == ''
                            ? Icons.add_a_photo
                            : Icons.add_photo_alternate,
                        color: AppColor.secondaryText,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Dimensions.kVerticalSpaceSmaller,
          Text(
            user.name ?? '',
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w900, color: AppColor.secondaryText),
          ),
          Dimensions.kVerticalSpaceSmallest,
          Text(
            'User Type:  Fleet Admin',
            style: context.textTheme.labelLarge
                ?.copyWith(color: AppColor.secondaryText),
          ),
          Dimensions.kVerticalSpaceSmallest,
          Button(
            width: 110,
            height: 38,
            onTap: () {
              Navigator.pushNamed(context, AccountEditScreen.id,
                      arguments: AccountEditScreen(user: user))
                  .then((value) => initialCallback());
            },
            color: AppColor.secondaryText,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Edit Profile',
                  style: context.textTheme.bodySmall?.copyWith(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget showImage(
      {required BuildContext context,
      required String image,
      required String filePath,
      required String title}) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: Dimensions.kBorderRadiusAllSmaller,
              border: Border.all(
                width: 1,
                color: context.colorScheme.primary,
              ),
              image: DecorationImage(
                image: NetworkImage("${ApiUrl.baseUrl}$filePath$image"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: context.deviceSize.width,
                  height: 24,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColor.primary.withOpacity(.7),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: context.textTheme.labelLarge
                        ?.copyWith(color: AppColor.secondaryText),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
    ref.read(accountProvider.notifier).userProfileEdit(file).then(
          (response) => response.fold(
            (l) => {
              AppAlerts.displaySnackBar(context, l.message, false),
              Navigator.pop(context),
              initialCallback(),
            },
            (r) => {
              Navigator.pop(context),
              showProfileUpdateSuccessfulAlert(),
            },
          ),
        );
  }

  void showProfileUpdateSuccessfulAlert() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColor.secondaryText,
        title: const Text("Profile Successfully Updated",
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
                onTap: () => {
                  Navigator.pop(ctx),
                  initialCallback(),
                },
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

  Widget accountLabel({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.labelMedium
                  ?.copyWith(color: AppColor.greyText)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              label == "Company Name"
                  ? const EmptyContainer()
                  : SvgPicture.asset(selectIcon(label), height: 22)
            ],
          ),
          Divider(color: AppColor.primary.withOpacity(.3))
        ],
      ),
    );
  }

  String selectIcon(String label) {
    switch (label) {
      case "User Name":
        return AppSvg.user;
      case 'Mobile Number':
        return AppSvg.phone;
    }
    return AppSvg.message;
  }

  void showDeleteAccountRequestAlert() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColor.secondaryText,
        title: const Text("Are you sure?", textAlign: TextAlign.center),
        titleTextStyle: context.textTheme.headlineMedium,
        actions: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image(
              Expanded(
                child: Text(
                  "The account will delete permanently.",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Dimensions.kVerticalSpaceMedium,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Button(
                onTap: deleteAccountRequestSubmit,
                width: 80,
                height: 40,
                child: Text(
                  'Yes',
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: AppColor.secondaryText,
                  ),
                ),
              ),
              Dimensions.kHorizontalSpaceSmall,
              OutlineButton(
                onTap: () => Navigator.pop(ctx),
                width: 80,
                height: 40,
                child: Text(
                  'No',
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: AppColor.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void deleteAccountRequestSubmit() {
    ref.read(accountProvider.notifier).accountDelete().then(
          (response) => response.fold(
            (l) => {
              AppAlerts.displaySnackBar(context, l.message, false),
              Navigator.pop(context),
            },
            (r) => {
              Navigator.pop(context),
            },
          ),
        );
  }
}
