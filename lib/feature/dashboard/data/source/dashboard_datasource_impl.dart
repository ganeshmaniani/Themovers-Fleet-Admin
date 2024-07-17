import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

import '../../../../core/core.dart';
import '../../dashboard.dart';

class DashboardDataSourceImpl implements DashboardDataSource {
  final BaseNetworkApi _apiServices;

  DashboardDataSourceImpl(this._apiServices);

  @override
  Future<Either<Failure, AccountResult>> checkUserAccountActivation() async {
    try {
      final userId = SharedPrefs.instance.getInt(AppKeys.userId);
      Map<String, dynamic> data = {'user_id': userId.toString()};
      Response response = await _apiServices.postApiResponse(
          ApiUrl.checkUserActivationEndPoint, data);

      if (response.statusCode == 200) {
        dynamic res = json.decode(response.body);
        Log.i(res.toString());
        if (res["Api_success"].toString() == "true") {
          return const Right(AccountResult.success);
        } else {
          return Left(Failure(res["api_message"].toString()));
        }
      } else {
        return const Left(Failure('Api Call Failed'));
      }
    } catch (e) {
      Log.e("Exception", error: e.toString());
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, JobStatusModel>> jobStatusDetail() async {
    try {
      final userId = SharedPrefs.instance.getInt(AppKeys.userId);
      Response response = await _apiServices
          .getApiResponse("${ApiUrl.bookingStageListEndPoint}?user_id=$userId");

      if (response.statusCode == 200) {
        dynamic res = json.decode(response.body);
        log(res.toString());
        Log.i(res.toString());
        JobStatusModel jobStatusModel = JobStatusModel.fromJson(res);

        return Right(jobStatusModel);
      } else {
        return const Left(Failure('Api Call Failed'));
      }
    } catch (e) {
      Log.e("Exception", error: e.toString());
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DashboardSliderModel>>
      dashboardCarouselSlider() async {
    try {
      Response response =
          await _apiServices.getApiResponse(ApiUrl.dashboardSliderList);

      if (response.statusCode == 200) {
        dynamic res = json.decode(response.body);
        Log.i(res.toString());
        log(res.toString());
        DashboardSliderModel sliderModel = DashboardSliderModel.fromJson(res);
        return Right(sliderModel);
      } else {
        return const Left(Failure('Api Call Failed'));
      }
    } catch (e) {
      Log.e("Exception", error: e.toString());
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, VersionModel>> getVersionCode() async {
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

      if (response.statusCode == 200) {
        dynamic res = json.decode(response.body);
        Log.i(res.toString());
        log(res.toString());
        VersionModel versionModel = VersionModel.fromJson(res);
        return Right(versionModel);
      } else {
        return const Left(Failure('Api Call Failed'));
      }
    } catch (e) {
      Log.e("Exception", error: e.toString());
      return Left(Failure(e.toString()));
    }
  }
}
