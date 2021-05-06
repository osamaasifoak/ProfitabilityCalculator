import 'package:intl/intl.dart';

class DateFormatter {
  static String getDate(String _time) {
    String dateFormat = DateFormat("MMMM dd, yyyy").format(
      DateTime.parse(_time),
    );
    return dateFormat;
  }

  static String getDateDDMMYY(String _time) {
    String dateFormat = DateFormat("dd.mm.yyyy").format(
      DateTime.parse(_time),
    );
    return dateFormat;
  }

  static String getWeekDay(String _time) {
    String dateFormat = DateFormat("EEEE").format(
      DateTime.parse(_time),
    );
    return dateFormat;
  }

  static String getTime(String _time) {
    String dateFormat = DateFormat("HH:MM aa").format(
      DateTime.parse(_time),
    );
    return dateFormat;
  }

  static String getDateAndTime(String dateTime) {
    return getDate(dateTime) + " " + getTime(dateTime);
  }

//   String getVerboseDateTimeRepresentation(DateTime dateTime) {
//     DateTime now = DateTime.now();
//     DateTime justNow = now.subtract(Duration(minutes: 1));
//     DateTime localDateTime = dateTime.toLocal();

//     if (!localDateTime.difference(justNow).isNegative) {
//       return "Just now";
//     }

//     String roughTimeString = DateFormat('jm').format(dateTime);

//     if (localDateTime.day == now.day && localDateTime.month == now.month && localDateTime.year == now.year) {
//       return roughTimeString;
//     }

//     DateTime yesterday = now.subtract(Duration(days: 1));

//     if (localDateTime.day == yesterday.day && localDateTime.month == now.month && localDateTime.year == now.year) {
//       return "Yesterday";
//     }

//     if (now.difference(localDateTime).inDays < 4) {
//       String weekday = DateFormat('EEEE', "");

//       return '$weekday, $roughTimeString';
//     }

//     return '${DateFormat('yMd', localizations.locale.toLanguageTag()).format(dateTime)}, $roughTimeString';
//   }
}
