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

  static double? decodeFormattedPrice(String? formattedPrice) {
    if (formattedPrice == null || formattedPrice.trim().isEmpty) {
      return null;
    }
    // Remove rupee symbol and any non-numeric characters except the decimal separator
    String cleanedPrice = formattedPrice.replaceAll(
      RegExp(r'[^\d.]'),
      '',
    ); // Keep numbers and decimal
    return double.tryParse(cleanedPrice);
  }
}
