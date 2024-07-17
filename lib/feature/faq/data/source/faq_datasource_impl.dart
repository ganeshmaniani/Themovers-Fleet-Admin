import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

import '../../../../core/core.dart';
import '../../faq.dart';

class FaqDataSourceImpl implements FaqDataSource {
  final BaseNetworkApi _apiServices;

  const FaqDataSourceImpl(this._apiServices);

  @override
  Future<Either<Failure, FAQListModel>> faqList() async {
    try {
      Response response = await _apiServices.getApiResponse(ApiUrl.faqEndPoint);
      Log.i(response.body.toString());
      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);
        FAQListModel faqList = FAQListModel.fromJson(jsonResponse);
        return Right(faqList);
      } else {
        return const Left(Failure('Api Call Failed'));
      }
    } catch (e) {
      Log.e("Exception", error: e.toString());
      return const Left(Failure('Api Call Failed'));
    }
  }

  @override
  Future<Either<Failure, TermsConditionModel>> termAndCondition() async {
    try {
      Response response =
          await _apiServices.getApiResponse(ApiUrl.termsConditionEndPoint);
      Log.i(response.body.toString());
      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);
        TermsConditionModel termsCondition =
            TermsConditionModel.fromJson(jsonResponse);
        return Right(termsCondition);
      } else {
        return const Left(Failure('Api Call Failed'));
      }
    } catch (e) {
      Log.e("Exception", error: e.toString());
      return const Left(Failure('Api Call Failed'));
    }
  }

  @override
  Future<Either<Failure, TermsPoliciesModel>> termAndPolicy() async {
    try {
      Response response =
          await _apiServices.getApiResponse(ApiUrl.termsPoliciesEndPoint);
      Log.i(response.body.toString());
      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);
        TermsPoliciesModel termsPolicies =
            TermsPoliciesModel.fromJson(jsonResponse);
        return Right(termsPolicies);
      } else {
        return const Left(Failure('Api Call Failed'));
      }
    } catch (e) {
      Log.e("Exception", error: e.toString());
      return const Left(Failure('Api Call Failed'));
    }
  }
}
