import 'dart:convert';
import 'dart:developer';
import 'dart:io' show Platform;

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/core.dart';
import '../../auth.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final BaseNetworkApi _apiServices;

  AuthDataSourceImpl(this._apiServices);

  @override
  Future<Either<Failure, String>> forgetPasswordEmailChecker(
      String email) async {
    try {
      Map<String, dynamic> data = {'email_id': email};
      Response response = await _apiServices.postApiResponse(
          ApiUrl.mobileNumberCheckerEndPoint, data);
      Log.w(response.body.toString());
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['Api_success'].toString() == "true") {
          return Right(jsonResponse['Api_success'].toString());
        } else {
          return Left(Failure(jsonResponse['Api_message'].toString()));
        }
      } else {
        return Left(
            Failure(json.decode(response.body)['Api_message'].toString()));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResult>> forgetPassword(
      ForgetPasswordEntities forgetPasswordEntities) async {
    try {
      Map<String, dynamic> data = {
        'email': forgetPasswordEntities.email,
        'confirm_password': forgetPasswordEntities.password
      };
      Log.d(data.toString());

      Response response = await _apiServices.postApiResponse(
          ApiUrl.confirmPasswordUpdateEndPoint, data);
      Log.w(response.body.toString());
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['Api_success'].toString() == "true") {
          return const Right(AuthResult.success);
        } else {
          return Left(Failure(jsonResponse['message'].toString()));
        }
      } else {
        return Left(Failure(json.decode(response.body)['message'].toString()));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> forgetPasswordMobileNumberChecker(
      String phone) async {
    try {
      Map<String, dynamic> data = {'mobile_number': phone};
      Response response = await _apiServices.postApiResponse(
          ApiUrl.mobileNumberCheckerEndPoint, data);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['Api_success'].toString() == "true") {
          return const Right('true');
        } else {
          return Left(Failure(jsonResponse['message'].toString()));
        }
      } else {
        return Left(Failure(json.decode(response.body)['message'].toString()));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResult>> phoneNoChecker(String phone) async {
    // TODO: implement phoneNoChecker
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthResult>> register(
      RegisterEntities registerEntities) async {
    try {
      Map<String, dynamic> data = {
        'name': registerEntities.name,
        'email': registerEntities.email,
        'mobile_number': registerEntities.number,
        'password': registerEntities.password
      };
      Log.d(data.toString());

      Response response =
          await _apiServices.postApiResponse(ApiUrl.registrationEndPoint, data);

      Log.i(response.body.toString());

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['Api_success'].toString() == "true") {
          return const Right(AuthResult.success);
        } else {
          return Left(Failure(jsonResponse['message'].toString()));
        }
      } else {
        final jsonResponse = json.decode(response.body);
        return Left(Failure(jsonResponse['message'].toString()));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResult>> signIn(
      LoginEntities loginEntities) async {
    try {
      Map data = {
        'user': loginEntities.userId,
        'password': loginEntities.password,
      };
      Log.d(data.toString());
      Response response =
          await _apiServices.postApiResponse(ApiUrl.loginEndPoint, data);
      Log.w(response.body.toString());

      if (response.statusCode == 200) {
        final jsonDecodeResponse = json.decode(response.body);
        Log.i(jsonDecodeResponse.toString());
        if (jsonDecodeResponse['api_success'].toString() == 'false') {
          return Left(Failure(jsonDecodeResponse['api_message'].toString()));
        } else {
          final AdminDetail adminDetail =
              AdminDetail.fromJson(jsonDecodeResponse);
          final Admin admin = adminDetail.admin!;

          SharedPrefs.instance.setInt(AppKeys.userId, admin.id ?? 0);
          SharedPrefs.instance.setString(AppKeys.name, admin.name ?? '');
          SharedPrefs.instance.setString(AppKeys.email, admin.email ?? '');
          SharedPrefs.instance
              .setString(AppKeys.number, admin.mobileNumber ?? '');

          sendFirebaseDeviceToken(admin.id);
          sendApplicationName();

          Log.i(AuthResult.success.toString());
          return const Right(AuthResult.success);
        }
      } else {
        return const Left(Failure('Please enter your valid credential'));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResult>> emailOtpChecker(
      EmailOtpEntities emailOtpEntities) async {
    try {
      Map<String, dynamic> data = {
        'email_id': emailOtpEntities.email,
        'otp': emailOtpEntities.otp,
      };
      Log.d(data.toString());

      Response response = await _apiServices.postApiResponse(
          ApiUrl.emailEmailOtpCheckingEndPoint, data);
      Log.f('Otp Response', error: response.body.toString());
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['Api_success'].toString() == "true") {
          return const Right(AuthResult.success);
        } else {
          return Left(Failure(jsonResponse['message'].toString()));
        }
      } else {
        return Left(Failure(json.decode(response.body)['message'].toString()));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResult>> emailOtpGenerator(String email) async {
    try {
      Map<String, dynamic> data = {'email_id': email};
      Log.d(data.toString());

      Response response =
          await _apiServices.postApiResponse(ApiUrl.sendEmailOtpEndPoint, data);
      Log.w(response.body.toString());
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['Api_success'].toString() == "true") {
          return const Right(AuthResult.success);
        } else {
          return Left(Failure(jsonResponse['message'].toString()));
        }
      } else {
        return Left(Failure(json.decode(response.body)['message'].toString()));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  void sendApplicationName() async {
    try {
      var platform = '';
      if (Platform.isAndroid) {
        platform = "Android";
      } else if (Platform.isIOS) {
        platform = "IOS";
      } else {
        platform = "";
      }

      Map<String, dynamic> data = {
        'platform': platform,
        'app_name': "FleetAdmin",
      };
      log(data.toString());

      Response response =
          await _apiServices.postApiResponse(ApiUrl.versionCodeEndPoint, data);
      log("Response ${response.body}");
      if (response.statusCode == 200) {}
    } catch (e) {
      Log.e("Exception", error: e.toString());
    }
  }

  void sendFirebaseDeviceToken(int? id) async {
    try {
      var platform = '';
      if (Platform.isAndroid) {
        platform = "Android";
      } else if (Platform.isIOS) {
        platform = "IOS";
      } else {
        platform = "";
      }
      final deviceToken = SharedPrefs.instance.getString(AppKeys.deviceToken);
      final packageInfo = await PackageInfo.fromPlatform();

      Map<String, dynamic> data = {
        'id': id,
        'device_id': deviceToken,
        'platform': platform,
        'app_version': packageInfo.version
      };
      log(data.toString());

      Response response = await _apiServices.postApiResponse(
          ApiUrl.storeFirebaseDeviceIdEndPoint, data);
      log("Response ${response.body}");
      if (response.statusCode == 200) {
        log("Send Device Token");
      }
    } catch (e) {
      Log.e("Exception", error: e.toString());
    }
  }
}
