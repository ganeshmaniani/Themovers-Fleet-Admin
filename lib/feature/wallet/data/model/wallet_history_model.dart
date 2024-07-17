class WalletHistoryModel {
  String? apiSuccess;
  List<WalletHistory>? walletHistory;
  String? totalAmount;

  WalletHistoryModel({this.apiSuccess, this.walletHistory, this.totalAmount});

  WalletHistoryModel.fromJson(Map<String, dynamic> json) {
    apiSuccess = json['Api_success'];
    if (json['history'] != null) {
      walletHistory = <WalletHistory>[];
      json['history'].forEach((v) {
        walletHistory!.add(WalletHistory.fromJson(v));
      });
    }
    totalAmount = json['sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Api_success'] = apiSuccess;
    if (walletHistory != null) {
      data['history'] = walletHistory!.map((v) => v.toJson()).toList();
    }
    data['sum'] = totalAmount;
    return data;
  }
}

class WalletHistory {
  int? topupId;
  String? topupDateTime;
  String? revenueAmount;
  String? amount;
  String? previousBalance;
  String? totalWalletAmount;
  int? paymentMode;
  String? paymentDescription;
  String? paymentReferenceNumber;
  int? fleetAdminId;
  int? bookingId;
  int? createdBy;
  String? createdAt;
  WalletHistory(
      {this.topupId,
      this.topupDateTime,
      this.revenueAmount,
      this.amount,
      this.previousBalance,
      this.totalWalletAmount,
      this.paymentMode,
      this.paymentDescription,
      this.paymentReferenceNumber,
      this.fleetAdminId,
      this.bookingId,
      this.createdBy,
      this.createdAt});

  WalletHistory.fromJson(Map<String, dynamic> json) {
    topupId = json['topup_id'];
    topupDateTime = json['topup_date_time'];
    revenueAmount = json['revenue_amount'];
    amount = json['amount'];
    previousBalance = json['previous_balance'];
    totalWalletAmount = json['total_wallet_amount'];
    paymentMode = json['payment_mode'];
    paymentDescription = json['payment_description'];
    paymentReferenceNumber = json['payment_reference_number'];
    fleetAdminId = json['fleet_admin_id'];
    bookingId = json['booking_id'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['topup_id'] = topupId;
    data['topup_date_time'] = topupDateTime;
    data['revenue_amount'] = revenueAmount;
    data['amount'] = amount;
    data['previous_balance'] = previousBalance;
    data['total_wallet_amount'] = totalWalletAmount;
    data['payment_mode'] = paymentMode;
    data['payment_description'] = paymentDescription;
    data['payment_reference_number'] = paymentReferenceNumber;
    data['fleet_admin_id'] = fleetAdminId;
    data['booking_id'] = bookingId;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    return data;
  }
}
