import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

import '../../../../core/core.dart';
import '../../account.dart';

class AccountDataSourceImpl implements AccountDataSource {
  final BaseNetworkApi _apiServices;

  AccountDataSourceImpl(this._apiServices);

  @override
  Future<Either<Failure, dynamic>> accountDeleteRequest() async {
    final userId = SharedPrefs.instance.getInt(AppKeys.userId);
    Map<String, dynamic> data = {'user_id': userId};

    try {
      Response response = await _apiServices.postApiResponse(
          ApiUrl.accountDeleteRequestEndPoint, data);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['Api_success'].toString() == "true") {
          return Right(jsonResponse['Api_message'].toString());
        } else {
          return Left(Failure(jsonResponse['Api_message'].toString()));
        }
      } else {
        return const Left(Failure('Api Call Failed'));
      }
    } catch (e) {
      Log.e("Exception", error: e.toString());
      return const Left(Failure('Api Call Failed'));
    }
  }

  @override
  Future<Either<Failure, UserDetailModel>> userDetail() async {
    final userId = SharedPrefs.instance.getInt(AppKeys.userId);
    try {
      Response response = await _apiServices
          .getApiResponse("${ApiUrl.userDetailEndPoint}?id=$userId");

      Log.f("User Detail Response", error: response.body.toString());
      if (response.statusCode == 200) {
        dynamic res = json.decode(response.body);
        UserDetailModel userDetail = UserDetailModel.fromJson(res);
        return Right(userDetail);
      } else {
        return const Left(Failure('Api Call Failed'));
      }
    } catch (e) {
      Log.e("Exception", error: e.toString());
      return const Left(Failure('Api Call Failed'));
    }
  }

  @override
  Future<Either<Failure, AdminAccountResult>> userEdit(
      AccountEditEntities accountEditEntities) async {
    final userId = SharedPrefs.instance.getInt(AppKeys.userId);
    Map<String, dynamic> data = {
      'id': userId,
      'name': accountEditEntities.name,
      'email': accountEditEntities.email,
      'company_name': accountEditEntities.companyName,
      'mobile_number': accountEditEntities.mobileNumber,
      'business_ssm_registration': accountEditEntities.businessSsmRegistration,
      'nric': accountEditEntities.nric,
      'license': accountEditEntities.license,
      'grant': accountEditEntities.grant,
    };
    // Log.f("Data", error: data.toString());
    try {
      Response response =
          await _apiServices.postApiResponse(ApiUrl.userUpdateEndPoint, data);
      // Log.f("User Account Update Response", error: response.body.toString());
      if (response.statusCode == 200) {
        return const Right(AdminAccountResult.success);
      } else {
        return const Left(Failure('Api Call Failed'));
      }
    } catch (e) {
      Log.e("Exception", error: e.toString());
      return const Left(Failure('Api Call Failed'));
    }
  }

  @override
  Future<Either<Failure, AdminAccountResult>> userProfile(File file) async {
    final userId = SharedPrefs.instance.getInt(AppKeys.userId);
    Map<String, dynamic> data = {
      'user_id': userId,
      'profile_image': base64.encode(file.readAsBytesSync()),
    };

    try {
      Response response = await _apiServices.postApiResponse(
          ApiUrl.profileUploadEndPoint, data);

      if (response.statusCode == 200) {
        return const Right(AdminAccountResult.success);
      } else {
        return const Left(Failure('Api Call Failed'));
      }
    } catch (e) {
      Log.e("Exception", error: e.toString());
      return const Left(Failure('Api Call Failed'));
    }
  }
}
