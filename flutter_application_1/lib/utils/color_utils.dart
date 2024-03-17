// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:pretty_logger/pretty_logger.dart';

class ColorUtils {
  static Color hexToColor(String hexCode) {
    try {
      hexCode = hexCode.replaceAll("#", "");
      if (hexCode.length == 6) {
        hexCode = "FF$hexCode";
      } else {
        throw Exception("Invalid Hex Color. Must be in #RRGGBB format");
      }

      return Color(int.parse(hexCode, radix: 16));
    } catch (e) {
      PLog.error('Error parsing hex to color: $e');
      return Colors.transparent;
    }
  }

  /// Returns a darker color based on the [color] and [lightness] value
  /// [lightness] value must be from 0.0 to 1.0
  static Color getLighterColor({required Color color, required double lightness}) {
    final hslColor = HSLColor.fromColor(color);
    final hslLighterColor = hslColor.withLightness(hslColor.lightness + lightness);
    return hslLighterColor.toColor();
  }
}
