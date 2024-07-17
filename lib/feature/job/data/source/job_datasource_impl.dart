import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

import '../../../../core/core.dart';
import '../../../feature.dart';

class JobDataSourceImpl implements JobDataSource {
  final BaseNetworkApi _apiServices;

  const JobDataSourceImpl(this._apiServices);

  @override
  Future<Either<Failure, JobDetailModel>> jobDetail(String bookingId) async {
    try {
      Response response = await _apiServices
          .getApiResponse("${ApiUrl.bookingDetailEndPoint}?id=$bookingId");
      Log.i(response.body.toString());
      if (response.statusCode == 200) {
        dynamic res = json.decode(response.body);
        JobDetailModel jobDetail = JobDetailModel.fromJson(res);
        return Right(jobDetail);
      } else {
        return const Left(Failure('Api Call Failed'));
      }
    } catch (e) {
      Log.e("Exception", error: e.toString());
      return const Left(Failure('Api Call Failed'));
    }
  }

  @override
  Future<Either<Failure, JobListModel>> jobList(String stageId) async {
    final userId = SharedPrefs.instance.getInt(AppKeys.userId);
    try {
      Response response = await _apiServices.getApiResponse(
          "${ApiUrl.bookingListEndPoint}?user_id=$userId&booking_status=$stageId");
      log('user_id ${userId}');
      log('booking_status ${stageId}');
      log('JobList ${response.body}');
      if (response.statusCode == 200) {
        dynamic res = json.decode(response.body);
        JobListModel jobList = JobListModel.fromJson(res);
        log('JsonResponse${res.toString()}');
        return Right(jobList);
      } else {
        return const Left(Failure('Api Call Failed'));
      }
    } catch (e) {
      Log.e("Exception", error: e.toString());
      return const Left(Failure('Api Call Failed'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> jobUpdate(
      JobStageUpdateEntities jobStageUpdateEntities) async {
    final userId = SharedPrefs.instance.getInt(AppKeys.userId);
    try {
      Map<String, dynamic> data = {
        'user_id': userId,
        'booking_id': jobStageUpdateEntities.bookingId,
        'booking_status': jobStageUpdateEntities.stageId,
      };

      Log.w(data.toString());

      Response response = await _apiServices.postApiResponse(
          ApiUrl.bookingStatusUpdateEndPoint, data);
      Log.i(response.body.toString());

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse["Api_success"].toString() == "true") {
          return const Right('true');
        } else {
          return Left(Failure(jsonResponse["message"]));
        }
      } else {
        return const Left(Failure('Got a slow connection ?'));
      }
    } catch (e) {
      Log.e("Exception", error: e.toString());
      return Left(Failure('No Internet Connection'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> jobCompleteStageUpdate(
      JobStageUpdateEntities jobStageUpdateEntities) async {
    try {
      final userId = SharedPrefs.instance.getInt(AppKeys.userId);
      Map<String, dynamic> data = {
        'user_id': userId,
        'booking_id': jobStageUpdateEntities.bookingId,
        'booking_status': jobStageUpdateEntities.stageId,
        'payment_mode': '1',
      };

      Response response = await _apiServices.postApiResponse(
          ApiUrl.bookingStatusUpdateEndPoint, data);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse["Api_success"].toString() == "true") {
          return const Right('true');
        } else {
          return Left(Failure(jsonResponse["message"]));
        }
      } else {
        return const Left(Failure('No Internet Connection'));
      }
    } catch (e) {
      Log.e("Exception", error: e.toString());
      return const Left(Failure('No Internet Connection'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> updateRating(
      RatingEntities ratingEntities) async {
    try {
      Map<String, dynamic> data = {
        'user_id': ratingEntities.userId,
        'booking_id': ratingEntities.bookingId,
        'ratings': ratingEntities.ratings,
        'feedback': ratingEntities.feedback,
      };
      Log.d(data.toString());
      Response response =
          await _apiServices.postApiResponse(ApiUrl.ratingUpdateEndPoint, data);
      Log.w(response.body.toString());
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['Api_success'].toString() == "true") {
          return const Right('true');
        } else {
          return Left(Failure(jsonResponse['Api_message']));
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
  Future<Either<Failure, BudgetBookingModel>> budgetBookingDetail(
      String bookingId) async {
    try {
      Response response = await _apiServices.getApiResponse(
          "${ApiUrl.budgetBookingEditDetailEndPoint}?id=$bookingId");
      Log.f("Response", error: response.body.toString());
      if (response.statusCode == 200) {
        dynamic res = json.decode(response.body);

        BudgetBookingModel budgetBookingDetail =
            BudgetBookingModel.fromJson(res);

        return Right(budgetBookingDetail);
      } else {
        return const Left(Failure('Api Call Failed'));
      }
    } catch (e) {
      Log.e("Exception", error: e.toString());
      return const Left(Failure('Api Call Failed'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> budgetBookingUpdate(
      BudgetEntities budgetEntities) async {
    Map<String, dynamic> data = {
      'id': budgetEntities.bookingId,
      'user_id': budgetEntities.userId,
      'booking_date_time': budgetEntities.bookingDate,
      'customer_id': budgetEntities.customerId,
      'service_type': budgetEntities.serviceType,
      'amount': budgetEntities.amount,
      'manpower_count': budgetEntities.manpowerCount,
      'box_count': budgetEntities.boxCount,
      'vehicle_type': budgetEntities.vehicleType,
      'wrapping': budgetEntities.wardrobeCount,
      'bubble': budgetEntities.bubbleWrappingCount,
      'bed_count': budgetEntities.bedsCount,
      'table_count': budgetEntities.tableCount,
      'wardrobe_count': budgetEntities.wardrobeCount,
      'stair_carry_count': budgetEntities.stairCarrCount,
      'longpush_type': budgetEntities.longPushType,
      'tail_gate': budgetEntities.tailGateEnabled,
      'dining_table_count': budgetEntities.diningTableCount,
      'vehicle_amount': budgetEntities.vehicleAmount,
      'manpower_amount': budgetEntities.manpowerAmount,
      'box_amount': budgetEntities.boxAmount,
      'shrink_wrap_amount': budgetEntities.shrinkWrapAmount,
      'bubble_wrap_amount': budgetEntities.bubbleWrapAmount,
      'dining_amount': budgetEntities.diningAmount,
      'table_amount': budgetEntities.tableAmount,
      'bed_amount': budgetEntities.bedAmount,
      'wardrobe_amount': budgetEntities.wardrobeAmount,
      'stair_amount': budgetEntities.stairAmount,
      'longpush_amount': budgetEntities.longPushAmount,
      'tailgate_amount': budgetEntities.tailgateAmount,
      'total_amount': budgetEntities.totalAmount,
    };
    Log.d(data.toString());
    try {
      Response response = await _apiServices.postApiResponse(
          ApiUrl.budgetBookingUpdateEndPoint, data);
      Log.f("Response", error: response.body.toString());
      if (response.statusCode == 200) {
        // final jsonResponse = json.decode(response.body);
        return const Right('true');
      } else {
        return const Left(Failure('Api Call Failed'));
      }
    } catch (e) {
      Log.e("Exception", error: e.toString());
      return const Left(Failure('Api Call Failed'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> disposalBookingUpdate(
      DisposalEntities disposalEntities) async {
    Map<String, dynamic> data = {
      'user_id': disposalEntities.userId,
      'customer_id': disposalEntities.customerId,
      'booking_date_time': disposalEntities.bookingDate,
      'id': disposalEntities.bookingId,
      'service_type': disposalEntities.serviceType,
      'vehicle_type': disposalEntities.vehicleType,
      'amount': disposalEntities.amount,
      'total_amount': disposalEntities.totalAmount,
    };
    Log.d(data.toString());
    try {
      Response response = await _apiServices.postApiResponse(
          ApiUrl.disposalBookingUpdateEndPoint, data);
      Log.f("Response", error: response.body.toString());

      if (response.statusCode == 200) {
        return const Right('true');
      } else {
        return const Left(Failure('Api Call Failed'));
      }
    } catch (e) {
      Log.e("Exception", error: e.toString());
      return const Left(Failure('Api Call Failed'));
    }
  }

  @override
  Future<Either<Failure, DisposalBookingModel>> disposalBookingDetail(
      String bookingId) async {
    try {
      Response response = await _apiServices.getApiResponse(
          "${ApiUrl.disposalBookingEditDetailEndPoint}?id=$bookingId");
      Log.f("Response", error: response.body.toString());
      if (response.statusCode == 200) {
        dynamic res = json.decode(response.body);
        DisposalBookingModel disposalBookingDetail =
            DisposalBookingModel.fromJson(res);
        return Right(disposalBookingDetail);
      } else {
        return const Left(Failure('Api Calling Failed'));
      }
    } catch (e) {
      Log.e("Exception", error: e.toString());
      return const Left(Failure('Api Call Failed'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> premiumBookingUpdate(
      PremiumEntities premiumEntities) async {
    Map<String, dynamic> data = {
      'id': premiumEntities.bookingId,
      'user_id': premiumEntities.userId,
      'booking_date_time': premiumEntities.bookingDate,
      'customer_id': premiumEntities.customerId,
      'service_type': premiumEntities.serviceType,
      'amount': premiumEntities.amount,
      'stair_carry_count': premiumEntities.stairCarryCount,
      'vehicle_type': premiumEntities.vehicleType,
      'longpush_type': premiumEntities.longPushType,
      'tail_gate': premiumEntities.tailGate,
      'vehicle_amount': premiumEntities.vehicleAmount,
      'stair_amount': premiumEntities.stairCarryAmount,
      'longpush_amount': premiumEntities.longPushAmount,
      'tailgate_amount': premiumEntities.tailgateAmount,
      'total_amount': premiumEntities.totalAmount,
    };
    Log.d(data.toString());
    try {
      Response response = await _apiServices.postApiResponse(
          ApiUrl.premiumBookingUpdateEndPoint, data);
      Log.f("Response", error: response.body.toString());
      if (response.statusCode == 200) {
        // final jsonResponse = json.decode(response.body);

        return const Right('true');
      } else {
        return const Left(Failure('Api Call Failed'));
      }
    } catch (e) {
      Log.e("Exception", error: e.toString());
      return const Left(Failure('Api Call Failed'));
    }
  }

  @override
  Future<Either<Failure, PremiumBookingModel>> premiumBookingDetail(
      String bookingId) async {
    try {
      Response response = await _apiServices.getApiResponse(
          "${ApiUrl.premiumBookingEditDetailEndPoint}?id=$bookingId");

      if (response.statusCode == 200) {
        dynamic res = json.decode(response.body);

        PremiumBookingModel premiumBookingDetail =
            PremiumBookingModel.fromJson(res);
        return Right(premiumBookingDetail);
      } else {
        return const Left(Failure('Api Call Failed'));
      }
    } catch (e) {
      Log.e("Exception", error: e.toString());
      return const Left(Failure('Api Call Failed'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> jobDeleteRequest(
      JobDeleteEntities jobDeleteEntities) async {
    try {
      Map<String, dynamic> data = {
        'user_id': jobDeleteEntities.userId,
        'booking_id': jobDeleteEntities.bookingId,
        'description': jobDeleteEntities.description,
      };

      Response response = await _apiServices.postApiResponse(
          ApiUrl.bookingCancelRequestEndPoint, data);

      if (response.statusCode == 200) {
        // dynamic res = json.decode(response.body);

        return const Right(true);
      } else {
        return const Left(Failure('Api Call Failed'));
      }
    } catch (e) {
      Log.e("Exception", error: e.toString());
      return const Left(Failure('Api Call Failed'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> additionalServiceUpdate(
      AdditionalServiceEntities additionalServiceEntities) async {
    try {
      final userId = SharedPrefs.instance.getInt(AppKeys.userId);

      Map<String, dynamic> data = {
        'user_id': userId,
        'booking_id': additionalServiceEntities.bookingId,
        'additional_amount': additionalServiceEntities.addOnAmount,
        'additional_service': additionalServiceEntities.service,
        'description': additionalServiceEntities.description,
      };
      Log.d(data.toString());

      Response response = await _apiServices.postApiResponse(
          ApiUrl.bookingAdditionServiceUpdateEndPoint, data);

      Log.f("Response", error: response.body.toString());
      if (response.statusCode == 200) {
        // dynamic res = json.decode(response.body);

        return const Right(true);
      } else {
        return const Left(Failure('Api Call Failed'));
      }
    } catch (e) {
      Log.e("Exception", error: e.toString());
      return const Left(Failure('Api Call Failed'));
    }
  }
}
