import 'package:dio/dio.dart';
import 'package:mal_clone/core/config/constant.dart';
import 'package:mal_clone/core/network/custom_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

var options = BaseOptions(
  baseUrl: AppConstant.baseUrl,
  connectTimeout: 20000,
  receiveTimeout: 20000,
);
Dio dio = Dio(options)
  ..interceptors.add(PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    error: true,
    compact: true,
    maxWidth: 150,
  ))
  ..interceptors.add(CustomInterceptor());
