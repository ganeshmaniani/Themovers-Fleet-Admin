import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../core.dart';

class BaseNetworkApiImpl extends BaseNetworkApi {
  @override
  Future<dynamic> getApiResponse(String url) async {
    dynamic response;
    try {
      response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
    } catch (e) {
      Log.e('Exception', error: e.toString());
      // throw FetchDataException('No Internet Connection');
    }
    return response;
  }

  @override
  Future<dynamic> postApiResponse(String url, dynamic data) async {
    dynamic response;
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json"
    };
    try {
      response = await post(
        Uri.parse(url),
        body: json.encode(data),
        headers: headers,
        encoding: Encoding.getByName("utf-8"),
      );
    } catch (e) {
      Log.e('Exception', error: e.toString());
      // throw FetchDataException('No Internet Connection');
    }

    return response;
  }
}
