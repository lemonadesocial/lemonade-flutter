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
    return HtmlWidget(
      htmlContent,
      renderMode: RenderMode.column,
      textStyle: Theme.of(context).textTheme.bodyMedium,
      onTapUrl: (url) {
        launchUrl(Uri.parse(url));
        return true;
      },
    );
  }
}
