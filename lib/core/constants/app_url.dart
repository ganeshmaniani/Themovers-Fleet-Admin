class ApiUrl {
  /// DOMAIN URL LOCAL & LIVE

  // static var baseUrl = 'http://192.168.1.8/themovers/';

  //

  //

  //

  //

  static var baseUrl = 'https://app.themovers.com.my/';

  /// Google Map Base Api EndPoints
  static var baseGoogleApi = 'https://maps.googleapis.com/maps/';

  /// Auth & User Details API EndPoints
  static var loginEndPoint = '${baseUrl}api/login';
  static var registrationEndPoint = '${baseUrl}api/fleet_admin_register';
  static var versionCodeEndPoint = '${baseUrl}api/get_app_playstore_version';

  static var checkUserActivationEndPoint =
      '${baseUrl}api/check_activation_details';

  static var forgetPasswordEndPoint = '${baseUrl}api/forget_password';

  /// OTP Request and Verification EndPoint
  static var sendEmailOtpEndPoint = '${baseUrl}api/send_mail';
  static var emailEmailOtpCheckingEndPoint = '${baseUrl}api/email_otp_checking';

  static var confirmPasswordUpdateEndPoint =
      '${baseUrl}api/fleet_admin_confirm_password_update';
  static var mobileNumberCheckerEndPoint =
      '${baseUrl}api/fleet_admin_mobile_check';

  static var emailCheckerEndPoint =
      '${baseUrl}api/reset_password_email_validation_fleet';

  static var storeFirebaseDeviceIdEndPoint = '${baseUrl}api/store_device_id';
  static var userDetailEndPoint = '${baseUrl}api/user_details';
  static var userUpdateEndPoint = '${baseUrl}api/user_account_update';
  static var profileUploadEndPoint = '${baseUrl}api/profile_upload';

  /// Dashboard Count EndPoints
  static var bookingStageListEndPoint = '${baseUrl}api/booking_status';

  /// Dashboard Slider EndPoints
  static var dashboardSliderList = '${baseUrl}api/fleet_slider_list';

  static var budgetBookingUpdateEndPoint =
      '${baseUrl}api/booking_budget_update';
  static var premiumBookingUpdateEndPoint =
      '${baseUrl}api/booking_premium_update';
  static var disposalBookingUpdateEndPoint =
      '${baseUrl}api/booking_disposal_update';

  /// Calender EndPoints
  static var calenderBookingDetailEndPoint =
      '${baseUrl}api/calendar_booking_details';

  /// Terms EndPoints
  static var termsConditionEndPoint =
      '${baseUrl}api/fleet_admin_terms_condition_list';
  static var termsPoliciesEndPoint =
      '${baseUrl}api/fleet_admin_terms_policies_list';

  /// Wallet EndPoints
  static var walletBalanceCheckEndPoint = '${baseUrl}api/wallet_balance_check';
  static var walletHistoryEndPoint = '${baseUrl}api/wallet_history';
  static var walletTopUpRequestEndPoint = '${baseUrl}api/wallet_topup_request';

  /// Booking List & Details EndPoints
  static var bookingListEndPoint = '${baseUrl}api/admin_booking_list';
  static var bookingDetailEndPoint = '${baseUrl}api/admin_booking_detail';

  static var bookingStatusUpdateEndPoint =
      '${baseUrl}api/booking_status_update';

  /// Rating EndPoints
  static var ratingUpdateEndPoint = '${baseUrl}api/review_submit';

  /// Faq EndPoints
  static var faqEndPoint = '${baseUrl}api/fleet_admin_faq_list';

  /// Booking Cancel Request EndPoints
  static var bookingCancelRequestEndPoint =
      '${baseUrl}api/booking_cancel_request';

  /// Booking Addition Service Update EndPoints
  static var bookingAdditionServiceUpdateEndPoint =
      '${baseUrl}api/booking_addition_service_update';

  /// Account Delete Request EndPoints
  static var accountDeleteRequestEndPoint =
      '${baseUrl}api/admin_account_delete_request';

  /// Budget API EndPoints
  static var vehicleTypeListEndPoint = '${baseUrl}api/vehicle_types_list';

  /// Vehicle List & Details EndPoints
  static var vehicleListEndPoint = '${baseUrl}api/vehicle_list';
  static var vehicleSubmitEndPoint = '${baseUrl}api/vehicle_submit';
  static var vehicleDetailsEndPoint = '${baseUrl}api/vehicle_details/';

  /// LongPush Type Detail API EndPoints
  static var longPushTypeDetailEndPoint = '${baseUrl}api/longpush_type_detail';

  static var premiumLongPushTypeDetailEndPoint =
      '${baseUrl}api/longpush_type_detail';

  ///  Package Details API EndPoints
  static var budgetPackageDetailEndPoint = '${baseUrl}api/budget_moving_detail';
  static var premiumPackageDetailEndPoint =
      '${baseUrl}api/premium_package_detail';
  static var disposalPackageDetailEndPoint =
      '${baseUrl}api/disposal_package_detail';

  /// Booking Edit Details API EndPoints
  static var budgetBookingEditDetailEndPoint =
      '${baseUrl}api/booking_budget_edit_details';
  static var premiumBookingEditDetailEndPoint =
      '${baseUrl}api/booking_premium_edit_details';
  static var disposalBookingEditDetailEndPoint =
      '${baseUrl}api/booking_disposal_edit_details';

  /// Google Map Api EndPoints
  /// Autocomplete Place API EndPoints
  static var autoCompletePlaceEntPoint =
      '${baseGoogleApi}api/place/autocomplete/json';

  /// Place Id To Get Latitude Longitude Api EndPoints
  static var placeIdToLatLangEntPoint =
      '${baseGoogleApi}api/geocode/json'; // place_id=______&key=____

  /// Latitude Longitude To Get Place Api EndPoints
  static var latLangToPlaceEntPoint =
      '${baseGoogleApi}api/geocode/json'; // latlang=12.43,12.45&key=______

  /// Direction Api EndPoints
  static var directionEntPoint =
      '${baseGoogleApi}api/directions/json'; // origin=12.43,12.45&destination=23.43,54.21&key=____
}
