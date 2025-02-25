import 'package:intl/intl.dart';

import './app_string_utils.dart';

class AppPricingFormats {
  static String? formatPrice(String? price) {
    if (price == null || price.trim().isEmpty) {
      return null;
    }
    final nPrice = AppStringUtils.removeTrailingZeros(price.trim());
    if (nPrice.toString().trim().isNotEmpty) {
      return NumberFormat.decimalPattern('hi') // Hindi
          .format(
              nPrice.contains('.') ? double.parse(nPrice) : int.parse(nPrice));
    }
    return null;
  }
}
