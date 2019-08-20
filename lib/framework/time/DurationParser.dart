
class DurationParser {

  static String parse(Duration duration) {
    return '${duration.inHours.toString()}:${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}';
  }
}