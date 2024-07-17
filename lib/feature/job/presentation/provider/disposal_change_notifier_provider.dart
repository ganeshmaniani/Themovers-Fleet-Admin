import 'package:flutter/material.dart';

import '../../../feature.dart';

class DisposalChangeNotifierProvider extends ChangeNotifier {
  bool _isLoading = false;

  int? _selectVehicleType;
  String? _vehicleSpecification;

  DisposalPackageList? _disposalPackage;

  bool get isLoading => _isLoading;

  int? get selectVehicleType => _selectVehicleType;

  String? get vehicleSpecification => _vehicleSpecification;

  DisposalPackageList? get disposalPackage => _disposalPackage;

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

  Future<void> setDisposalPackage(DisposalPackageList disposalPackage) async {
    _disposalPackage = disposalPackage;
    notifyListeners();
  }
}
