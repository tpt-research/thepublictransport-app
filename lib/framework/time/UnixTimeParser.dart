class UnixTimeParser {

  static DateTime parse(int time) {
    return DateTime.fromMillisecondsSinceEpoch(time);
  }

}