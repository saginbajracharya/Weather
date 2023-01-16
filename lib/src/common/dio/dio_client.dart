import 'package:dio/dio.dart';
import 'package:weather/src/common/dio/dio_login_interceptor.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: 'https://api.openweathermap.org/data/2.5/',
    headers: <String, String>{
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
    receiveDataWhenStatusError: true,
    // connectTimeout: 100 * 1000, // 60 seconds
    // receiveTimeout: 100 * 1000),
  ),
)..interceptors.add(Logging());