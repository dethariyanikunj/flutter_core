import './language_keys.dart';

class English {
  static Map<String, String> getStrings() {
    return {
      LanguageKey.appName: '{{app_name}}',
      LanguageKey.noInternetConnection:
          'It seems you are not connected to the internet.',
      LanguageKey.oopsSomethingWentWrong: 'Oops! Something went wrong.',
      {{#uses_in_app_update_feature}}
      LanguageKey.updateRequired: 'Update Required',
      LanguageKey.updateAvailable: 'A new version of the app is now available.',
      LanguageKey.updateNotes:
      'To ensure the best experience and continued access to all features, please update to the latest version.\n\nKindly note: The current version is no longer supported and the app will not function until it has been updated.',
      LanguageKey.updateNow: 'Update Now',
      {{/uses_in_app_update_feature}}
    };
  }
}
