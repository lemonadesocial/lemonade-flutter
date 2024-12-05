import 'package:app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';

class HtmlDisplay extends StatelessWidget {
  final String htmlContent;

  const HtmlDisplay({
    super.key,
    required this.htmlContent,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return HtmlWidget(
      htmlContent,
      renderMode: RenderMode.column,
      textStyle: Theme.of(context).textTheme.bodyMedium,
      customStylesBuilder: (element) {
        if (element.localName == 'p') {
          return {
            'color': colorScheme.onPrimary.toHex(),
            'font-style': 'normal',
            'text-decoration': 'none',
          };
        } else if (element.localName == 'a') {
          return {
            'color': LemonColor.paleViolet.toHex(),
          };
        } else if (element.localName == 'h1') {
          return {
            'color': colorScheme.onPrimary.toHex(),
            'font-style': 'normal',
            'text-decoration': 'none',
          };
        } else if (element.localName == 'h2') {
          return {
            'color': colorScheme.onPrimary.toHex(),
            'font-style': 'normal',
            'text-decoration': 'none',
          };
        } else if (element.localName == 'h3') {
          return {
            'color': colorScheme.onPrimary.toHex(),
            'font-style': 'normal',
            'text-decoration': 'none',
          };
        }
        return {
          'color': colorScheme.onPrimary.toHex(),
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
