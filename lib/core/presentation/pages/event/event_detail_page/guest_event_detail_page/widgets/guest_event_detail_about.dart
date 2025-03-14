import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/common/html_display/html_display.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

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
        InkWell(
          onTap: () {
            AutoRouter.of(context).push(
              EventDescriptionFieldRoute(
                description: event.description ?? '',
                onSave: (value) async {},
              ),
            );
          },
          child: HtmlDisplay(htmlContent: event.description ?? ''),
        ),
      ],
    );
  }
}
