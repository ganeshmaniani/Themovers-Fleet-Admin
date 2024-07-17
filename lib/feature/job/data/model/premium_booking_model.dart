class PremiumBookingModel {
  List<PremiumPackageList>? premiumPackageList;
  List<PremiumLongPushTypeList>? longPushTypeList;
  List<AdditionalAmountHistoryPremiumEditList>? additionalAmountHistoryList;
  BookingPremiumEditDetails? bookingPremiumEditDetails;
  String? apiSuccess;
  String? apiMessage;

  PremiumBookingModel(
      {this.premiumPackageList,
      this.longPushTypeList,
      this.bookingPremiumEditDetails,
      this.additionalAmountHistoryList,
      this.apiSuccess,
      this.apiMessage});

  PremiumBookingModel.fromJson(Map<String, dynamic> json) {
    if (json['premium_package_list'] != null) {
      premiumPackageList = <PremiumPackageList>[];
      json['premium_package_list'].forEach((v) {
        premiumPackageList!.add(PremiumPackageList.fromJson(v));
      });
    }
    if (json['longpush_type_list'] != null) {
      longPushTypeList = <PremiumLongPushTypeList>[];
      json['longpush_type_list'].forEach((v) {
        longPushTypeList!.add(PremiumLongPushTypeList.fromJson(v));
      });
    }
    bookingPremiumEditDetails = json['booking_premium_edit_details'] != null
        ? BookingPremiumEditDetails.fromJson(
            json['booking_premium_edit_details'])
        : null;
    if (json['additional_amount_history_list'] != null) {
      additionalAmountHistoryList = <AdditionalAmountHistoryPremiumEditList>[];
      json['additional_amount_history_list'].forEach((v) {
        additionalAmountHistoryList!
            .add(new AdditionalAmountHistoryPremiumEditList.fromJson(v));
      });
    }
    apiSuccess = json['Api_success'];
    apiMessage = json['Api_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (premiumPackageList != null) {
      data['premium_package_list'] =
          premiumPackageList!.map((v) => v.toJson()).toList();
    }
    if (longPushTypeList != null) {
      data['longpush_type_list'] =
          longPushTypeList!.map((v) => v.toJson()).toList();
    }
    if (bookingPremiumEditDetails != null) {
      data['booking_premium_edit_details'] =
          bookingPremiumEditDetails!.toJson();
    }
    if (this.additionalAmountHistoryList != null) {
      data['additional_amount_history_list'] =
          this.additionalAmountHistoryList!.map((v) => v.toJson()).toList();
    }
    data['Api_success'] = apiSuccess;
    data['Api_message'] = apiMessage;
    return data;
  }
}

class PremiumPackageList {
  int? id;
  String? tonne;
  String? basePrice;
  String? above60km;
  String? manpower;
  String? stairCase;
  String? tailgateCount;
  String? createdBy;
  String? createdAt;

  PremiumPackageList(
      {this.id,
      this.tonne,
      this.basePrice,
      this.above60km,
      this.manpower,
      this.stairCase,
      this.tailgateCount,
      this.createdBy,
      this.createdAt});

  PremiumPackageList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tonne = json['tonne'];
    basePrice = json['base_price'];
    above60km = json['above60km'];
    manpower = json['manpower'];
    stairCase = json['stair_case'];
    tailgateCount = json['tailgate_count'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tonne'] = tonne;
    data['base_price'] = basePrice;
    data['above60km'] = above60km;
    data['manpower'] = manpower;
    data['stair_case'] = stairCase;
    data['tailgate_count'] = tailgateCount;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    return data;
  }
}

class PremiumLongPushTypeList {
  int? id;
  String? name;
  String? rate;
  String? description;
  int? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;
  String? deleted;
  String? deletedReason;

  PremiumLongPushTypeList(
      {this.id,
      this.name,
      this.rate,
      this.description,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt,
      this.deleted,
      this.deletedReason});

  PremiumLongPushTypeList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rate = json['rate'];
    description = json['description'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    deleted = json['deleted'];
    deletedReason = json['deleted_reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['rate'] = rate;
    data['description'] = description;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_by'] = updatedBy;
    data['updated_at'] = updatedAt;
    data['deleted'] = deleted;
    data['deleted_reason'] = deletedReason;
    return data;
  }
}

class BookingPremiumEditDetails {
  int? bookingId;
  String? id;
  int? customerId;
  String? serviceType;
  String? amount;
  String? vehicleType;
  String? stairCarryEnabled;
  String? longpushEnabled;
  String? tailGate;
  String? vehicleAmount;
  String? stairCarryEnabledAmount;
  String? longpushEnabledAmount;
  String? tailgateAmount;
  String? totalAmount;
  String? bookingStatus;
  String? createdBy;
  String? createdAt;
  String? updatedBy;
  String? updatedAt;

  BookingPremiumEditDetails(
      {this.bookingId,
      this.id,
      this.customerId,
      this.serviceType,
      this.amount,
      this.vehicleType,
      this.stairCarryEnabled,
      this.longpushEnabled,
      this.tailGate,
      this.vehicleAmount,
      this.stairCarryEnabledAmount,
      this.longpushEnabledAmount,
      this.tailgateAmount,
      this.totalAmount,
      this.bookingStatus,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt});

  BookingPremiumEditDetails.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    id = json['id'];
    customerId = json['customer_id'];
    serviceType = json['service_type'];
    amount = json['amount'];
    vehicleType = json['vehicle_type'];
    stairCarryEnabled = json['stair_carry_enabled'];
    longpushEnabled = json['longpush_enabled'];
    tailGate = json['tail_gate'];
    vehicleAmount = json['vehicle_amount'];
    stairCarryEnabledAmount = json['stair_carry_enabled_amount'];
    longpushEnabledAmount = json['longpush_enabled_amount'];
    tailgateAmount = json['tailgate_amount'];
    totalAmount = json['total_amount'];
    bookingStatus = json['booking_status'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['booking_id'] = bookingId;
    data['id'] = id;
    data['customer_id'] = customerId;
    data['service_type'] = serviceType;
    data['amount'] = amount;
    data['vehicle_type'] = vehicleType;
    data['stair_carry_enabled'] = stairCarryEnabled;
    data['longpush_enabled'] = longpushEnabled;
    data['tail_gate'] = tailGate;
    data['vehicle_amount'] = vehicleAmount;
    data['stair_carry_enabled_amount'] = stairCarryEnabledAmount;
    data['longpush_enabled_amount'] = longpushEnabledAmount;
    data['tailgate_amount'] = tailgateAmount;
    data['total_amount'] = totalAmount;
    data['booking_status'] = bookingStatus;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_by'] = updatedBy;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class AdditionalAmountHistoryPremiumEditList {
  int? additionalAmountHistoryId;
  String? bookingId;
  String? additionalAmount;

  AdditionalAmountHistoryPremiumEditList(
      {this.additionalAmountHistoryId, this.bookingId, this.additionalAmount});

  AdditionalAmountHistoryPremiumEditList.fromJson(Map<String, dynamic> json) {
    additionalAmountHistoryId = json['additional_amount_history_id'];
    bookingId = json['booking_id'];
    additionalAmount = json['additional_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['additional_amount_history_id'] = this.additionalAmountHistoryId;
    data['booking_id'] = this.bookingId;
    data['additional_amount'] = this.additionalAmount;
    return data;
  }
}
