import 'package:get/get.dart';

import './english.dart';
import './gujarati.dart';
import './hindi.dart';
import './arabic.dart';
import './spanish.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': English.getStrings(),
        'hi_IN': Hindi.getStrings(),
        'gu_IN': Gujarati.getStrings(),
        'es_ES': Spanish.getStrings(),
        'ar_SA': Arabic.getStrings(),
      };
}
