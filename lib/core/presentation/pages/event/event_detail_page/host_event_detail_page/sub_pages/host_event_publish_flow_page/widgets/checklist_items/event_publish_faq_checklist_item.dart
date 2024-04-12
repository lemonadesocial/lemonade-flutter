import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_frequent_question.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/widgets/checklist_items/checklist_item_base_widget.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class EventPublishFAQChecklistItem extends StatelessWidget {
  final bool fulfilled;
  final Event event;

  const EventPublishFAQChecklistItem({
    super.key,
    required this.fulfilled,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return CheckListItemBaseWidget(
      onTap: () => SnackBarUtils.showComingSoon(),
      title: t.event.eventPublish.addFAQ,
      icon: Assets.icons.icQuestion,
      fulfilled: fulfilled,
      child: event.frequentQuestions?.isNotEmpty == true
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...(event.frequentQuestions ?? []).asMap().entries.map((entry) {
                  final isLast =
                      entry.key == (event.frequentQuestions ?? []).length - 1;
                  return _FAQItem(
                    frequentQuestion: entry.value,
                    isLast: isLast,
                  );
                }),
              ],
            )
          : null,
    );
  }
}

class _FAQItem extends StatelessWidget {
  final EventFrequentQuestion frequentQuestion;
  final bool isLast;

  const _FAQItem({
    required this.frequentQuestion,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: isLast ? 0 : Spacing.small,
        ),
        child: Row(
          children: [
            Icon(
              Icons.arrow_right_outlined,
              color: colorScheme.onSecondary,
            ),
            Expanded(
              flex: 1,
              child: Text.rich(
                TextSpan(
                  text: frequentQuestion.question ?? '',
                  style: Typo.medium.copyWith(color: colorScheme.onSecondary),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
