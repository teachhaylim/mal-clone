import 'package:dio/dio.dart';
import 'package:mal_clone/core/config/constant.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

var options = BaseOptions(
  baseUrl: AppConstant.baseUrl,
  connectTimeout: 60000,
  receiveTimeout: 60000,
);
Dio dio = Dio(options)
  ..interceptors.add(
    PrettyDioLogger(requestHeader: true, requestBody: true, responseBody: true, responseHeader: false, error: true, compact: true, maxWidth: 90),
  );
