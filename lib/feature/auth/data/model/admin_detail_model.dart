class AdminDetail {
  String? apiSuccess;
  String? message;
  Admin? admin;
  String? token;

  AdminDetail({this.apiSuccess, this.message, this.admin, this.token});

  AdminDetail.fromJson(Map<String, dynamic> json) {
    apiSuccess = json['api_success'];
    message = json['message'];
    admin = json['user'] != null ? Admin.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['api_success'] = apiSuccess;
    data['message'] = message;
    if (admin != null) {
      data['user'] = admin!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class Admin {
  int? id;
  String? userRole;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? password;
  String? mobileNumber;
  String? plainPassword;
  int? userType;
  String? deviceId;
  String? profileImage;
  String? companyName;
  String? branchAddress;
  String? branchLatitude;
  String? branchLongitude;
  String? rememberToken;
  String? token;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  int? updatedBy;
  String? deleted;
  String? deletedReason;
  String? businessSsmRegistration;
  String? nric;
  String? license;
  String? walletBalance;
  String? customerType;
  int? activationStatus;
  int? activeStatus;

  Admin({
    this.id,
    this.userRole,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.mobileNumber,
    this.plainPassword,
    this.userType,
    this.deviceId,
    this.profileImage,
    this.companyName,
    this.branchAddress,
    this.branchLatitude,
    this.branchLongitude,
    this.token,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.updatedBy,
    this.deleted,
    this.deletedReason,
    this.businessSsmRegistration,
    this.nric,
    this.license,
    this.walletBalance,
    this.customerType,
    this.activationStatus,
    this.activeStatus,
  });

  Admin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userRole = json['user_role'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    mobileNumber = json['mobile_number'];
    plainPassword = json['plain_password'];
    userType = json['user_type'];
    deviceId = json['device_id'];
    profileImage = json['profile_image'];
    companyName = json['company_name'];
    branchAddress = json['branch_address'];
    branchLatitude = json['branch_latitude'];
    branchLongitude = json['branch_longitude'];
    token = json['token'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
    deleted = json['deleted'];
    deletedReason = json['deleted_reason'];
    businessSsmRegistration = json['business_ssm_registration'];
    nric = json['nric'];
    license = json['license'];
    walletBalance = json['wallet_balance'];
    customerType = json['customer_type'];
    activationStatus = json['activation_status'];
    activeStatus = json['active_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_role'] = userRole;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['mobile_number'] = mobileNumber;
    data['plain_password'] = plainPassword;
    data['user_type'] = userType;
    data['device_id'] = deviceId;
    data['profile_image'] = profileImage;
    data['company_name'] = companyName;
    data['branch_address'] = branchAddress;
    data['branch_latitude'] = branchLatitude;
    data['branch_longitude'] = branchLongitude;
    data['token'] = token;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['updated_by'] = updatedBy;
    data['deleted'] = deleted;
    data['deleted_reason'] = deletedReason;
    data['business_ssm_registration'] = businessSsmRegistration;
    data['nric'] = nric;
    data['license'] = license;
    data['wallet_balance'] = walletBalance;
    data['customer_type'] = customerType;
    data['activation_status'] = activationStatus;
    data['active_status'] = activeStatus;
    return data;
  }
}
