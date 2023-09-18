// ignore_for_file: prefer_final_fields, use_rethrow_when_possible

import 'package:mvvm/data/network/base_api_services.dart';
import 'package:mvvm/data/network/network_api_services.dart';
import 'package:mvvm/resourses/app_urls.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.postApi(AppUrl.loginUrl, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> signUpApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.postApi(AppUrl.registerUrl, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
