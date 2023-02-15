import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mal_clone/core/di.dart';
import 'package:mal_clone/core/error/custom_error.dart';

part 'api_response.freezed.dart';

abstract class ApiResponse<T> {
  static ApiResponse<T> parseDioError<T>({required DioError error}) {
    String message = "";
    int statusCode = -1;

    try {
      switch (error.type) {
        case DioErrorType.response:
          message = error.response?.data["message"] ?? "Unknown Error";
          statusCode = error.response?.statusCode ?? -1;
          break;
        case DioErrorType.connectTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.sendTimeout:
          message = "Request timeout";
          statusCode = 408;
          break;
        default:
          message = error.error is SocketException ? "No Internet Connection" : "Unknown Error!";
          statusCode = -1;
          break;
      }
    } catch (e) {
      statusCode = -1;
      message = "Something went wrong";
      logger.e(">> Dio Catch Error: $e");
    }

    return ApiErrorResponse<T>(
      statusCode: statusCode,
      message: message,
    );
  }
}

@Freezed(genericArgumentFactories: true)
class ApiErrorResponse<T> extends ApiResponse<T> with _$ApiErrorResponse<T> {
  ApiErrorResponse._();

  factory ApiErrorResponse({
    @Default(-1) int statusCode,
    required String message,
  }) = _ApiErrorResponse;

  CustomError get toCustomError {
    return CustomError(
      statusCode: statusCode,
      message: message,
    );
  }
}

@Freezed(genericArgumentFactories: true)
class ApiSuccessResponse<T> extends ApiResponse<T> with _$ApiSuccessResponse<T> {
  factory ApiSuccessResponse({
    required T data,
  }) = _ApiSuccessResponse;
}
