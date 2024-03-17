// 🐦 Flutter imports:
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/theme/honor_theme.dart';
import 'package:flutter_app/utils/color_utils.dart';

// 📦 Package imports:

// 🌎 Project imports:


enum ButtonSize { extraSmall, small, medium, large }

enum IconPosition { left, right }

class TextTargetStyle {
  final String target;
  final Color color;

  TextTargetStyle({
    required this.target,
    required this.color,
  });
}

class HonorButton extends StatelessWidget {
  final ButtonSize buttonSize;
  final IconPosition iconPosition;
  final String? text;
  final List<TextTargetStyle>? textTargetStyle;
  final void Function()? onTap;
  final IconData? icon;
  final Color? iconColor;
  final Color? textColor;
  final Color? bgColor;
  final Color? disabledTextColor;
  final Color? disabledBgColor;
  final Color? borderColor;
  final bool? fullWidth;
  final bool? withShadow;
  final double? minWidth;
  final BorderRadius? borderRadius;
  final AlignmentGeometry? alignment;

  const HonorButton({
    super.key,
    this.buttonSize = ButtonSize.medium,
    this.iconPosition = IconPosition.left,
    this.text,
    this.textTargetStyle,
    this.onTap,
    this.icon,
    this.iconColor,
    this.textColor,
    this.bgColor,
    this.disabledTextColor,
    this.disabledBgColor,
    this.borderColor,
    this.fullWidth = false,
    this.withShadow = false,
    this.minWidth,
    this.borderRadius,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    Color buttonIconColor = iconColor ?? textColor ?? HonorTheme.colors.white;
    Color buttonTextColor = textColor ?? HonorTheme.colors.white;
    Color buttonBgColor = bgColor ?? HonorTheme.colors.primary;
    Color buttonBorderColor = borderColor ?? bgColor ?? HonorTheme.colors.primary;
    double fontSize;
    double iconSize;
    double iconSpacing;
    EdgeInsets buttonPadding;

    switch (buttonSize) {
      case ButtonSize.extraSmall:
        fontSize = 8.6;
        iconSize = 12.6;
        iconSpacing = 4.0;
        buttonPadding = const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0);
        break;
      case ButtonSize.small:
        fontSize = 10.4;
        iconSize = 15.6;
        iconSpacing = 6.0;
        buttonPadding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0);
        break;
      case ButtonSize.medium:
        fontSize = 13.4;
        iconSize = 18.6;
        iconSpacing = 8.0;
        buttonPadding = const EdgeInsets.symmetric(horizontal: 22.0, vertical: 20.0);
        break;
      case ButtonSize.large:
        fontSize = 16.0;
        iconSize = 22.6;
        iconSpacing = 10.0;
        buttonPadding = const EdgeInsets.symmetric(horizontal: 30.0, vertical: 24.0);
        break;
    }

    TextStyle textStyle = TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: buttonTextColor,
    );

    return Container(
      width: fullWidth! ? double.infinity : null,
      constraints: minWidth != null ? BoxConstraints(minWidth: minWidth!) : const BoxConstraints(),
      decoration: BoxDecoration(boxShadow: withShadow == true ? HonorTheme.shadows.shadowMedium : null),
      child: TextButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          visualDensity: VisualDensity.compact,
          elevation: 0,
          foregroundColor: buttonTextColor,
          surfaceTintColor: buttonBgColor,
          backgroundColor: buttonBgColor,
          disabledForegroundColor: disabledTextColor ?? HonorTheme.colors.white,
          disabledBackgroundColor: disabledBgColor ?? ColorUtils.hexToColor('#b8b6b6'),
          side: BorderSide(color: buttonBorderColor),
          padding: buttonPadding,
          shape: RoundedRectangleBorder(borderRadius: borderRadius ?? BorderRadius.circular(200)),
          alignment: alignment,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconPosition == IconPosition.left && icon != null) ...[
              Icon(
                icon,
                color: buttonIconColor,
                size: iconSize,
              ),
              if (text != null) SizedBox(width: iconSpacing),
            ],
            if (text != null)
              EasyRichText(
                text!,
                defaultStyle: textStyle,
                patternList: textTargetStyle
                        ?.map((e) => EasyRichTextPattern(
                              targetString: e.target,
                              style: textStyle.copyWith(color: e.color),
                            ))
                        .toList() ??
                    [],
              ),
            if (iconPosition == IconPosition.right && icon != null) ...[
              if (text != null) SizedBox(width: iconSpacing),
              Icon(
                icon,
                color: buttonIconColor,
                size: iconSize,
              ),
            ],
            
          ],
        ),
      ),
    );
  }
}
