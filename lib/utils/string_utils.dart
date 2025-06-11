class StringUtils {
  static bool stringTest(String value) {
    return value != null && value.length > 0;
  }

  static captalize(String text) {
    return "${text[0].toUpperCase()}${text.substring(1).toLowerCase()}";
  }
}
