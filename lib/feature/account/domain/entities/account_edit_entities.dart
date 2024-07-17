import 'dart:io';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AccountEditEntities extends Equatable {
  String name;
  String email;
  String mobileNumber;
  String companyName;
  String branchAddress;
  String businessSsmRegistration;
  String nric;
  String license;
  String grant;

  AccountEditEntities({
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.companyName,
    required this.branchAddress,
    required this.businessSsmRegistration,
    required this.nric,
    required this.license,
    required this.grant,
  });

  @override
  List<Object> get props {
    return [
      name,
      email,
      mobileNumber,
      companyName,
      branchAddress,
      businessSsmRegistration,
      nric,
      license,
      grant,
    ];
  }

  @override
  bool get stringify => true;

  AccountEditEntities copyWith({
    final String? name,
    final String? email,
    final String? mobileNumber,
    final File? profileImage,
    final String? companyName,
    final String? branchAddress,
    final String? businessSsmRegistration,
    final String? nric,
    final String? license,
    final String? grant,
  }) {
    return AccountEditEntities(
      name: name ?? this.name,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      companyName: companyName ?? this.companyName,
      branchAddress: branchAddress ?? this.branchAddress,
      businessSsmRegistration:
          businessSsmRegistration ?? this.businessSsmRegistration,
      nric: nric ?? this.nric,
      license: license ?? this.license,
      grant: grant ?? this.grant,
    );
  }
}
