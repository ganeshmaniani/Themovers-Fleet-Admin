import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../../feature.dart';

class AssemblyDisassemblyBottomSheet extends ConsumerStatefulWidget {
  const AssemblyDisassemblyBottomSheet({super.key});

  @override
  ConsumerState<AssemblyDisassemblyBottomSheet> createState() =>
      _AssemblyDisassemblyBottomSheetConsumerState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _AssemblyDisassemblyBottomSheetConsumerState
    extends ConsumerState<AssemblyDisassemblyBottomSheet> {
  @override
  Widget build(BuildContext context) {
    int diningTableCount = ref.watch(budgetNotifierProvider).diningTable ?? 0;
    int officeTableCount = ref.watch(budgetNotifierProvider).officeTable ?? 0;
    int bedCount = ref.watch(budgetNotifierProvider).bed ?? 0;
    int wardrobeCount = ref.watch(budgetNotifierProvider).wardrobe ?? 0;

    final amount = ref.watch(budgetNotifierProvider).budgetPackage;
    final textTheme = context.textTheme;
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Dimensions.kVerticalSpaceLarge,
              CustomAppBar(
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Budget Booking',
                      style: textTheme.headlineMedium!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    Dimensions.kVerticalSpaceSmallest,
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color(0xFFB40205),
                      ),
                      child: Text(
                        'Assemble / Disassemble',
                        style: textTheme.titleMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    Dimensions.kVerticalSpaceSmallest,
                    Text(
                        'Disassemble your furniture at pickup location and reassemble at deliver location',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF000000),
                        )),
                  ],
                ),
              ),
              Dimensions.kVerticalSpaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  productDetailCard(
                    icon: AppIcon.dinningTable,
                    title: 'Dining Table',
                    size: 'Any Size',
                    decoration: 'MYR ${amount?.diningTableCount}',
                    count: diningTableCount,
                    increment: () => setState(() => {
                          diningTableCount = diningTableCount + 1,
                          addCount('dining', diningTableCount),
                        }),
                    decrement: () => setState(() => diningTableCount != 0
                        ? {
                            diningTableCount = diningTableCount - 1,
                            addCount('dining', diningTableCount),
                          }
                        : () {}),
                  ),
                  Dimensions.kHorizontalSpaceMedium,
                  productDetailCard(
                    icon: AppIcon.officeTable,
                    title: 'Office Table',
                    size: 'Any Size',
                    decoration: 'MYR ${amount?.tableCount}',
                    count: officeTableCount,
                    increment: () => setState(() => {
                          officeTableCount = officeTableCount + 1,
                          addCount('office', officeTableCount),
                        }),
                    decrement: () => setState(
                      () => officeTableCount != 0
                          ? {
                              officeTableCount = officeTableCount - 1,
                              addCount('office', officeTableCount),
                            }
                          : () {},
                    ),
                  ),
                ],
              ),
              Dimensions.kVerticalSpaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  productDetailCard(
                    icon: AppIcon.bed,
                    title: 'Bed',
                    size: 'Single, Queen, King',
                    decoration: 'MYR ${amount?.bedCount}',
                    count: bedCount,
                    increment: () => setState(() =>
                        {bedCount = bedCount + 1, addCount('bed', bedCount)}),
                    decrement: () => setState(
                      () => bedCount != 0
                          ? {bedCount = bedCount - 1, addCount('bed', bedCount)}
                          : () {},
                    ),
                  ),
                  Dimensions.kHorizontalSpaceMedium,
                  productDetailCard(
                    icon: AppIcon.wardrobe,
                    title: '\nWardrobe',
                    size: 'Bookshelf, Cupboard',
                    decoration: 'MYR ${amount?.wardrobeCount}',
                    count: wardrobeCount,
                    increment: () => setState(() => {
                          wardrobeCount = wardrobeCount + 1,
                          addCount('wardrobe', wardrobeCount),
                        }),
                    decrement: () => setState(
                      () => wardrobeCount != 0
                          ? {
                              wardrobeCount = wardrobeCount - 1,
                              addCount('wardrobe', wardrobeCount),
                            }
                          : () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: const Color(0xFFB40205),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Done',
                    style: context.textTheme.bodySmall
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  titleAndLabelCard({required String title, required String discription}) {
    final textTheme = context.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleLarge?.copyWith(color: const Color(0xFF444550)),
        ),
        Dimensions.kVerticalSpaceSmallest,
        Text(
          discription,
          style: textTheme.labelLarge?.copyWith(color: Colors.black54),
        ),
      ],
    );
  }

  productDetailCard({
    required String icon,
    required String title,
    required String size,
    required String decoration,
    required int count,
    required VoidCallback increment,
    required VoidCallback decrement,
  }) {
    return Column(
      children: [
        Image(image: AssetImage(icon)),
        Dimensions.kVerticalSpaceSmallest,
        CustomProductCounterCard(
            limited: false,
            count: count,
            increment: increment,
            decrement: decrement),
        Dimensions.kVerticalSpaceSmallest,
        Text(decoration,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF000000),
            )),
        Text('per furniture',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF000000),
            ))
      ],
    );
  }

  void addCount(String service, int count) async {
    switch (service) {
      case 'dining':
        ref.read(budgetNotifierProvider).setDiningTable(count);
        break;
      case 'office':
        ref.read(budgetNotifierProvider).setOfficeTable(count);
        break;
      case 'bed':
        ref.read(budgetNotifierProvider).setBed(count);
        break;
      case 'wardrobe':
        ref.read(budgetNotifierProvider).setWardrobe(count);
        break;
    }
  }
}
