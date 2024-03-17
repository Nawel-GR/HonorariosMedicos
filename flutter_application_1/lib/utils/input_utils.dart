// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_app/theme/honor_theme.dart';

// 🌎 Project imports:

class InputUtils {
  static InputDecoration getDecoration({
    bool? isDense,
    String? labelText,
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Color? fillColor,
    Color? enabledBorderColor,
    TextStyle? hintStyle,
    TextStyle? labelStyle,
    TextStyle? helperStyle,
    TextStyle? prefixStyle,
    TextStyle? suffixStyle,
  }) {
    EdgeInsetsGeometry padding = isDense == true
        ? const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0)
        : const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0);

    return InputDecoration(
      isDense: isDense ?? false,
      labelText: labelText,
      helperStyle: helperStyle ?? HonorTypography.bodySmall,
      prefixStyle: prefixStyle ?? HonorTypography.bodySmallStrong.copyWith(color: HonorTheme.colors.primary),
      suffixStyle: suffixStyle ?? HonorTypography.bodySmallStrong.copyWith(color: HonorTheme.colors.primary),
      labelStyle: labelStyle ?? HonorTypography.body,
      floatingLabelStyle: HonorTypography.bodySmallStrong.copyWith(color: HonorTheme.colors.primary),
      hintText: hintText,
      hintMaxLines: 1,
      hintStyle: hintStyle ?? HonorTypography.body,
      prefixIcon: Container(
        padding: isDense == true
            ? const EdgeInsets.only(left: 8.0, right: 4.0)
            : const EdgeInsets.only(left: 14.0, right: 10.0),
        child: prefixIcon,
      ),
      suffixIcon: suffixIcon,
      errorStyle: HonorTypography.body.copyWith(color: HonorTheme.colors.danger),
      filled: true,
      fillColor: fillColor ?? HonorTheme.colors.white,
      contentPadding: padding,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: enabledBorderColor ?? HonorTheme.colors.white, width: 1.6),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: HonorTheme.colors.primary, width: 1.6),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: HonorTheme.colors.danger, width: 1.6),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: HonorTheme.colors.danger, width: 1.6),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
    );
  }
}
