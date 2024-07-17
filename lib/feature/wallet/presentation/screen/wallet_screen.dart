import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../../feature/feature.dart';

class WalletScreen extends ConsumerStatefulWidget {
  static const String id = 'wallet_screen';

  const WalletScreen({super.key});

  @override
  ConsumerState<WalletScreen> createState() => _WalletScreenConsumerState();
}

class _WalletScreenConsumerState extends ConsumerState<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    final walletHistory = ref.watch(walletHistoryStreamProvider);
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Container(
        width: context.deviceSize.width,
        height: context.deviceSize.height / 1.16,
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Dimensions.kDivider,
            Text('Wallet', style: context.textTheme.bodyLarge),
            Dimensions.kVerticalSpaceSmallest,
            walletTopUpCardUI(),
            Dimensions.kVerticalSpaceSmall,
            Container(
              width: context.deviceSize.width,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColor.lightGrey,
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: AppColor.primaryText.withOpacity(.2),
                  ),
                ),
              ),
              child: Text(
                'Recent Transactions',
                style: context.textTheme.bodyMedium,
              ),
            ),
            walletHistory.when(
              data: (response) {
                List<WalletHistory> wallet = [];
                response.fold((l) => {wallet = []},
                    (r) => {wallet = r.walletHistory ?? []});
                return Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 24, top: 8),
                    itemCount: wallet.length,
                    itemBuilder: (_, i) {
                      return walletTransactionHistoryUI(wallet[i]);
                    },
                  ),
                );
              },
              error: (error, s) => const EmptyListContainer(),
              loading: () => const WalletShimmerLoading(),
            ),
          ],
        ),
      ),
    );
  }

  Widget walletTopUpCardUI() {
    final walletAmount = ref.watch(walletAmountStreamProvider);
    return Container(
      width: context.deviceSize.width,
      decoration: BoxDecoration(
        color: AppColor.lightGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            width: context.deviceSize.width,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                topLeft: Radius.circular(12),
              ),
            ),
            child: Text(
              'Wallet Balance',
              style: context.textTheme.bodyMedium
                  ?.copyWith(color: AppColor.secondaryText),
            ),
          ),
          Container(
            width: context.deviceSize.width,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                walletAmount.when(
                  data: (response) {
                    String amount = '';
                    response.fold(
                        (l) => {amount = '00.0'}, (r) => {amount = r});
                    return Text(
                      amount == '' ? '00.0 MYR' : '$amount MYR',
                      style: context.textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColor.cyanBlue),
                    );
                  },
                  error: (error, stackTrace) => Text(
                    '00.0 MYR',
                    style: context.textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w700, color: AppColor.cyanBlue),
                  ),
                  loading: () => const ShimmerSkeleton(width: 187, height: 38),
                ),
                Button(
                  width: 101.61,
                  height: 37.27,
                  color: AppColor.cyanBlue,
                  onTap: showTopUpRequestModel,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Topup',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: AppColor.secondaryText,
                        ),
                      ),
                      Dimensions.kHorizontalSpaceSmall,
                      const Image(
                        image: AssetImage(AppIcon.topup),
                        width: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget walletTransactionHistoryUI(WalletHistory wallet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        width: context.deviceSize.width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppColor.lightGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    wallet.amount == null
                        ? "Commission\nPaid"
                        : "Wallet\nTopup",
                    style: context.textTheme.titleLarge
                        ?.copyWith(color: AppColor.cyanBlue),
                  ),
                ),
                Text(
                  wallet.amount == null
                      ? wallet.revenueAmount == null ||
                              wallet.revenueAmount == 'null' ||
                              wallet.revenueAmount == '0'
                          ? '00.0 MYR'
                          : '${wallet.revenueAmount} MYR'
                      : wallet.amount == null ||
                              wallet.amount == 'null' ||
                              wallet.amount == '0'
                          ? '00.0 MYR'
                          : '${wallet.amount} MYR',
                  style: context.textTheme.displayMedium?.copyWith(
                      color: AppColor.cyanBlue, fontWeight: FontWeight.w900),
                ),
              ],
            ),
            Dimensions.kVerticalSpaceSmaller,
            Text(
              wallet.createdAt! == ''
                  ? ''
                  : wallet.createdAt.toString().split(' ').first,
              style: context.textTheme.labelSmall
                  ?.copyWith(fontWeight: FontWeight.w500, color: AppColor.grey),
            ),
          ],
        ),
      ),
    );
  }

  void showTopUpRequestModel() {
    showModalBottomSheet(
        context: context,
        enableDrag: false,
        isDismissible: true,
        isScrollControlled: true,
        builder: (_) {
          return const TopUpRequestModel();
        });
  }
}
