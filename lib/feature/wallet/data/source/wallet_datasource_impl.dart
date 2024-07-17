import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

import '../../../../core/core.dart';
import '../../wallet.dart';

class WalletDataSourceImpl implements WalletDataSource {
  final BaseNetworkApi _apiServices;

  const WalletDataSourceImpl(this._apiServices);

  @override
  Future<Either<Failure, String>> checkWalletAmount() async {
    final userId = SharedPrefs.instance.getInt(AppKeys.userId);
    try {
      Map<String, dynamic> data = {'user_id': userId};
      Response response = await _apiServices.postApiResponse(
          ApiUrl.walletBalanceCheckEndPoint, data);
      Log.w(response.body.toString());
      if (response.statusCode == 200) {
        dynamic res = json.decode(response.body);
        return Right(res["wallet_balance"]);
      } else {
        return const Left(Failure("Api Call Failed"));
      }
    } catch (e) {
      Log.e("Exception", error: e.toString());
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, WalletHistoryModel>> getWalletHistory() async {
    final userId = SharedPrefs.instance.getInt(AppKeys.userId);
    try {
      Map<String, dynamic> data = {'user_id': userId};
      Response response = await _apiServices.postApiResponse(
          ApiUrl.walletHistoryEndPoint, data);
      Log.w(response.body.toString());
      if (response.statusCode == 200) {
        dynamic res = json.decode(response.body);

        WalletHistoryModel walletHistory = WalletHistoryModel.fromJson(res);
        return Right(walletHistory);
      } else {
        return const Left(Failure("Api Call Failed"));
      }
    } catch (e) {
      Log.e("Exception", error: e.toString());
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, WalletResult>> topUpRequest(
      WalletTopUpEntities walletTopUpEntities) async {
    final userId = SharedPrefs.instance.getInt(AppKeys.userId);
    try {
      Map<String, dynamic> data = {
        'user_id': userId,
        'payment_mode': walletTopUpEntities.paymentMode,
        'amount': walletTopUpEntities.amount,
        'payment_attachment': base64
            .encode(walletTopUpEntities.paymentAttachment.readAsBytesSync()),
      };

      Response response = await _apiServices.postApiResponse(
          ApiUrl.walletTopUpRequestEndPoint, data);
      Log.w(response.body.toString());
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['Api_success'].toString() == "true") {
          return const Right(WalletResult.success);
        } else {
          return Left(Failure(jsonResponse['Api_message']));
        }
      } else {
        return const Left(Failure("Api Call Failed"));
      }
    } catch (e) {
      Log.e("Exception", error: e.toString());
      return Left(Failure(e.toString()));
    }
  }
}
