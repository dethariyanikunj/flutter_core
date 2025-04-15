class ApiEndpoints {
  static const String refreshToken = 'refresh-token';
  static const String updateFcmToken = 'update-fcm-token';
  static const String logout = 'logout';
  {{#uses_in_app_update_feature}}
  static const String iTunesLookup = 'lookup';
  {{/uses_in_app_update_feature}}
}
