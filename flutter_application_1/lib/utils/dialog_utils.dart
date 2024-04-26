// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:animate_do/animate_do.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter_app/theme/honor_theme.dart';
import 'package:flutter_app/utils/color_utils.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// 🌎 Project imports:

// 📦 Package imports:

enum ToastType {
  normal,
  info,
  success,
  warning,
  error,
  delete,
  wifiOn,
  wifiOff,
}

class DialogAction {
  final IconData? icon;
  final String text;
  final Color? bgColor;
  final Color? textColor;
  final Function()? onTap;

  DialogAction({
    this.icon,
    required this.text,
    this.bgColor,
    this.textColor,
    this.onTap,
  });
}

class DialogUtils {
  static void closeSpinner() {
    BotToast.closeAllLoading();
  }

  static void showSpinner({String? text, bool? closeButton = false}) {
    BotToast.showCustomLoading(
      backgroundColor: Colors.black.withOpacity(0.4),
      toastBuilder: (context) {
        return Center(
          child: IntrinsicWidth(
            child: Container(
              padding: const EdgeInsets.only(
                  top: 24, bottom: 20, left: 20, right: 20),
              constraints: const BoxConstraints(minWidth: 160),
              decoration: BoxDecoration(
                color: HonorTheme.colors.white,
                borderRadius: HonorTheme.borders.itemsRadius,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LoadingAnimationWidget.fourRotatingDots(
                      color: HonorTheme.colors.primary, size: 44),
                  if (text != null) ...[
                    const SizedBox(height: 16),
                    Text(text, style: HonorTypography.bodySmall),
                  ],
                  if (closeButton == true) ...[
                    const SizedBox(height: 16),
                    HonorButton(
                      fullWidth: true,
                      buttonSize: ButtonSize.small,
                      text: 'Cerrar ventana',
                      bgColor: HonorTheme.colors.primary,
                      textColor: HonorTheme.colors.white,
                      onTap: () => BotToast.closeAllLoading(),
                    )
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void showToast({
    required String text,
    ToastType type = ToastType.normal,
    // If not null, a copy button will be displayed to copy the error text
    String? errorDetails,
    String? stackTrace,
    Duration? duration = const Duration(milliseconds: 5200),
  }) {
    IconData? icon;
    Color bgColor;
    Color textColor = HonorTheme.colors.white;

    switch (type) {
      case ToastType.info:
        icon = CupertinoIcons.info;
        bgColor = HonorTheme.colors.primary;
      case ToastType.success:
        icon = CupertinoIcons.checkmark_alt;
        bgColor = HonorTheme.colors.success;
      case ToastType.warning:
        icon = CupertinoIcons.exclamationmark_triangle;
        bgColor = ColorUtils.hexToColor('#FFA500');
      case ToastType.error:
        icon = CupertinoIcons.clear_circled;
        bgColor = HonorTheme.colors.danger;
      case ToastType.delete:
        icon = CupertinoIcons.trash;
        bgColor = HonorTheme.colors.danger;
      default:
        icon = null;
        bgColor = HonorTheme.colors.dark;
        break;
    }

    BotToast.cleanAll();
    BotToast.showCustomText(
      duration: duration,
      toastBuilder: (context) {
        return IntrinsicWidth(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
            constraints: const BoxConstraints(minWidth: 160),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(9),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 18,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // --------- Icon --------- //
                if (icon != null) Icon(icon, color: textColor, size: 20),
                const SizedBox(width: 8),
                Flexible(
                  child: EasyRichText(
                    text,
                    defaultStyle:
                        HonorTypography.body.copyWith(color: textColor),
                  ),
                ),
                SizedBox(
                    width: errorDetails != null || stackTrace != null ? 12 : 0),
                // --------- Copy button --------- //
                if (errorDetails != null || stackTrace != null)
                  // Container(
                  //   clipBehavior: Clip.hardEdge,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(5),
                  //     border: Border.all(
                  //       color: HonorTheme.colors.white.withOpacity(0.14),
                  //       width: 1.5,
                  //     ),
                  //   ),
                  //   child: KairosInkWell(
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 8, vertical: 6),
                  //     borderRadius: BorderRadius.circular(5),
                  //     onTap: () async {
                  //       final String url =
                  //           '```Detalles: ${errorDetails?.trim()}\n\nStacktrace: ${stackTrace?.trim() ?? 'No Stacktrace'}```';

                  //       BotToast.cleanAll();
                  //       await TextUtils.copyToClipboard(
                  //         text: UrlUtils.getUrlWithSpace(url),
                  //         successMessage: 'Error copiado al portapapeles',
                  //       );
                  //     },
                  //     child: Row(
                  //       children: [
                  //         Icon(PhosphorIcons.copySimple(),
                  //             color: HonorTheme.colors.white, size: 12),
                  //         const SizedBox(width: 4),
                  //         Text(
                  //           'Copiar error',
                  //           style: HonorTypography.caption
                  //               .copyWith(color: HonorTheme.colors.white),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  // --------- Close button --------- //
                  Container(
                    margin: const EdgeInsets.only(left: 12, right: 12),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: HonorTheme.colors.white.withOpacity(0.14),
                    ),
                    child: Material(
                      color: HonorTheme.colors.transparent,
                      child: InkResponse(
                        onTap: () => BotToast.cleanAll(),
                        child: Padding(
                          padding: const EdgeInsets.all(7),
                          child: Icon(
                            CupertinoIcons.clear,
                            size: 12,
                            color: textColor,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future showModal(
    BuildContext context, {
    String title = 'Dialog title',
    String? subtitle,
    List<EasyRichTextPattern>? subtitlePatterns,
    // Custom widget to display in the dialog body
    Widget? content,
    // If true, the dialog can be closed by tapping outside it
    bool? barrierDismissible,
    // Padding for the dialog content (default: top: 28, left: 26, right: 26, bottom: 28)
    EdgeInsets? contentPadding,
    // Primary action button (like "Accept" or "Save")
    DialogAction? primaryAction,
    // Secondary action button (like "Cancel" or "Close")
    DialogAction? secondaryAction,
    // Make the dialog larger (max width: 760)
    bool isLarge = false,
    double maxWidth = 760,
    // Function to execute when the dialog is closed by tapping outside it
    void Function()? onPop,
    // Function to execute when the dialog is closed by tapping the close button
    void Function()? onCloseTap,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible ?? true,
      barrierColor: HonorTheme.colors.barrierColor,
      barrierLabel: 'Cerrar ventana',
      builder: (context) {
        return PopScope(
          onPopInvoked: (bool pop) {
            if (onPop != null) {
              onPop();
            }
          },
          child: BackdropFilter(
            filter: HonorTheme.effects.blur,
            child: Center(
              child: IntrinsicWidth(
                child: Container(
                  width: isLarge == true
                      ? MediaQuery.of(context).size.width
                      : null,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: MediaQuery.of(context).size.height * 0.05,
                  ),
                  constraints:
                      BoxConstraints(maxWidth: maxWidth, minWidth: 200),
                  child: Material(
                    color: HonorTheme.colors.transparent,
                    child: FadeInUp(
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: HonorTheme.colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // title and close button
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        left: 24,
                                        right: 12),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color:
                                                HonorTheme.colors.darkLightest,
                                            width: 1),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // --------- Title --------- //
                                        Flexible(
                                          child: Text(
                                            title,
                                            textAlign: TextAlign.center,
                                            style: HonorTypography.title,
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        // --------- Close button --------- //
                                        Container(
                                          clipBehavior: Clip.hardEdge,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle),
                                          child: Tooltip(
                                            message: 'Cerrar ventana',
                                            child: Material(
                                              color:
                                                  HonorTheme.colors.transparent,
                                              child: InkResponse(
                                                onTap: onCloseTap ??
                                                    () => Navigator.pop(
                                                        context, false),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  child: Icon(
                                                    CupertinoIcons.clear,
                                                    size: 18,
                                                    color: HonorTheme
                                                        .colors.darkLight,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // --------- Content --------- //
                                  Padding(
                                    padding: contentPadding ??
                                        const EdgeInsets.only(
                                            top: 26,
                                            bottom: 26,
                                            left: 24,
                                            right: 24),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (subtitle != null)
                                          EasyRichText(
                                            subtitle,
                                            defaultStyle:
                                                HonorTypography.bodyLarge,
                                            patternList: subtitlePatterns,
                                          ),
                                        if (content != null) content,
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              // --------- Actions --------- //
                              if (primaryAction != null ||
                                  secondaryAction != null) ...[
                                Container(
                                  padding: const EdgeInsets.all(14),
                                  color: HonorTheme.colors.darkLightest,
                                  child: Wrap(
                                    alignment: WrapAlignment.end,
                                    runAlignment: WrapAlignment.end,
                                    verticalDirection: VerticalDirection.up,
                                    crossAxisAlignment: WrapCrossAlignment.end,
                                    spacing: HonorTheme.spacing.itemsMedium,
                                    runSpacing: HonorTheme.spacing.itemsMedium,
                                    children: [
                                      if (secondaryAction != null)
                                        FadeInLeft(
                                          from: 80,
                                          duration:
                                              const Duration(milliseconds: 600),
                                          delay: Duration(
                                              milliseconds:
                                                  primaryAction != null
                                                      ? 100
                                                      : 0),
                                          child: HonorButton(
                                            fullWidth: primaryAction == null,
                                            text: secondaryAction.text,
                                            bgColor: secondaryAction.bgColor ??
                                                HonorTheme.colors.white,
                                            textColor:
                                                secondaryAction.textColor ??
                                                    HonorTheme.colors.dark,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            onTap: secondaryAction.onTap ??
                                                () => Navigator.pop(
                                                    context, false),
                                          ),
                                        ),
                                      if (primaryAction != null)
                                        FadeInLeft(
                                          from: 80,
                                          duration:
                                              const Duration(milliseconds: 600),
                                          child: HonorButton(
                                            fullWidth: secondaryAction == null,
                                            text: primaryAction.text,
                                            bgColor: primaryAction.bgColor ??
                                                HonorTheme.colors.primary,
                                            textColor:
                                                primaryAction.textColor ??
                                                    HonorTheme.colors.white,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            onTap: primaryAction.onTap ??
                                                () => Navigator.pop(
                                                    context, true),
                                          ),
                                        ),
                                    ],
                                  ),
                                )
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
