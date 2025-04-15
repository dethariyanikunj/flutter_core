class LanguageKey {
  static const String appName = 'app_name';
  static const String noInternetConnection = 'no_internet_connection';
  static const String oopsSomethingWentWrong = 'oops_something_went_wrong';
  {{#uses_in_app_update_feature}}
  static const String updateRequired = 'update_required';
  static const String updateAvailable = 'update_available';
  static const String updateNotes = 'update_notes';
  static const String updateNow = 'update_now';
  {{/uses_in_app_update_feature}}
}
