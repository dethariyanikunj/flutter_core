import 'package:flutter_dotenv/flutter_dotenv.dart';

import './api.dart';

class ApiServiceConfig {
  static final apiService = ApiService(
    baseUrl: dotenv.get('API_BASE_URL'),
    defaultHeaders: {
      'Content-Type': 'application/json',
    },
    refreshTokenEndpoint: ApiEndpoints.refreshToken,
    enableLogging: true,
    onRefreshTokenExpired: () {
      // show dialog from here!
    },
  );
}
