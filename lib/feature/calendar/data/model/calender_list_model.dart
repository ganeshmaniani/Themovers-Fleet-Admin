class CalenderListModel {
  String? apiSuccess;
  List<CalenderBooking>? calenderBooking;

  CalenderListModel({this.apiSuccess, this.calenderBooking});

  CalenderListModel.fromJson(Map<String, dynamic> json) {
    apiSuccess = json['Api_success'];
    if (json['calander_booking_list'] != null) {
      calenderBooking = <CalenderBooking>[];
      json['calander_booking_list'].forEach((v) {
        calenderBooking!.add(CalenderBooking.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Api_success'] = apiSuccess;
    if (calenderBooking != null) {
      data['calander_booking_list'] =
          calenderBooking!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CalenderBooking {
  String? id;
  int? customerId;
  String? bookingType;
  String? bookingDateTime;
  String? pickupAddress;
  String? dropOffAddress;
  String? distance;
  int? vehicleType;
  String? amount;
  String? description;
  int? manpowerCount;
  int? boxCount;
  int? wrapping;
  int? bubble;
  String? shrinkWrapping;
  String? bubbleWrapping;
  int? diningTableCount;
  int? bedCount;
  int? tableCount;
  int? wardrobeCount;
  String? couponCode;
  String? stairCarryEnabled;
  String? longpushEnabled;
  String? insurance;
  String? tailGate;
  String? serviceHours;
  String? serviceTime;
  String? dateTime;
  String? enabled;
  String? uploadPicture;
  int? serviceType;
  String? pickupGeometric;
  String? dropGeometric;
  String? tailGateEnabled;
  String? pickupLatitude;
  String? pickupLongitude;
  String? dropLatitude;
  String? dropLongitude;
  String? vehicleAmount;
  String? manpowerAmount;
  int? manpowerHourCount;
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
  int? bookingStatus;
  String? deleted;
  int? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;
  String? deletedReason;
  int? acceptedBy;
  String? acceptedAt;
  String? userName;
  String? mobileNumber;
  String? emailId;
  String? customerName;
  String? customerMobileNumber;
  String? customerEmailId;
  int? paymentMode;

  CalenderBooking(
      {this.id,
      this.customerId,
      this.bookingType,
      this.bookingDateTime,
      this.pickupAddress,
      this.dropOffAddress,
      this.distance,
      this.vehicleType,
      this.amount,
      this.description,
      this.manpowerCount,
      this.boxCount,
      this.wrapping,
      this.bubble,
      this.shrinkWrapping,
      this.bubbleWrapping,
      this.diningTableCount,
      this.bedCount,
      this.tableCount,
      this.wardrobeCount,
      this.couponCode,
      this.stairCarryEnabled,
      this.longpushEnabled,
      this.insurance,
      this.tailGate,
      this.serviceHours,
      this.serviceTime,
      this.dateTime,
      this.enabled,
      this.uploadPicture,
      this.serviceType,
      this.pickupGeometric,
      this.dropGeometric,
      this.tailGateEnabled,
      this.pickupLatitude,
      this.pickupLongitude,
      this.dropLatitude,
      this.dropLongitude,
      this.vehicleAmount,
      this.manpowerAmount,
      this.manpowerHourCount,
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
      this.deleted,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt,
      this.deletedReason,
      this.acceptedBy,
      this.acceptedAt,
      this.userName,
      this.mobileNumber,
      this.emailId,
      this.customerName,
      this.customerMobileNumber,
      this.customerEmailId,
      this.paymentMode});

  CalenderBooking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    bookingType = json['booking_type'];
    bookingDateTime = json['booking_date_time'];
    pickupAddress = json['pickup_address'];
    dropOffAddress = json['drop_off_address'];
    distance = json['distance'];
    vehicleType = json['vehicle_type'];
    amount = json['amount'];
    description = json['description'];
    manpowerCount = json['manpower_count'];
    boxCount = json['box_count'];
    wrapping = json['wrapping'];
    bubble = json['bubble'];
    shrinkWrapping = json['shrink_wrapping'];
    bubbleWrapping = json['bubble_wrapping'];
    diningTableCount = json['dining_table_count'];
    bedCount = json['bed_count'];
    tableCount = json['table_count'];
    wardrobeCount = json['wardrobe_count'];
    couponCode = json['coupon_code'];
    stairCarryEnabled = json['stair_carry_enabled'];
    longpushEnabled = json['longpush_enabled'];
    insurance = json['insurance'];
    tailGate = json['tail_gate'];
    serviceHours = json['service_hours'];
    serviceTime = json['service_time'];
    dateTime = json['date_time'];
    enabled = json['enabled'];
    uploadPicture = json['upload_picture'];
    serviceType = json['service_type'];
    pickupGeometric = json['pickup_geometric'];
    dropGeometric = json['drop_geometric'];
    tailGateEnabled = json['tail_gate_enabled'];
    pickupLatitude = json['pickup_latitude'];
    pickupLongitude = json['pickup_longitude'];
    dropLatitude = json['drop_latitude'];
    dropLongitude = json['drop_longitude'];
    vehicleAmount = json['vehicle_amount'];
    manpowerAmount = json['manpower_amount'];
    manpowerHourCount = json['manpower_hour_count'];
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
    deleted = json['deleted'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    deletedReason = json['deleted_reason'];
    acceptedBy = json['accepted_by'];
    acceptedAt = json['accepted_at'];
    userName = json['user_name'];
    mobileNumber = json['mobile_number'];
    emailId = json['email_id'];
    customerName = json['customer_name'];
    customerMobileNumber = json['customer_mobile_number'];
    customerEmailId = json['customer_email_id'];
    paymentMode = json['payment_mode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['booking_type'] = bookingType;
    data['booking_date_time'] = bookingDateTime;
    data['pickup_address'] = pickupAddress;
    data['drop_off_address'] = dropOffAddress;
    data['distance'] = distance;
    data['vehicle_type'] = vehicleType;
    data['amount'] = amount;
    data['description'] = description;
    data['manpower_count'] = manpowerCount;
    data['box_count'] = boxCount;
    data['wrapping'] = wrapping;
    data['bubble'] = bubble;
    data['shrink_wrapping'] = shrinkWrapping;
    data['bubble_wrapping'] = bubbleWrapping;
    data['dining_table_count'] = diningTableCount;
    data['bed_count'] = bedCount;
    data['table_count'] = tableCount;
    data['wardrobe_count'] = wardrobeCount;
    data['coupon_code'] = couponCode;
    data['stair_carry_enabled'] = stairCarryEnabled;
    data['longpush_enabled'] = longpushEnabled;
    data['insurance'] = insurance;
    data['tail_gate'] = tailGate;
    data['service_hours'] = serviceHours;
    data['service_time'] = serviceTime;
    data['date_time'] = dateTime;
    data['enabled'] = enabled;
    data['upload_picture'] = uploadPicture;
    data['service_type'] = serviceType;
    data['pickup_geometric'] = pickupGeometric;
    data['drop_geometric'] = dropGeometric;
    data['tail_gate_enabled'] = tailGateEnabled;
    data['pickup_latitude'] = pickupLatitude;
    data['pickup_longitude'] = pickupLongitude;
    data['drop_latitude'] = dropLatitude;
    data['drop_longitude'] = dropLongitude;
    data['vehicle_amount'] = vehicleAmount;
    data['manpower_amount'] = manpowerAmount;
    data['manpower_hour_count'] = manpowerHourCount;
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
    data['deleted'] = deleted;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_by'] = updatedBy;
    data['updated_at'] = updatedAt;
    data['deleted_reason'] = deletedReason;
    data['accepted_by'] = acceptedBy;
    data['accepted_at'] = acceptedAt;
    data['user_name'] = userName;
    data['mobile_number'] = mobileNumber;
    data['email_id'] = emailId;
    data['customer_name'] = customerName;
    data['customer_mobile_number'] = customerMobileNumber;
    data['customer_email_id'] = customerEmailId;
    data['payment_mode'] = paymentMode;
    return data;
  }
}
