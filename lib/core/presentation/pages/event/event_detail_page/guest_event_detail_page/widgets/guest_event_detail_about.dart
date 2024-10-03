import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class GuestEventDetailAbout extends StatelessWidget {
  const GuestEventDetailAbout({
    super.key,
    required this.event,
    this.showTitle = true,
  });

  final Event event;
  final bool showTitle;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showTitle) ...[
          Text(
            t.event.about,
            style: Typo.extraMedium.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: Spacing.xSmall,
          ),
        ],
        MarkdownBody(
          data: event.description ?? '',
          styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
            p: Typo.medium.copyWith(
              color: colorScheme.onPrimary,
              fontStyle: FontStyle.normal,
              decoration: TextDecoration.none,
            ),
            a: Typo.small.copyWith(
              color: LemonColor.paleViolet,
            ),
            h1: Typo.extraLarge.copyWith(
              color: colorScheme.onPrimary,
              fontStyle: FontStyle.normal,
              decoration: TextDecoration.none,
            ),
            h2: Typo.large.copyWith(
              color: colorScheme.onPrimary,
              fontStyle: FontStyle.normal,
              decoration: TextDecoration.none,
            ),
            h3: Typo.extraMedium.copyWith(
              color: colorScheme.onPrimary,
              fontStyle: FontStyle.normal,
              decoration: TextDecoration.none,
            ),
          ),
          onTapLink: (text, href, title) {
            if (href != null) {
              launchUrl(Uri.parse(href));
            }
          },
        ),
      ],
    );
  }
}
