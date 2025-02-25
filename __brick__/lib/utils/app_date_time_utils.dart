import 'package:intl/intl.dart';

class AppDateTimeUtils {
  /// Formats the given timestamp based on the specified rules.
  static String getTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes <= 1) {
      // 1. If time difference is 1 minute or less
      return 'Just now';
    } else if (_isSameDay(now, timestamp)) {
      // 2. If time difference is within the same day
      return 'Today at ${_formatTime(timestamp)}';
    } else if (_isYesterday(now, timestamp)) {
      // 3. If time difference is within yesterday
      return 'Yesterday at ${_formatTime(timestamp)}';
    } else {
      // 4. If time difference is more than a day
      return "${_formatDate(timestamp)} at ${_formatTime(timestamp)}";
    }
  }

  /// Checks if two dates are on the same day.
  static bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /// Checks if the given date is yesterday relative to the current date.
  static bool _isYesterday(DateTime now, DateTime date) {
    final yesterday = now.subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  /// Formats the time part of the given timestamp (e.g., "5:30 PM").
  static String _formatTime(DateTime timestamp) {
    return DateFormat('h:mm a').format(timestamp);
  }

  /// Formats the date part of the given timestamp (e.g., "1 Nov 2024").
  static String _formatDate(DateTime timestamp) {
    return DateFormat('d MMM yyyy').format(timestamp);
  }

  // Format as MM:SS
  static String formatSecondsToTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60; // Calculate minutes
    int seconds = totalSeconds % 60; // Calculate remaining seconds
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  static String formatDateFromTimestamp(int? timestamp, String outputFormat) {
    return DateFormat(outputFormat).format(
      DateTime.fromMillisecondsSinceEpoch(timestamp ?? 0),
    );
  }

  static int calculateDaysDifference(int? startTimeStamp, int? endTimestamp) {
    // Convert timestamps to DateTime
    DateTime startDate =
    DateTime.fromMillisecondsSinceEpoch(startTimeStamp ?? 0);
    DateTime endDate = DateTime.fromMillisecondsSinceEpoch(endTimestamp ?? 0);
    // Calculate the difference in days
    return endDate.difference(startDate).inDays;
  }

}
