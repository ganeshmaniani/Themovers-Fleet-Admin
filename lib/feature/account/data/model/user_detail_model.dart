class UserDetailModel {
  UserDetail? userDetail;
  String? apiSuccess;
  String? apiMessage;

  UserDetailModel({this.userDetail, this.apiSuccess, this.apiMessage});

  UserDetailModel.fromJson(Map<String, dynamic> json) {
    userDetail =
        json['users'] != null ? UserDetail.fromJson(json['users']) : null;
    apiSuccess = json['Api_success'];
    apiMessage = json['Api_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userDetail != null) {
      data['users'] = userDetail!.toJson();
    }
    data['Api_success'] = apiSuccess;
    data['Api_message'] = apiMessage;
    return data;
  }
}

class UserDetail {
  int? id;
  String? name;
  String? email;
  String? password;
  String? mobileNumber;
  String? plainPassword;
  String? profileImage;
  String? companyName;
  String? branchAddress;
  String? branchLatitude;
  String? branchLongitude;
  String? businessSsmRegistration;
  String? nric;
  String? license;
  String? grant;
  String? walletBalance;

  UserDetail(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.mobileNumber,
      this.plainPassword,
      this.profileImage,
      this.companyName,
      this.branchAddress,
      this.branchLatitude,
      this.branchLongitude,
      this.businessSsmRegistration,
      this.nric,
      this.license,
      this.grant,
      this.walletBalance});

  UserDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    mobileNumber = json['mobile_number'];
    plainPassword = json['plain_password'];
    profileImage = json['profile_image'];
    companyName = json['company_name'];
    branchAddress = json['branch_address'];
    branchLatitude = json['branch_latitude'];
    branchLongitude = json['branch_longitude'];
    businessSsmRegistration = json['business_ssm_registration'];
    nric = json['nric'];
    license = json['license'];
    grant = json['grant'];
    walletBalance = json['wallet_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['mobile_number'] = mobileNumber;
    data['plain_password'] = plainPassword;
    data['profile_image'] = profileImage;
    data['company_name'] = companyName;
    data['branch_address'] = branchAddress;
    data['branch_latitude'] = branchLatitude;
    data['branch_longitude'] = branchLongitude;
    data['business_ssm_registration'] = businessSsmRegistration;
    data['nric'] = nric;
    data['license'] = license;
    data['grant'] = grant;
    data['wallet_balance'] = walletBalance;
    return data;
  }
}
