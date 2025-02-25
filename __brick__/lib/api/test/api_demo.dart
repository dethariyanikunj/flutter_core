import 'package:flutter/foundation.dart';

import '../api.dart';
import './country.dart';
import './food.dart';

class ApiDemo {
  static const String countryApiBaseUrl = 'https://restcountries.com/';
  static const String foodApiBaseUrl = 'https://world.openfoodfacts.org/api/';

  /// For Testing purpose this api service is created.
  /// Instead of this use object of api_service_config.dart
  final apiService = ApiService(
    baseUrl: foodApiBaseUrl,
    defaultHeaders: {
      'Content-Type': 'application/json',
    },
    refreshTokenEndpoint: '',
    enableLogging: true,
  );

  /// Call APIs from Controllers
  Future fetchFoodInformation() async {
    // In case of response starts with json object use getRequest()
    final response = await apiService.getRequest<Food>(
      'v0/product/8901262260107',
      fromJson: (data) => Food.fromJson(data),
    );

    if (response.isSuccess) {
      if (kDebugMode) {
        print('Response: ${response.data}');
      }
    } else {
      if (kDebugMode) {
        print('Error: ${response.error?.message}');
      }
    }
  }

  Future fetchCountryInformation() async {
    // In case of response starts with json array use getRequestArray()
    final response = await apiService.getRequestArray<Country>(
      'v3.1/name/India',
      fromJsonList: (data) => Country.fromJsonList(data),
    );

    if (response.isSuccess) {
      if (kDebugMode) {
        print('Response: ${response.data}');
      }
    } else {
      if (kDebugMode) {
        print('Error: ${response.error?.message}');
      }
    }
  }
}
