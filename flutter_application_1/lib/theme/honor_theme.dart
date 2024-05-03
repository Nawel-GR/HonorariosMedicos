// 🎯 Dart imports:
import 'dart:ui';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/color_utils.dart';

// 📦 Package imports:
import 'package:google_fonts/google_fonts.dart';

// 🌎 Project imports:

class HonorTypography {
  static TextStyle displayLarge = GoogleFonts.inter(
    fontSize: 36,
    fontWeight: FontWeight.w800,
    decorationThickness: 2,
    decorationStyle: TextDecorationStyle.solid,
  );

  static TextStyle display = GoogleFonts.inter(
    fontSize: 31,
    fontWeight: FontWeight.w800,
    decorationThickness: 2,
    decorationStyle: TextDecorationStyle.solid,
  );

  static TextStyle titleLarge = GoogleFonts.inter(
    fontSize: 23,
    fontWeight: FontWeight.w800,
    decorationThickness: 2,
    decorationStyle: TextDecorationStyle.solid,
  );

  static TextStyle title = GoogleFonts.inter(
    fontSize: 19,
    fontWeight: FontWeight.w800,
    decorationThickness: 2,
    decorationStyle: TextDecorationStyle.solid,
  );
  static TextStyle header = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.04 * 13.4,
    decorationThickness: 2,
    decorationStyle: TextDecorationStyle.solid,
  );

  static TextStyle subtitleStrong = GoogleFonts.inter(
    fontSize: 15.6,
    fontWeight: FontWeight.w800,
    decorationThickness: 2,
    decorationStyle: TextDecorationStyle.solid,
  );

  static TextStyle subtitle = GoogleFonts.inter(
    fontSize: 15.6,
    fontWeight: FontWeight.w400,
    decorationThickness: 2,
    decorationStyle: TextDecorationStyle.solid,
  );

  static TextStyle bodyLargeStrong = GoogleFonts.inter(
    fontSize: 14.6,
    fontWeight: FontWeight.w700,
    decorationThickness: 2,
    decorationStyle: TextDecorationStyle.solid,
  );

  static TextStyle bodyLarge = GoogleFonts.inter(
    fontSize: 14.6,
    fontWeight: FontWeight.w400,
    decorationThickness: 2,
    decorationStyle: TextDecorationStyle.solid,
  );

  static TextStyle bodyStrong = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.04 * 13.4,
    decorationThickness: 2,
    decorationStyle: TextDecorationStyle.solid,
  );

  static TextStyle body = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.04 * 13.4,
    decorationThickness: 2,
    decorationStyle: TextDecorationStyle.solid,
  );

  static TextStyle bodySmallStrong = GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.04 * 12,
    decorationThickness: 2,
    decorationStyle: TextDecorationStyle.solid,
  );

  static TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.04 * 12,
    decorationThickness: 2,
    decorationStyle: TextDecorationStyle.solid,
  );

  static TextStyle captionStrong = GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.04 * 10.4,
    decorationThickness: 2,
    decorationStyle: TextDecorationStyle.solid,
  );

  static TextStyle caption = GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.04 * 10.4,
    decorationThickness: 2,
    decorationStyle: TextDecorationStyle.solid,
  );

  static TextStyle captionSmallStrong = GoogleFonts.inter(
    fontSize: 8.6,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.04 * 9,
    decorationThickness: 2,
    decorationStyle: TextDecorationStyle.solid,
  );

  static TextStyle captionSmall = GoogleFonts.inter(
    fontSize: 8.6,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.04 * 9,
    decorationThickness: 2,
    decorationStyle: TextDecorationStyle.solid,
  );
}

class HonorColors {
  // Primary colors
  final Color primary = ColorUtils.hexToColor('#6797C4');
  final Color primaryLight = ColorUtils.hexToColor('#6797C4').withOpacity(0.7);
  final Color primaryLighter =
      ColorUtils.hexToColor('#6797C4').withOpacity(0.59);
  final Color primaryLightest = ColorUtils.hexToColor('#94C3E5');
  final Color primaryVariant = ColorUtils.hexToColor('#95A9BC');
  final Color primaryVariantLight = ColorUtils.hexToColor('#C3C3C3');
  // Neutral colors
  final Color dark = ColorUtils.hexToColor('#04001B');
  final Color darkLight = ColorUtils.hexToColor('#4D4D4D');
  final Color darkLighter = ColorUtils.hexToColor('#DCDCDC');
  final Color darkLightest = ColorUtils.hexToColor('#F2F2F2');
  final Color white = ColorUtils.hexToColor('#FFFFFF');
  final Color transparent = Colors.transparent;
  // System colors
  final Color success = ColorUtils.hexToColor('#42CF00');
  final Color successLight = ColorUtils.hexToColor('#e5fff5');
  final Color warning = ColorUtils.hexToColor('#FFF500');
  final Color warningLight = ColorUtils.hexToColor('#fef9e7');
  final Color received = ColorUtils.hexToColor('#FFB72C');
  final Color danger = ColorUtils.hexToColor('#df4d54');
  final Color dangerLight = ColorUtils.hexToColor('#fde7e7');
  // Other colors
  final Color background = ColorUtils.hexToColor('#f7f6fc');
  final Color asideDetailsBackground = ColorUtils.hexToColor('#ffffff');
  final Color overlay = ColorUtils.hexToColor('#000000').withOpacity(0.5);
  final Color barrierColor = ColorUtils.hexToColor('#000000').withOpacity(0.75);
}

