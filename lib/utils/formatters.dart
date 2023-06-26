import 'package:intl/intl.dart';

String dateFormatter(DateTime date) {
  DateFormat formatter = DateFormat.yMMMd();
  return formatter.format(date);
}

String lastViewedDateFormatter(String postedAt) {
  var now = DateTime.now();
  var posted = DateTime.parse(postedAt);

  var seconds = now.difference(posted).inSeconds;
  var minutes = now.difference(posted).inMinutes;
  var hours = now.difference(posted).inHours;
  var days = now.difference(posted).inDays;
  var months = ((now.difference(posted).inDays) / 30).floor();
  var years = (months / 12).floor();

  if (years > 0) {
    return "${years}y";
  } else if (months > 0) {
    return "${months}m";
  } else if (days > 0) {
    return "${days}d";
  } else if (hours > 0) {
    return "${hours}h";
  } else if (minutes > 0) {
    return "${minutes}m";
  } else if (minutes > 0) {
    return "${minutes}m";
  } else {
    return "${seconds}s";
  }
}
