extension StringUtil on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

class StringUtils {
  static String capitalize(String? text) {
    if (text == null || text.isEmpty) {
      return '';
    }
    return text[0].toUpperCase() + text.substring(1);
  }

  static String ordinal(int value) {
    if (value < 0 || value == 0) {
      return '';
    }
    if ((value % 100) >= 11 && (value % 100) <= 13) {
      return "${value}th";
    }
    switch (value % 10) {
      case 1:
        return "${value}st";
      case 2:
        return "${value}nd";
      case 3:
        return "${value}rd";
      default:
        return "${value}th";
    }
  }
}
