import 'dart:ui';

class ColorConversion {
  /// Construct a color from a hex code string, of the format #RRGGBBAA.
  static Color hex4ToColor(String hexString) {
    final hex = hexString.replaceFirst('#', '');
    return Color(int.parse('0x${hex.substring(6)}${hex.substring(0, 6)}'));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  static String toHex(Color color, {bool leadingHashSign = true}) =>
      '${leadingHashSign ? '#' : ''}'
      '${color.red.toRadixString(16).padLeft(2, '0')}'
      '${color.green.toRadixString(16).padLeft(2, '0')}'
      '${color.blue.toRadixString(16).padLeft(2, '0')}'
      '${color.alpha.toRadixString(16).padLeft(2, '0')}';
}
