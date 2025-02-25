import './language_keys.dart';

class English {
  static Map<String, String> getStrings() {
    return {
      LanguageKey.appName: '{{app_name}}',
      LanguageKey.noInternetConnection:
          'It seems you are not connected to the internet.',
      LanguageKey.oopsSomethingWentWrong: 'Oops! Something went wrong.',
    };
  }
}
