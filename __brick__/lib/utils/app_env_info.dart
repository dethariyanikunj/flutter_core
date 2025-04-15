import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnvInfo {
  static String get iTunesBaseUrl => dotenv.get('ITUNES_BASE_URL');

  static String get apiBaseUrl => dotenv.get('API_BASE_URL');
}
