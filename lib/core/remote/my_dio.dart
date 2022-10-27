import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


myDio({
  required String url,
  required String methodType,
  required String appLanguage, BuildContext? context,
}) async {
  var response;
  bool isSocketException = false;

  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    try {
      if (methodType == 'get') {
        response = await Dio()
            .get(url, options: Options(
              validateStatus: (int? status) => status! >= 200 && status <= 500),
        ).catchError((onError) {
          isSocketException = true;
        });
      }
      print('Response is >>> ' + response.statusCode.toString());
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return responsMap(
            status: response.data['status'],
            message: response.data['message'],
            data: response.data['results']);
      } else if (response.statusCode >= 500) {
        return responsMap(
            status: false, message: serverErrorError(appLanguage));
      }  else if (response.statusCode == 401 || response.statusCode == 302) {

      } else if (response.statusCode >= 400 && response.statusCode <= 499) {
        return responsMap(
            status: false, message: response.data['message'], data: null);
      } else {
        return responsMap(
            status: false, message: globalError(appLanguage), data: null);
      }
    } catch (e) {
      print('global Dio Error' + e.toString());
      return responsMap(
          status: false, message: globalError(appLanguage), data: null);
    }
  }
}

String globalError(String appLanguage) {
  return appLanguage == 'ar'
      ? '! حدث خطأ يرجي التأكد من الانترنت اولا او مراجعه اداره التطبيق'
      : 'An error occurred, please check the internet first or review the application administration !';
}

String serverErrorError(String appLanguage) {
  return appLanguage == 'ar'
      ? 'يوجد مشكلة فى السيرفر برجاء مراجعة إدارة التطبيق'
      : 'There is a problem with the server, please check the application management';
}

Map<dynamic, dynamic> responsMap({bool? status, dynamic? message, dynamic data}) {
  return {"status": status, "message": message.toString(), "data": data};
}
