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
}
