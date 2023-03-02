import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mal_clone/core/di.dart';
import 'package:mal_clone/core/error/custom_error.dart';

part 'api_response.freezed.dart';

abstract class ApiResponse<T> {
  static ApiResponse<T> parseDioError<T>({required DioError error}) {
    String message = StatusMessage.unknownError;
    int statusCode = StatusCode.unknownError;

    try {
      switch (error.type) {
        case DioErrorType.response:
          message = error.response?.data["message"] ?? StatusMessage.unknownError;
          statusCode = error.response?.statusCode ?? StatusCode.unknownError;
          break;
        case DioErrorType.connectTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.sendTimeout:
          message = StatusMessage.timeout;
          statusCode = StatusCode.timeout;
          break;
        case DioErrorType.cancel:
          final lvError = error.response?.data as CustomError?;
          message = lvError?.message ?? StatusMessage.unknownError;
          statusCode = lvError?.statusCode ?? StatusCode.unknownError;
          break;
        default:
          message = error.error is SocketException ? StatusMessage.socketError : StatusMessage.unknownError;
          statusCode = StatusCode.unknownError;
          break;
      }
    } catch (e) {
      statusCode = StatusCode.somethingWentWrong;
      message = StatusMessage.somethingWentWrong;
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
