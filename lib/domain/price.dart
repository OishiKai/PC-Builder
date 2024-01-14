class Price {
  /// 1000 -> "¥1,000"
  static String intToString(int price) {
    final String stringValue = price.toString();
    final StringBuffer buffer = StringBuffer();
    buffer.write('¥');
    for (int i = 0; i < stringValue.length; i++) {
      if (i > 0 && (stringValue.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(stringValue[i]);
    }
    return buffer.toString();
  }

  /// "¥1,000" -> 1000
  static int stringToInt(String price) {
    final normalizedPrice = price.trim().replaceAll('¥', '').replaceAll(',', '');
    return normalizedPrice.isEmpty ? 0 : int.parse(normalizedPrice);
  }
}
