import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../localizations/language_keys.dart';
import './responses/api_error_response.dart';

/// Error Model
class ApiError {
  final String message;
  final int? statusCode;

  ApiError({
    required this.message,
    this.statusCode,
  });

  factory ApiError.fromDioError(DioException e) {
    try {
      return ApiError(
        message: ApiErrorResponse.fromJson(e.response?.data).message ??
            e.response?.data.toString() ??
            e.message ??
            'Unknown error',
        statusCode: e.response?.statusCode,
      );
    } catch (ex) {
      return ApiError(
        message: ex.toString(),
        statusCode: 0,
      );
    }
  }

  factory ApiError.internetConnectionError() {
    return ApiError(
      message: LanguageKey.noInternetConnection.tr,
      statusCode: 0,
    );
  }
}
