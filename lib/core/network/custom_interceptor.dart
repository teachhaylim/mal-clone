import 'package:dio/dio.dart';
import 'package:mal_clone/core/di.dart';
import 'package:mal_clone/core/error/custom_error.dart';
import 'package:mal_clone/core/misc.dart';

class CustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final isRequestAuth = options.extra[REQUIRED_AUTH_KEY] ?? false;
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

    // NOTE: Add custom header here
    // options.headers["Accept-Language"] = "english";
    // options.headers["token"] = token;
    options.responseType = ResponseType.json;

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // NOTE: Add custom intercept here
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    logger.e(err);
    super.onError(err, handler);
  }
}
