import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_text_file/library/utility/color_conversion.dart';

void main() {
  test(
      'Case 1: Given hex string (#RRGGBBAA) with alpha When converted to Color object Then prints the right R, G, B, A values',
      () async {
    // ARRANGE
    const String hexString = '#fcba030f';

    // ACT
    final Color color = ColorConversion.hex4ToColor(hexString);

    // ASSERT
    expect(color.red, 252);
    expect(color.green, 186);
    expect(color.blue, 3);
    expect(color.alpha, 15);
  });

  test(
      'Case 2: Given hex string (#RRGGBBAA) with alpha When converted to Color object Then prints the right R, G, B, A values',
      () async {
    // ARRANGE
    const String hexString = '#fcba03ff';

    // ACT
    final Color color = ColorConversion.hex4ToColor(hexString);

    // ASSERT
    expect(color.red, 252);
    expect(color.green, 186);
    expect(color.blue, 3);
    expect(color.alpha, 255);
  });

  test(
      'Case 1: Given Color object When converted to String Then prints in the format (#RRGGBBAA)',
      () async {
    // ARRANGE
    const Color color = Color.fromARGB(15, 252, 186, 3);

    // ACT
    final String hexString = ColorConversion.toHex(color);

    // ASSERT
    expect(hexString, '#fcba030f');
  });

  test(
      'Case 2: Given Color object When converted to String Then prints in the format (#RRGGBBAA)',
      () async {
    // ARRANGE
    const Color color = Color.fromARGB(255, 252, 186, 3);

    // ACT
    final String hexString = ColorConversion.toHex(color);

    // ASSERT
    expect(hexString, '#fcba03ff');
  });
}
