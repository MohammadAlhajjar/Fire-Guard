import 'package:intl/intl.dart';

class DateFormatHelper {
  static String getFormattedDate(String date) {
    return DateFormat('dd MMMM, yyyy hh:mm').format(
      DateTime.parse(
        date,
      ),
    );
  }
}
