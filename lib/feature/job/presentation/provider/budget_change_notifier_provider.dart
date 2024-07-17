import 'package:flutter/material.dart';

import '../../../feature.dart';

class BudgetChangeNotifierProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  DateTime? _date;
  TimeOfDay? _time;

  int? _selectVehicleType;
  String? _vehicleSpecification;

  BudgetPackageList? _budgetPackage;

  int? _manPowerCount;
  int? _boxCount;

  int? _shrinkWrap;
  int? _bubbleWrap;

  int? _diningTable;
  int? _officeTable;
  int? _bed;
  int? _wardrobe;

  bool? _insurance;
  int? _stairCarry;
  bool? _tailGate;

  int? _longPush = 0;
  List<LongPushTypeList>? _longPushType = [];

  String? _coupon;

  DateTime? get date => _date;

  TimeOfDay? get time => _time;

  int? get selectVehicleType => _selectVehicleType;

  String? get vehicleSpecification => _vehicleSpecification;

  BudgetPackageList? get budgetPackage => _budgetPackage;

  int? get manPowerCount => _manPowerCount;

  int? get boxCount => _boxCount;

  int? get shrinkWrap => _shrinkWrap;

  int? get bubbleWrap => _bubbleWrap;

  int? get diningTable => _diningTable;

  int? get officeTable => _officeTable;

  int? get bed => _bed;

  int? get wardrobe => _wardrobe;

  bool? get insurance => _insurance;

  int? get stairCarry => _stairCarry;

  bool? get tailGate => _tailGate;

  int? get longPush => _longPush;

  List<LongPushTypeList>? get longPushType => _longPushType;

  String? get coupon => _coupon;

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  /// Date and Time

  Future<void> setDate(DateTime data) async {
    _date = data;
    notifyListeners();
  }

  Future<void> setTime(TimeOfDay time) async {
    _time = time;
    notifyListeners();
  }

  /// Vehicle Type and Specification and Budget Moving Amount List
  Future<void> setVehicleType(int type) async {
    _selectVehicleType = type;
    notifyListeners();
  }

  Future<void> setVehicleSpecification(String res) async {
    _vehicleSpecification = res;
    notifyListeners();
  }

  Future<void> setBudgetMoving(BudgetPackageList data) async {
    _budgetPackage = data;
    notifyListeners();
  }

  /// Additional Services
  /// Man Power Count and Amount
  Future<void> setManPowerCount(int count) async {
    _manPowerCount = count;
    notifyListeners();
  }

  /// Box Count and Amount
  Future<void> setBoxCount(int count) async {
    _boxCount = count;
    notifyListeners();
  }

  /// Wrapping count and amount
  Future<void> setShrinkWrap(int count) async {
    _shrinkWrap = count;
    notifyListeners();
  }

  Future<void> setBubbleWrap(int count) async {
    _bubbleWrap = count;
    notifyListeners();
  }

  /// Assembly Disassembly count and amount
  Future<void> setDiningTable(int count) async {
    _diningTable = count;
    notifyListeners();
  }

  Future<void> setOfficeTable(int count) async {
    _officeTable = count;
    notifyListeners();
  }

  Future<void> setBed(int count) async {
    _bed = count;
    notifyListeners();
  }

  Future<void> setWardrobe(int count) async {
    _wardrobe = count;
    notifyListeners();
  }

  /// Insurance is Selected  and Amount
  Future<void> setInsurance(bool isTrueOrFalse) async {
    _insurance = isTrueOrFalse;
    notifyListeners();
  }

  /// Stair Carry is Selected  and Amount
  Future<void> setStairCarry(int count) async {
    _stairCarry = count;
    notifyListeners();
  }

  /// Tail Gate is Selected  and Amount
  Future<void> setTailGate(bool isTrueOrFalse) async {
    _tailGate = isTrueOrFalse;
    notifyListeners();
  }

  /// Long Push is Selected and LongPushTypeList
  Future<void> setLongPushIndex(int index) async {
    _longPush = index;
    notifyListeners();
  }

  Future<void> setLongPushType(List<LongPushTypeList> longPush) async {
    _longPushType = longPush;
    notifyListeners();
  }

  /// Coupon amount
  Future<void> setCoupon(String code) async {
    _coupon = code;
    notifyListeners();
  }

  Future<void> setBudgetBookingDetail(BookingBudgetEditDetails? bookingBudget,
      List<LongPushTypeList> longPushTypeList) async {
    setManPowerCount(bookingBudget?.manpowerCount ?? 0);
    setBoxCount(bookingBudget?.boxCount ?? 0);
    setBubbleWrap(bookingBudget?.bubble ?? 0);
    setShrinkWrap(bookingBudget?.wrapping ?? 0);
    setDiningTable(bookingBudget?.diningTableCount ?? 0);
    setOfficeTable(bookingBudget?.tableCount ?? 0);
    setBed(bookingBudget?.bedCount ?? 0);
    setWardrobe(bookingBudget?.wardrobeCount ?? 0);
    setStairCarry(int.parse(bookingBudget?.stairCarryEnabled ?? '0'));
    setTailGate(bookingBudget?.tailGate == 'Yes' ? true : false);
    setLongPushIndex(int.parse(bookingBudget?.longpushEnabled ?? '0'));
    setLongPushType(longPushTypeList);
  }
}
