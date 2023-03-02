import 'package:dio/dio.dart';
import 'package:mal_clone/core/config/constant.dart';
import 'package:mal_clone/core/di.dart';
import 'package:mal_clone/core/error/custom_error.dart';
import 'package:mal_clone/core/misc.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

var options = BaseOptions(
  baseUrl: AppConstant.baseUrl,
  connectTimeout: 60000,
  receiveTimeout: 60000,
);
Dio dio = Dio(options)
  ..interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true, responseBody: false, responseHeader: false, error: true, compact: true, maxWidth: 150))
  ..interceptors.add(InterceptorsWrapper(
    onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      final isRequestAuth = options.extra[requiredAuthenticationKey] ?? false;
      const String? token = null;

      if (isRequestAuth && token == null) {
        final response = Response(
          requestOptions: options,
          statusCode: CustomError.unauthenticated.statusCode,
          statusMessage: CustomError.unauthenticated.message,
          data: CustomError.unauthenticated,
        );

        return handler.reject(
          DioError(
            requestOptions: options,
            response: response,
            type: DioErrorType.cancel,
            error: CustomError.unauthenticated,
          ),
          true,
        );
      }

      options.headers["Accept-Language"] = "english";
      options.headers["token"] = token;
      options.responseType = ResponseType.json;

      return handler.next(options);
    },
    onError: (DioError error, ErrorInterceptorHandler handler) {
      logger.e(error);

      return handler.next(error);
    },
  ));
