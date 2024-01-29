import 'package:app/core/domain/event/entities/event_accepted_export.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class EventAcceptedExportItem extends StatelessWidget {
  final EventAcceptedExport eventAccepted;
  const EventAcceptedExportItem({
    super.key,
    required this.eventAccepted,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(LemonRadius.button),
        color: LemonColor.atomicBlack,
      ),
      padding: EdgeInsets.symmetric(
        vertical: Spacing.xSmall,
        horizontal: Spacing.xSmall,
      ),
      child: Row(
        children: [
          Row(
            children: [
              SizedBox(width: Spacing.extraSmall),
              Text(
                eventAccepted.username ??
                    eventAccepted.name ??
                    t.common.anonymous,
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
