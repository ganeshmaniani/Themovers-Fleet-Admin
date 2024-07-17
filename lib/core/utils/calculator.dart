import 'package:flutter/cupertino.dart';

import '../../feature/feature.dart';

class Calculator {
  const Calculator._();

  static dynamic distanceAmount(distance, BudgetPackageList budgetPackage) {
    if (distance >= 11 && distance <= 60) {
      double distancePrice = double.parse(budgetPackage.addOnPrice1!);
      return double.parse(budgetPackage.basePrice!) +
          (distancePrice * (distance - 10).toDouble());
    } else if (distance > 60) {
      double distancePrice = double.parse(budgetPackage.addOnPrice2!);
      return double.parse(budgetPackage.basePrice!) +
          (distancePrice * (distance - 60).toDouble());
    } else {
      return double.parse(budgetPackage.basePrice!);
    }
  }

  static dynamic manpowerAmount(manPower, BudgetPackageList budgetPackage) {
    if (manPower == 0) {
      return double.parse('0');
    } else {
      double amount = 0;
      for (var i = 0; i < manPower; i++) {
        amount = amount + double.parse(budgetPackage.manpower!);
      }
      return amount;
    }
  }

  static dynamic boxAmount(boxAmount, BudgetPackageList budgetPackage) {
    if (boxAmount == 0) {
      return double.parse('0');
    } else {
      double amount = 0;
      for (var i = 0; i < boxAmount; i++) {
        amount = amount + double.parse(budgetPackage.boxCount!);
      }
      return amount;
    }
  }

  static dynamic shrinkWrapAmount(shrinkWrap, BudgetPackageList budgetPackage) {
    if (shrinkWrap == 0) {
      return double.parse('0');
    } else {
      double amount = 0;
      for (var i = 0; i < shrinkWrap; i++) {
        amount = amount + double.parse(budgetPackage.shrinkWrapping!);
      }
      return amount;
    }
  }

  static dynamic bubbleWrapAmount(bubbleWrap, BudgetPackageList budgetPackage) {
    if (bubbleWrap == 0) {
      return double.parse('0');
    } else {
      double amount = 0;
      for (var i = 0; i < bubbleWrap; i++) {
        amount = amount + double.parse(budgetPackage.bubbleWrapping!);
      }
      return amount;
    }
  }

  static dynamic diningTableAmount(
      diningTable, BudgetPackageList budgetPackage) {
    if (diningTable == 0) {
      return double.parse('0');
    } else {
      double amount = 0;
      for (var i = 0; i < diningTable; i++) {
        amount = amount + double.parse(budgetPackage.diningTableCount!);
      }
      return amount;
    }
  }

  static dynamic bedAmount(bed, BudgetPackageList budgetPackage) {
    if (bed == 0) {
      return double.parse('0');
    } else {
      double amount = 0;
      for (var i = 0; i < bed; i++) {
        amount = amount + double.parse(budgetPackage.bedCount!);
      }
      return amount;
    }
  }

  static dynamic officeTableAmount(
      officeTable, BudgetPackageList budgetPackage) {
    if (officeTable == 0) {
      return double.parse('0');
    } else {
      double amount = 0;
      for (var i = 0; i < officeTable; i++) {
        amount = amount + double.parse(budgetPackage.tableCount!);
      }
      return amount;
    }
  }

  static dynamic wardrobeAmount(wardrobe, BudgetPackageList budgetPackage) {
    if (wardrobe == 0) {
      return double.parse('0');
    } else {
      double amount = 0;
      for (var i = 0; i < wardrobe; i++) {
        amount = amount + double.parse(budgetPackage.wardrobeCount!);
      }
      return amount;
    }
  }

  static dynamic insuranceAmount(insurance, budgetPackage) {
    if (insurance == false || budgetPackage == null) {
      return double.parse('0');
    } else {
      return double.parse(budgetPackage.insurance!);
    }
  }

