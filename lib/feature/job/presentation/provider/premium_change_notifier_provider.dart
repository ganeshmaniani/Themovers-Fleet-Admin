import 'package:flutter/material.dart';

import '../../../feature.dart';

class PremiumChangeNotifierProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  int? _selectVehicleType;
  String? _vehicleSpecification;

  PremiumPackageList? _premiumPackage;

  int? _stairCarry;
  bool? _tailGate;
  int? _longPush = 0;

  List<PremiumLongPushTypeList>? _longPushType = [];

  int? get selectVehicleType => _selectVehicleType;

  String? get vehicleSpecification => _vehicleSpecification;

  int? get stairCarry => _stairCarry;

  bool? get tailGate => _tailGate;

  int? get longPush => _longPush;

  List<PremiumLongPushTypeList>? get longPushType => _longPushType;

  PremiumPackageList? get premiumPackage => _premiumPackage;

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  /// Vehicle Type and Specification and Amount
  Future<void> setVehicleType(int type) async {
    _selectVehicleType = type;
    notifyListeners();
  }

  Future<void> setVehicleSpecification(String res) async {
    _vehicleSpecification = res;
    notifyListeners();
  }

  Future<void> setPremiumPackage(PremiumPackageList premiumPackage) async {
    _premiumPackage = premiumPackage;
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

  Future<void> setLongPushType(List<PremiumLongPushTypeList> longPush) async {
    _longPushType = longPush;
    notifyListeners();
  }
}
