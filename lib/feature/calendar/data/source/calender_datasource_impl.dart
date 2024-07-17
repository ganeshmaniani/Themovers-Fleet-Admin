import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

import '../../../../core/core.dart';
import '../../calendar.dart';

class CalenderDataSourceImpl implements CalenderDataSource {
  final BaseNetworkApi _apiServices;

  const CalenderDataSourceImpl(this._apiServices);

  @override
  Future<Either<Failure, CalenderListModel>> calenderList(
      CalenderEntities calenderEntities) async {
    final userId = SharedPrefs.instance.getInt(AppKeys.userId);
    try {
      Map<String, dynamic> data = {
        'from_date': calenderEntities.fromDate,
        'to_date': calenderEntities.fromDate,
        'user_id': userId,
      };

      Response response = await _apiServices.postApiResponse(
          ApiUrl.calenderBookingDetailEndPoint, data);
      Log.i(response.body.toString());
      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);
        CalenderListModel calenderList =
            CalenderListModel.fromJson(jsonResponse);
        return Right(calenderList);
      } else {
        return const Left(Failure('Api Call Failed'));
      }
    } catch (e) {
      Log.e("Exception", error: e.toString());
      return Left(Failure(e.toString()));
    }
  }
}