class HonorShadows {
  final List<BoxShadow> shadowSmall = [
    BoxShadow(
      color: Colors.black.withOpacity(0.06),
      blurRadius: 4,
      offset: const Offset(0, 3),
    ),
  ];
  final List<BoxShadow> shadowMedium = [
    BoxShadow(
      color: Colors.black.withOpacity(0.06),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];
  final List<BoxShadow> shadowLarge = [
    BoxShadow(
      color: Colors.black.withOpacity(0.06),
      blurRadius: 20,
      offset: const Offset(0, 6),
    ),
  ];
}

class HonorSpacing {
  // Spacing between items
  final double itemsLarge = 18;
  final double itemsMedium = 12;
  final double itemsSmall = 8;
  final double titleMarginBottom = 22;
  final double buttonLarge = 12;
  final double buttonMedium = 8;
  final double buttonSmall = 4;

  // Boddy Spacings
  final double bodyBottomRight = 12;

  /// The default body padding value (28)
  final double bodyPaddingValue = 28;

  /// The default body padding X and Y (28, 28)
  final EdgeInsets bodyPadding = const EdgeInsets.symmetric(
    horizontal: 28,
    vertical: 28,
  );

  /// The default body padding X (28)
  final EdgeInsets bodyPaddingHorizontal =
      const EdgeInsets.symmetric(horizontal: 28);

  /// The default body padding Y (28)
  final EdgeInsets bodyPaddingVertical =
      const EdgeInsets.symmetric(vertical: 28);

  // Inputs
  final EdgeInsets inputPadding = const EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 12,
  );
}

class HonorSizing {
  final double asideWidth = 240;
  final double collapsedAsideWidth = 65;
  final double navbarHeight = 60;
  final double detailsAsideWidth = 330;
  final double paymentAsideWidth = 800;
  final double messengerUserListWidth = 230;
  final double messengerConversationListWidth = 250;
}

class HonorBorders {
  final double itemsRadiusValue = 10;
  final BorderRadius itemsRadius = BorderRadius.circular(10);
}

class HonorEffects {
  final ImageFilter blur = ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5);
}

class HonorTheme {
  static HonorColors colors = HonorColors();
  static HonorShadows shadows = HonorShadows();
  static HonorSpacing spacing = HonorSpacing();
  static HonorSizing sizing = HonorSizing();
  static HonorBorders borders = HonorBorders();
  static HonorEffects effects = HonorEffects();

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: colors.primary,
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: colors.primaryLight),
    scaffoldBackgroundColor: colors.white,
    splashColor: colors.primaryLight.withOpacity(0.4),
    highlightColor: colors.primaryLight.withOpacity(0.4),
    // Global Typography
    textTheme: ThemeData.light().textTheme.apply(
          fontFamily: GoogleFonts.inter().fontFamily,
          bodyColor: colors.dark,
          displayColor: colors.dark,
          decorationColor: colors.dark,
        ),
    // AppBar
    appBarTheme: AppBarTheme(
      toolbarHeight: sizing.navbarHeight,
      elevation: 8,
      scrolledUnderElevation: 8,
      backgroundColor: colors.primary,
      foregroundColor: colors.white,
      surfaceTintColor: colors.primary,
      shadowColor: colors.primary,
      centerTitle: false,
      iconTheme: IconThemeData(color: colors.white),
      actionsIconTheme: IconThemeData(color: colors.white),
    ),

    // FloatingActionButtonTheme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors.primary,
        foregroundColor: colors.white,
        elevation: 12,
        iconSize: 32,
        sizeConstraints: const BoxConstraints(minWidth: 52, minHeight: 52)),

    // BottomNavigation
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: colors.primary,
      selectedItemColor: colors.white,
      selectedIconTheme: const IconThemeData(size: 28),
      selectedLabelStyle:
          const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
      unselectedItemColor: colors.primaryLight,
      unselectedIconTheme: const IconThemeData(size: 28),
      unselectedLabelStyle:
          const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      elevation: 0,
    ),

    // Buttons
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    ),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(colors.overlay),
            backgroundColor: MaterialStateProperty.all(colors.primary),
            foregroundColor: MaterialStateProperty.all(colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            )))),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(colors.overlay),
            backgroundColor: MaterialStateProperty.all(colors.primary),
            foregroundColor: MaterialStateProperty.all(colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            )))),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(colors.overlay),
            backgroundColor: MaterialStateProperty.all(colors.primary),
            foregroundColor: MaterialStateProperty.all(colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            )))),
    // List Tiles
    listTileTheme: ListTileThemeData(
      tileColor: colors.white,
      shape: RoundedRectangleBorder(borderRadius: borders.itemsRadius),
    ),

    // Inputs
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: colors.primary,
      selectionColor: colors.primaryLight,
      selectionHandleColor: colors.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: colors.primary, width: 1.5),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(colors.primary),
      overlayColor: MaterialStateProperty.all(colors.primary),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(colors.primary),
      overlayColor: MaterialStateProperty.all(colors.primary),
    ),
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all(colors.primaryLight),
      thumbColor: MaterialStateProperty.all(colors.primary),
    ),
    // Toasts
    snackBarTheme: SnackBarThemeData(
        backgroundColor: colors.dark,
        contentTextStyle: HonorTypography.body.copyWith(color: colors.white)),
    // Alerts
    dialogTheme: DialogTheme(
      titleTextStyle: HonorTypography.subtitle.copyWith(color: colors.dark),
      contentTextStyle:
          HonorTypography.body.copyWith(color: colors.darkLighter),
      elevation: 40,
    ),
    // Tooltips
    tooltipTheme: TooltipThemeData(
      showDuration: const Duration(milliseconds: 400),
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      textStyle: HonorTypography.caption,
      decoration: BoxDecoration(
        color: colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    ),
  );
}
