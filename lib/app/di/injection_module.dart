import 'package:tracking/app/routes/router.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String applicationJson = "application/json";
const String contentType = "content-type";
const String accept = "accept";
const String authorization = "Authorization";
const String language = "accept-language";

@module
abstract class InjectableModule {

  @preResolve
  @lazySingleton
  Future<SharedPreferences> get sharedPref => SharedPreferences.getInstance();

  @lazySingleton
  Dio get dioInstance {
    Dio dio = Dio();
    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
    };
    dio.options = BaseOptions(
      headers: headers,
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      connectTimeout: const Duration(seconds: 30),
    );

    if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
    return dio;
  }

  @lazySingleton
  AppRouter get router => AppRouter();
}
