import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mal_clone/core/di.dart';
import 'package:mal_clone/core/error/custom_error.dart';

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

class ApiErrorResponse<T> extends ApiResponse<T> {
  final int statusCode;
  final String message;

  ApiErrorResponse({required this.message, this.statusCode = -1});

  CustomError get toCustomError {
    return CustomError(
      statusCode: statusCode,
      message: message,
    );
  }
}

class ApiSuccessResponse<T> extends ApiResponse<T> {
  final T data;

  ApiSuccessResponse({required this.data});
}
