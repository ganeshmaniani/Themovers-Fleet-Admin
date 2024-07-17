class DisposalBookingModel {
  List<DisposalPackageList>? disposalPackageList;
  BookingDisposalEditDetails? bookingDisposalEditDetails;
  List<AdditionalAmountHistoryDisposalEditList>? additionalAmountHistoryList;

  String? apiSuccess;
  String? apiMessage;

  DisposalBookingModel(
      {this.disposalPackageList,
      this.bookingDisposalEditDetails,
      this.additionalAmountHistoryList,
      this.apiSuccess,
      this.apiMessage});

  DisposalBookingModel.fromJson(Map<String, dynamic> json) {
    if (json['disposal_package_list'] != null) {
      disposalPackageList = <DisposalPackageList>[];
      json['disposal_package_list'].forEach((v) {
        disposalPackageList!.add(DisposalPackageList.fromJson(v));
      });
    }
    bookingDisposalEditDetails = json['booking_disposal_edit_details'] != null
        ? BookingDisposalEditDetails.fromJson(
            json['booking_disposal_edit_details'])
        : null;
    if (json['additional_amount_history_list'] != null) {
      additionalAmountHistoryList = <AdditionalAmountHistoryDisposalEditList>[];
      json['additional_amount_history_list'].forEach((v) {
        additionalAmountHistoryList!
            .add(new AdditionalAmountHistoryDisposalEditList.fromJson(v));
      });
    }
    apiSuccess = json['Api_success'];
    apiMessage = json['Api_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (disposalPackageList != null) {
      data['disposal_package_list'] =
          disposalPackageList!.map((v) => v.toJson()).toList();
    }
    if (bookingDisposalEditDetails != null) {
      data['booking_disposal_edit_details'] =
          bookingDisposalEditDetails!.toJson();
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

class DisposalPackageList {
  int? id;
  String? tonne;
  String? basePrice;
  String? createdBy;
  String? createdAt;

  DisposalPackageList(
      {this.id, this.tonne, this.basePrice, this.createdBy, this.createdAt});

  DisposalPackageList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tonne = json['tonne'];
    basePrice = json['base_price'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tonne'] = tonne;
    data['base_price'] = basePrice;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    return data;
  }
}

class BookingDisposalEditDetails {
  int? bookingId;
  String? id;
  String? additionalService;

  int? customerId;
  String? serviceType;
  String? vehicleType;
  String? amount;
  String? totalAmount;
  String? bookingStatus;
  String? createdBy;
  String? createdAt;
  String? updatedBy;
  String? updatedAt;

  BookingDisposalEditDetails(
      {this.bookingId,
      this.id,
      this.additionalService,
      this.customerId,
      this.serviceType,
      this.vehicleType,
      this.amount,
      this.totalAmount,
      this.bookingStatus,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt});

  BookingDisposalEditDetails.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    id = json['id'];
    additionalService = json['additional_service'];
    customerId = json['customer_id'];
    serviceType = json['service_type'];
    vehicleType = json['vehicle_type'];
    amount = json['amount'];
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
    data['additional_service'] = additionalService;
    data['customer_id'] = customerId;
    data['service_type'] = serviceType;
    data['vehicle_type'] = vehicleType;
    data['amount'] = amount;
    data['total_amount'] = totalAmount;
    data['booking_status'] = bookingStatus;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_by'] = updatedBy;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class AdditionalAmountHistoryDisposalEditList {
  int? additionalAmountHistoryId;
  String? bookingId;
  String? additionalAmount;

  AdditionalAmountHistoryDisposalEditList(
      {this.additionalAmountHistoryId, this.bookingId, this.additionalAmount});

  AdditionalAmountHistoryDisposalEditList.fromJson(Map<String, dynamic> json) {
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