  static dynamic stairCarryAmount(stairCarry, BudgetPackageList budgetPackage) {
    debugPrint(stairCarry.toString());
    if (stairCarry == 0) {
      debugPrint(" ====: ${stairCarry.toString()}");
      return double.parse('0');
    } else {
      double amount = 0;
      debugPrint(" ====: ${stairCarry.toString()}");
      for (var i = 0; i < stairCarry; i++) {
        amount = amount + double.parse(budgetPackage.stairCase!);
      }
      return amount;
    }
  }

  static dynamic tailGateAmount(tailGate, BudgetPackageList budgetPackage) {
    if (tailGate == false) {
      return double.parse('0');
    } else {
      return double.parse(budgetPackage.tailgateCount!);
    }
  }

  static dynamic longPushAmount(longPush, longPushType) {
    if (longPush == 0 || longPushType.isEmpty) {
      return double.parse('0');
    } else {
      final index = longPush - 1;
      return double.parse(longPushType[index].rate!);
    }
  }

  ///  Premium Calculation

  static premiumDistanceAmount(distance, PremiumPackageList premiumPackage) {
    if (distance > 60) {
      double distancePrice = double.parse(premiumPackage.above60km!);
      return double.parse(premiumPackage.basePrice!) +
          (distancePrice * (distance - 60).toDouble());
    } else {
      return double.parse(premiumPackage.basePrice!);
    }
  }

  static dynamic premiumManpowerAmount(
      manPower, PremiumPackageList premiumPackage) {
    if (manPower == 0) {
      return double.parse('0');
    } else {
      double amount = 0;
      for (var i = 0; i < manPower; i++) {
        amount = amount + double.parse(premiumPackage.manpower!);
      }
      return amount;
    }
  }

  static dynamic premiumStairCarryAmount(
      stairCarry, PremiumPackageList premiumPackage) {
    debugPrint(stairCarry.toString());
    if (stairCarry == 0) {
      debugPrint(" ====: ${stairCarry.toString()}");
      return double.parse('0');
    } else {
      double amount = 0;
      debugPrint(" ====: ${stairCarry.toString()}");
      for (var i = 0; i < stairCarry; i++) {
        amount = amount + double.parse(premiumPackage.stairCase!);
      }
      return amount;
    }
  }

  static dynamic premiumTailGateAmount(
      tailGate, PremiumPackageList premiumPackage) {
    if (tailGate == false) {
      return double.parse('0');
    } else {
      return double.parse(premiumPackage.tailgateCount!);
    }
  }

  static dynamic premiumLongPushAmount(
      longPush, List<PremiumLongPushTypeList> longPushType) {
    if (longPush == 0 || longPushType.isEmpty) {
      return double.parse('0');
    } else {
      final index = longPush - 1;
      return double.parse(longPushType[index].rate!);
    }
  }

  ///  Manpower Calculation

  static double serviceHourAmount(serviceHour, manpowerPackage) {
    if (serviceHour == 0 || manpowerPackage == null) {
      return double.parse('0');
    } else if (serviceHour == 2) {
      return double.parse(manpowerPackage.twoHours.toString());
    } else if (serviceHour == 3) {
      return double.parse(manpowerPackage.threeHours.toString());
    } else if (serviceHour == 4) {
      return double.parse(manpowerPackage.fourHours.toString());
    } else if (serviceHour == 5) {
      return double.parse(manpowerPackage.fiveHours.toString());
    } else {
      return double.parse('0');
    }
  }

  static double serviceFullDayAmount(manpowerPackage) {
    if (manpowerPackage == null) {
      return double.parse('0');
    } else {
      return double.parse(manpowerPackage.wholeday9amto5pm.toString());
    }
  }

  /// Total Amount Calculation

  static double totalAmount(List amountList) {
    double amount = 0;
    for (var i = 0; i < amountList.length; i++) {
      amount = amount + amountList[i];
    }
    return amount;
  }
}
