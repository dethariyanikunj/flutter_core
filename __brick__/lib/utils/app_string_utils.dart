class AppStringUtils {
  /// Returns an abbreviation of the given text with a maximum of 2 characters.
  static String getAbbreviation(String? text, {int length = 2}) {
    if (text == null || text.trim().isEmpty) {
      return ''; // Return an empty string if the input is null or empty
    }
    final words =
        text.split(RegExp(r'\s+')).where((word) => word.isNotEmpty).toList();
    return words.take(length).map((word) => word[0].toUpperCase()).join();
  }

  /// Use a regular expression to add a space after every 5 digits
  static String addSpaceAfterFiveDigits(String input) {
    return input.replaceAllMapped(
      RegExp(r'(.{5})(?=.)'),
      // Match any 5 characters, ensure at least one more character follows
          (match) => '${match.group(1)} ',
    );
  }

  static String removeTrailingZeros(String value, {int precision = 2}) {
    // Convert to double to handle rounding properly
    double? numValue = double.tryParse(value);
    if (numValue != null) {
      // Round to the specified precision
      String formatted = numValue.toStringAsFixed(precision);
      // Remove unnecessary trailing zeros while keeping the correct decimal places
      formatted = formatted.replaceAllMapped(
          RegExp(r"(\.\d*?[1-9])0+$"), (match) => match.group(1)!);
      // If the result ends in ".0", remove it completely (for whole numbers)
      formatted = formatted.replaceAll(RegExp(r'\.0+$'), '');
      return formatted;
    }
    return value;
  }

  static String maskMobileNumber(String phoneNumber) {
    // Remove any spaces from the input
    String cleanedNumber = phoneNumber.replaceAll(' ', '');
    if (cleanedNumber.length < 4) {
      return phoneNumber; // Return as is if length is less than 4
    }
    // Mask all but the last four digits
    String maskedPart = '*' * (cleanedNumber.length - 4);
    String visiblePart = cleanedNumber.substring(cleanedNumber.length - 4);
    // Format with space if needed
    return '$maskedPart$visiblePart';
  }
}
