{{#uses_in_app_update_feature}}
import 'dart:convert';
{{/uses_in_app_update_feature}}
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as get_x;

import '../utils/app_utils.dart';
import './api_error.dart';
import './api_response.dart';
import './interceptor/auth_interceptor.dart';

class ApiService {
  late Dio _dio;
  {{#uses_in_app_update_feature}}
  late Dio _dioITunes;
  {{/uses_in_app_update_feature}}

  final String _refreshTokenEndpoint; // Refresh token API endpoint
  String? _accessToken;
  String? _refreshToken;
  final Function()? onRefreshTokenExpired; // Callback for expired refresh token

  String? get accessToken => _accessToken;

  ApiService({
    required String baseUrl,
    required String refreshTokenEndpoint,
    this.onRefreshTokenExpired,
    Map<String, String>? defaultHeaders,
    bool enableLogging = false,
  }) : _refreshTokenEndpoint = refreshTokenEndpoint {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: defaultHeaders ?? {},
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    // Add interceptors
    _dio.interceptors.add(
      AuthInterceptor(
        this,
      ),
    );
    if (enableLogging) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          requestHeader: true,
          responseBody: true,
        ),
      );
    }
  }

  {{#uses_in_app_update_feature}}
  ApiService.iTunes({
    required String baseUrl,
    Map<String, String>? defaultHeaders,
    bool enableLogging = false,
  })  : _refreshTokenEndpoint = '',
        onRefreshTokenExpired = null {
    _dioITunes = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: defaultHeaders ?? {},
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    if (enableLogging) {
      _dioITunes.interceptors.add(
        LogInterceptor(
          requestBody: true,
          requestHeader: true,
          responseBody: true,
        ),
      );
    }
  }
  {{/uses_in_app_update_feature}}

  /// Set or Update Tokens
  void setTokens({
    required String accessToken,
    required String refreshToken,
  }) {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
  }

  /// Refresh Access Token
  Future<bool> refreshAccessToken() async {
    bool isRefreshTokenSuccess = false;
    if (AppConfig.isRefreshTokenEnabled) {
      try {
        final response = await _dio.post(_refreshTokenEndpoint, data: {
          'refreshToken': _refreshToken,
        });

        if (response.statusCode == 200) {
          final newAccessToken = response.data['accessToken'];
          final newRefreshToken = response.data['refreshToken'];

          if (newAccessToken != null && newRefreshToken != null) {
            _accessToken = newAccessToken;
            _refreshToken = newRefreshToken;
            isRefreshTokenSuccess = true; // Refresh successful
          }
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    if (!isRefreshTokenSuccess) {
      // Notifying screen in case of refresh token failed / un-authorization
      onRefreshTokenExpired?.call();
    }
    return isRefreshTokenSuccess; // Refresh failed
  }

  /// Retry the original failed request
  Future<Response> retryRequest(
    RequestOptions requestOptions,
  ) async {
    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        'Authorization': 'Bearer $_accessToken',
      },
    );
    return _dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  /// Generic GET Request
  Future<ApiResponse<T>> getRequest<T>(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    required T Function(dynamic data) fromJson, // Model binding
  }) async {
    try {
      if (ConnectivityManager.instance.isNetConnected.isFalse) {
        return ApiResponse(error: ApiError.internetConnectionError());
      }
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParams,
        options: Options(headers: headers),
      );
      return ApiResponse(data: fromJson(response.data));
    } on DioException catch (e) {
      return ApiResponse(error: ApiError.fromDioError(e));
    }
  }

  {{#uses_in_app_update_feature}}
  /// Generic GET iTunes Request
  Future<ApiResponse<T>> getItunesRequest<T>(
      String endpoint, {
        Map<String, dynamic>? queryParams,
        Map<String, String>? headers,
        required T Function(dynamic data) fromJson, // Model binding
      }) async {
    try {
      if (ConnectivityManager.instance.isNetConnected.isFalse) {
        return ApiResponse(error: ApiError.internetConnectionError());
      }
      final response = await _dioITunes.get(
        endpoint,
        queryParameters: queryParams,
        options: Options(headers: headers),
      );
      return ApiResponse(data: fromJson(json.decode(response.data.trim())));
    } on DioException catch (e) {
      return ApiResponse(error: ApiError.fromDioError(e));
    }
  }
  {{/uses_in_app_update_feature}}

  /// Generic POST Request
  Future<ApiResponse<T>> postRequest<T>(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    dynamic body,
    Map<String, String>? headers,
    required T Function(dynamic data) fromJson,
  }) async {
    try {
      if (ConnectivityManager.instance.isNetConnected.isFalse) {
        return ApiResponse(error: ApiError.internetConnectionError());
      }
      final response = await _dio.post(
        endpoint,
        queryParameters: queryParams,
        data: body,
        options: Options(headers: headers),
      );
      return ApiResponse(data: fromJson(response.data));
    } on DioException catch (e) {
      return ApiResponse(error: ApiError.fromDioError(e));
    }
  }

  /// Generic PUT Request
  Future<ApiResponse<T>> putRequest<T>(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    dynamic body,
    Map<String, String>? headers,
    required T Function(dynamic data) fromJson,
  }) async {
    try {
      if (ConnectivityManager.instance.isNetConnected.isFalse) {
        return ApiResponse(error: ApiError.internetConnectionError());
      }
      final response = await _dio.put(
        endpoint,
        queryParameters: queryParams,
        data: body,
        options: Options(headers: headers),
      );
      return ApiResponse(data: fromJson(response.data));
    } on DioException catch (e) {
      return ApiResponse(error: ApiError.fromDioError(e));
    }
  }

  /// Generic DELETE Request
  Future<ApiResponse<T>> deleteRequest<T>(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    required T Function(dynamic data) fromJson,
  }) async {
    try {
      if (ConnectivityManager.instance.isNetConnected.isFalse) {
        return ApiResponse(error: ApiError.internetConnectionError());
      }
      final response = await _dio.delete(
        endpoint,
        queryParameters: queryParams,
        options: Options(headers: headers),
      );
      return ApiResponse(data: fromJson(response.data));
    } on DioException catch (e) {
      return ApiResponse(error: ApiError.fromDioError(e));
    }
  }

  /// Generic Multipart POST Request
  Future<ApiResponse<T>> postFormRequest<T>(
    String endpoint, {
    required Map<String, dynamic> formDataFields,
    List<MultipartFile>? files,
    Map<String, String>? headers,
    required T Function(dynamic data) fromJson,
  }) async {
    try {
      if (ConnectivityManager.instance.isNetConnected.isFalse) {
        return ApiResponse(error: ApiError.internetConnectionError());
      }

      final Map<String, dynamic> formFieldMap = {
        ...formDataFields,
      };

      if (files != null && files.isNotEmpty) {
        formFieldMap['files'] = files;
      }

      final response = await _dio.post(
        endpoint,
        data: FormData.fromMap(formFieldMap),
        options: Options(headers: headers),
      );
      return ApiResponse(data: fromJson(response.data));
    } on DioException catch (e) {
      return ApiResponse(error: ApiError.fromDioError(e));
    }
  }

  /// Generic GET Request
  Future<ApiResponse<List<T>>> getRequestArray<T>(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    required List<T> Function(List<dynamic> json) fromJsonList,
  }) async {
    try {
      if (ConnectivityManager.instance.isNetConnected.isFalse) {
        return ApiResponse(error: ApiError.internetConnectionError());
      }
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParams,
        options: Options(headers: headers),
      );
      return ApiResponse(data: fromJsonList(response.data));
    } on DioException catch (e) {
      return ApiResponse(error: ApiError.fromDioError(e));
    }
  }

  /// Generic POST Request
  Future<ApiResponse<List<T>>> postRequestArray<T>(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    dynamic body,
    Map<String, String>? headers,
    required List<T> Function(List<dynamic> data) fromJsonList,
  }) async {
    try {
      if (ConnectivityManager.instance.isNetConnected.isFalse) {
        return ApiResponse(error: ApiError.internetConnectionError());
      }
      final response = await _dio.post(
        endpoint,
        queryParameters: queryParams,
        data: body,
        options: Options(headers: headers),
      );
      return ApiResponse(data: fromJsonList(response.data));
    } on DioException catch (e) {
      return ApiResponse(error: ApiError.fromDioError(e));
    }
  }

  /// Generic PUT Request
  Future<ApiResponse<List<T>>> putRequestArray<T>(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    dynamic body,
    Map<String, String>? headers,
    required List<T> Function(List<dynamic> data) fromJsonList,
  }) async {
    try {
      if (ConnectivityManager.instance.isNetConnected.isFalse) {
        return ApiResponse(error: ApiError.internetConnectionError());
      }
      final response = await _dio.put(
        endpoint,
        queryParameters: queryParams,
        data: body,
        options: Options(headers: headers),
      );
      return ApiResponse(data: fromJsonList(response.data));
    } on DioException catch (e) {
      return ApiResponse(error: ApiError.fromDioError(e));
    }
  }

  /// Generic DELETE Request
  Future<ApiResponse<List<T>>> deleteRequestArray<T>(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    required List<T> Function(List<dynamic> data) fromJsonList,
  }) async {
    try {
      if (ConnectivityManager.instance.isNetConnected.isFalse) {
        return ApiResponse(error: ApiError.internetConnectionError());
      }
      final response = await _dio.delete(
        endpoint,
        queryParameters: queryParams,
        options: Options(headers: headers),
      );
      return ApiResponse(data: fromJsonList(response.data));
    } on DioException catch (e) {
      return ApiResponse(error: ApiError.fromDioError(e));
    }
  }

  /// Generic Multipart POST Request
  Future<ApiResponse<List<T>>> uploadFileArray<T>(
    String endpoint, {
    required Map<String, dynamic> formDataFields,
    List<MultipartFile>? files,
    Map<String, String>? headers,
    required List<T> Function(List<dynamic> data) fromJsonList,
  }) async {
    try {
      if (ConnectivityManager.instance.isNetConnected.isFalse) {
        return ApiResponse(error: ApiError.internetConnectionError());
      }

      final Map<String, dynamic> formFieldMap = {
        ...formDataFields,
      };

      if (files != null && files.isNotEmpty) {
        formFieldMap['files'] = files;
      }

      final response = await _dio.post(
        endpoint,
        data: FormData.fromMap(formFieldMap),
        options: Options(headers: headers),
      );
      return ApiResponse(data: fromJsonList(response.data));
    } on DioException catch (e) {
      return ApiResponse(error: ApiError.fromDioError(e));
    }
  }
}
