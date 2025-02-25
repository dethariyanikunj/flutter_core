import 'package:dio/dio.dart';

import '../api_services.dart';

class AuthInterceptor extends Interceptor {
  final ApiService _apiService;

  AuthInterceptor(
    this._apiService,
  );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Attach the access token if available
    if (_apiService.accessToken != null) {
      options.headers['Authorization'] = 'Bearer ${_apiService.accessToken}';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // If unauthorized, attempt to refresh the access token
      final refreshed = await _apiService.refreshAccessToken();
      if (refreshed) {
        // Retry the original request with the new token
        final retryResponse =
            await _apiService.retryRequest(err.requestOptions);
        handler.resolve(retryResponse);
        return;
      } else {
        // Refresh token failed, notify the app
        handler.reject(err);
        return;
      }
    }
    handler.next(err);
  }
}
