import 'package:intl/intl.dart';

class DateFormatHelper {
  static String getFormattedDate({String? date}) {
    return date != null
        ? DateFormat('dd/MM/yyyy hh:mm a').format(
            DateTime.parse(
              date,
            ).toLocal(),
          )
        : '';
  }
}
