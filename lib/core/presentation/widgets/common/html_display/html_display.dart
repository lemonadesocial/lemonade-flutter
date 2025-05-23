import 'package:app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app/app_theme/app_theme.dart';

class HtmlDisplay extends StatelessWidget {
  final String htmlContent;

  const HtmlDisplay({
    super.key,
    required this.htmlContent,
  });

  @override
  Widget build(BuildContext context) {
    final appText = context.theme.appTextTheme;
    final appColors = context.theme.appColors;

    return HtmlWidget(
      htmlContent,
      renderMode: RenderMode.column,
      textStyle: appText.sm,
      customStylesBuilder: (element) {
        if (element.localName == 'p') {
          return {
            'color': appColors.textPrimary.toHex(),
            'font-style': 'normal',
            'text-decoration': 'none',
          };
        } else if (element.localName == 'a') {
          return {
            'color': appColors.textAccent.toHex(),
          };
        } else if (element.localName == 'h1') {
          return {
            'color': appColors.textPrimary.toHex(),
            'font-style': 'normal',
            'text-decoration': 'none',
          };
        } else if (element.localName == 'h2') {
          return {
            'color': appColors.textPrimary.toHex(),
            'font-style': 'normal',
            'text-decoration': 'none',
          };
        } else if (element.localName == 'h3') {
          return {
            'color': appColors.textPrimary.toHex(),
            // 'font-style': 'normal',
            'text-decoration': 'none',
          };
        }
        return {
          'color': appColors.textPrimary.toHex(),
          'font-style': 'normal',
          'text-decoration': 'none',
        };
      },
      onTapUrl: (url) {
        launchUrl(Uri.parse(url));
        return true;
      },
    );
  }
}
