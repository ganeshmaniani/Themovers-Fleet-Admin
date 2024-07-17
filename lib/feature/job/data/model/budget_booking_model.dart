class BudgetBookingModel {
  List<BudgetPackageList>? budgetPackageList;
  List<LongPushTypeList>? longPushTypeList;
  BookingBudgetEditDetails? bookingBudgetEditDetails;
  List<AdditionalAmountHistoryBudgetEditList>? additionalAmountHistoryList;

  bool? apiSuccess;
  String? apiMessage;

  BudgetBookingModel(
      {this.budgetPackageList,
      this.longPushTypeList,
      this.bookingBudgetEditDetails,
      this.additionalAmountHistoryList,
      this.apiSuccess,
      this.apiMessage});

  BudgetBookingModel.fromJson(Map<String, dynamic> json) {
    if (json['budget_package_list'] != null) {
      budgetPackageList = <BudgetPackageList>[];
      json['budget_package_list'].forEach((v) {
        budgetPackageList!.add(BudgetPackageList.fromJson(v));
      });
    }
    if (json['longpush_type_list'] != null) {
      longPushTypeList = <LongPushTypeList>[];
      json['longpush_type_list'].forEach((v) {
        longPushTypeList!.add(LongPushTypeList.fromJson(v));
      });
    }
    bookingBudgetEditDetails = json['booking_budget_edit_details'] != null
        ? BookingBudgetEditDetails.fromJson(json['booking_budget_edit_details'])
        : null;
    if (json['additional_amount_history_list'] != null) {
      additionalAmountHistoryList = <AdditionalAmountHistoryBudgetEditList>[];
      json['additional_amount_history_list'].forEach((v) {
        additionalAmountHistoryList!
            .add(new AdditionalAmountHistoryBudgetEditList.fromJson(v));
      });
    }
    apiSuccess = json['Api_success'];
    apiMessage = json['Api_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (budgetPackageList != null) {
      data['budget_package_list'] =
          budgetPackageList!.map((v) => v.toJson()).toList();
    }
    if (longPushTypeList != null) {
      data['longpush_type_list'] =
          longPushTypeList!.map((v) => v.toJson()).toList();
    }
    if (bookingBudgetEditDetails != null) {
      data['booking_budget_edit_details'] = bookingBudgetEditDetails!.toJson();
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

class BudgetPackageList {
  int? id;
  String? tonne;
  String? basePrice;
  String? addOnPrice1;
  String? addOnPrice2;
  String? manpower;
  String? stairCase;
  String? boxCount;
  String? shrinkWrapping;
  String? bubbleWrapping;
  String? diningTableCount;
  String? bedCount;
  String? tableCount;
  String? wardrobeCount;
  String? insurance;
  String? tailgateCount;
  String? createdBy;
  String? createdAt;

  BudgetPackageList(
      {this.id,
      this.tonne,
      this.basePrice,
      this.addOnPrice1,
      this.addOnPrice2,
      this.manpower,
      this.stairCase,
      this.boxCount,
      this.shrinkWrapping,
      this.bubbleWrapping,
      this.diningTableCount,
      this.bedCount,
      this.tableCount,
      this.wardrobeCount,
      this.insurance,
      this.tailgateCount,
      this.createdBy,
      this.createdAt});

  BudgetPackageList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tonne = json['tonne'];
    basePrice = json['base_price'];
    addOnPrice1 = json['add_on_price_1'];
    addOnPrice2 = json['add_on_price_2'];
    manpower = json['manpower'];
    stairCase = json['stair_case'];
    boxCount = json['box_count'];
    shrinkWrapping = json['shrink_wrapping'];
    bubbleWrapping = json['bubble_wrapping'];
    diningTableCount = json['dining_table_count'];
    bedCount = json['bed_count'];
    tableCount = json['table_count'];
    wardrobeCount = json['wardrobe_count'];
    insurance = json['insurance'];
    tailgateCount = json['tailgate_count'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tonne'] = tonne;
    data['base_price'] = basePrice;
    data['add_on_price_1'] = addOnPrice1;
    data['add_on_price_2'] = addOnPrice2;
    data['manpower'] = manpower;
    data['stair_case'] = stairCase;
    data['box_count'] = boxCount;
    data['shrink_wrapping'] = shrinkWrapping;
    data['bubble_wrapping'] = bubbleWrapping;
    data['dining_table_count'] = diningTableCount;
    data['bed_count'] = bedCount;
    data['table_count'] = tableCount;
    data['wardrobe_count'] = wardrobeCount;
    data['insurance'] = insurance;
    data['tailgate_count'] = tailgateCount;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    return data;
  }
}

class LongPushTypeList {
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

  LongPushTypeList(
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

  LongPushTypeList.fromJson(Map<String, dynamic> json) {
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

class BookingBudgetEditDetails {
  int? bookingId;
  String? id;
  int? customerId;
  String? serviceType;
  String? amount;
  String? vehicleType;
  int? manpowerCount;
  int? diningTableCount;
  int? boxCount;
  String? shrinkWrapping;
  String? bubbleWrapping;
  int? wrapping;
  int? bubble;
  int? bedCount;
  int? tableCount;
  int? wardrobeCount;
  String? stairCarryEnabled;
  String? longpushEnabled;
  String? insurance;
  String? tailGate;
  String? tailGateEnabled;
  String? vehicleAmount;
  String? manpowerAmount;
  String? boxAmount;
  String? shrinkWrapAmount;
  String? bubbleWrapAmount;
  String? diningTableAmount;
  String? bedAmount;
  String? tableAmount;
  String? wardrobeAmount;
  String? stairCarryEnabledAmount;
  String? longpushEnabledAmount;
  String? insuranceAmount;
  String? tailgateAmount;
  String? totalAmount;
  String? bookingStatus;
  String? createdBy;
  String? createdAt;
  String? updatedBy;
  String? updatedAt;

  BookingBudgetEditDetails(
      {this.bookingId,
      this.id,
      this.customerId,
      this.serviceType,
      this.amount,
      this.vehicleType,
      this.manpowerCount,
      this.diningTableCount,
      this.boxCount,
      this.shrinkWrapping,
      this.bubbleWrapping,
      this.wrapping,
      this.bubble,
      this.bedCount,
      this.tableCount,
      this.wardrobeCount,
      this.stairCarryEnabled,
      this.longpushEnabled,
      this.insurance,
      this.tailGate,
      this.tailGateEnabled,
      this.vehicleAmount,
      this.manpowerAmount,
      this.boxAmount,
      this.shrinkWrapAmount,
      this.bubbleWrapAmount,
      this.diningTableAmount,
      this.bedAmount,
      this.tableAmount,
      this.wardrobeAmount,
      this.stairCarryEnabledAmount,
      this.longpushEnabledAmount,
      this.insuranceAmount,
      this.tailgateAmount,
      this.totalAmount,
      this.bookingStatus,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt});

  BookingBudgetEditDetails.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    id = json['id'];
    customerId = json['customer_id'];
    serviceType = json['service_type'];
    amount = json['amount'];
    vehicleType = json['vehicle_type'];
    manpowerCount = json['manpower_count'];
    diningTableCount = json['dining_table_count'];
    boxCount = json['box_count'];
    shrinkWrapping = json['shrink_wrapping'];
    bubbleWrapping = json['bubble_wrapping'];
    wrapping = json['wrapping'];
    bubble = json['bubble'];
    bedCount = json['bed_count'];
    tableCount = json['table_count'];
    wardrobeCount = json['wardrobe_count'];
    stairCarryEnabled = json['stair_carry_enabled'];
    longpushEnabled = json['longpush_enabled'];
    insurance = json['insurance'];
    tailGate = json['tail_gate'];
    tailGateEnabled = json['tail_gate_enabled'];
    vehicleAmount = json['vehicle_amount'];
    manpowerAmount = json['manpower_amount'];
    boxAmount = json['box_amount'];
    shrinkWrapAmount = json['shrink_wrap_amount'];
    bubbleWrapAmount = json['bubble_wrap_amount'];
    diningTableAmount = json['dining_table_amount'];
    bedAmount = json['bed_amount'];
    tableAmount = json['table_amount'];
    wardrobeAmount = json['wardrobe_amount'];
    stairCarryEnabledAmount = json['stair_carry_enabled_amount'];
    longpushEnabledAmount = json['longpush_enabled_amount'];
    insuranceAmount = json['insurance_amount'];
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
    data['manpower_count'] = manpowerCount;
    data['dining_table_count'] = diningTableCount;
    data['box_count'] = boxCount;
    data['shrink_wrapping'] = shrinkWrapping;
    data['bubble_wrapping'] = bubbleWrapping;
    data['wrapping'] = wrapping;
    data['bubble'] = bubble;
    data['bed_count'] = bedCount;
    data['table_count'] = tableCount;
    data['wardrobe_count'] = wardrobeCount;
    data['stair_carry_enabled'] = stairCarryEnabled;
    data['longpush_enabled'] = longpushEnabled;
    data['insurance'] = insurance;
    data['tail_gate'] = tailGate;
    data['tail_gate_enabled'] = tailGateEnabled;
    data['vehicle_amount'] = vehicleAmount;
    data['manpower_amount'] = manpowerAmount;
    data['box_amount'] = boxAmount;
    data['shrink_wrap_amount'] = shrinkWrapAmount;
    data['bubble_wrap_amount'] = bubbleWrapAmount;
    data['dining_table_amount'] = diningTableAmount;
    data['bed_amount'] = bedAmount;
    data['table_amount'] = tableAmount;
    data['wardrobe_amount'] = wardrobeAmount;
    data['stair_carry_enabled_amount'] = stairCarryEnabledAmount;
    data['longpush_enabled_amount'] = longpushEnabledAmount;
    data['insurance_amount'] = insuranceAmount;
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

class AdditionalAmountHistoryBudgetEditList {
  int? additionalAmountHistoryId;
  String? bookingId;
  String? additionalAmount;

  AdditionalAmountHistoryBudgetEditList(
      {this.additionalAmountHistoryId, this.bookingId, this.additionalAmount});

  AdditionalAmountHistoryBudgetEditList.fromJson(Map<String, dynamic> json) {
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

class AdditionalAmountHistoryList {
  int? additionalAmountHistoryId;
  String? bookingId;
  String? additionalAmount;

  AdditionalAmountHistoryList(
      {this.additionalAmountHistoryId, this.bookingId, this.additionalAmount});

  AdditionalAmountHistoryList.fromJson(Map<String, dynamic> json) {
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
