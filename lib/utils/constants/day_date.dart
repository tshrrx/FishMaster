import 'package:intl/intl.dart';

class DateUtil {
  static int getCurrentTimestamp() {
    return DateTime.now().millisecondsSinceEpoch ~/ 1000;
  }
  
  static String formatTimestamp(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('EEEE, d MMMM y').format(date);
  }
}