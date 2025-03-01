import 'package:app/core/domain/event/entities/event_guest_detail/event_guest_detail.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class EventGuestDetailApplicationQuestionsWidget extends StatelessWidget {
  final EventGuestDetail eventGuestDetail;

  const EventGuestDetailApplicationQuestionsWidget({
    super.key,
    required this.eventGuestDetail,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final applications = eventGuestDetail.application ?? [];
    final t = Translations.of(context);
    if (applications.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.event.eventGuestDetail.applicationQuestions,
          style: Typo.large.copyWith(
            color: colorScheme.onPrimary,
          ),
        ),
        SizedBox(height: Spacing.medium),
        ...applications.map(
          (qa) => _QuestionAnswerItem(
            question: qa.question,
            answers: qa.answers ?? [],
          ),
        ),
      ],
    );
  }
}

class _QuestionAnswerItem extends StatelessWidget {
  final String question;
  final List<String> answers;

  const _QuestionAnswerItem({
    required this.question,
    required this.answers,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (answers.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.only(bottom: Spacing.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: Typo.medium.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
          SizedBox(height: Spacing.superExtraSmall),
          Linkify(
            text: answers.join(', '),
            style: Typo.medium.copyWith(
              color: colorScheme.onPrimary,
            ),
            linkStyle: Typo.medium.copyWith(
              color: LemonColor.paleViolet,
              decoration: TextDecoration.none,
            ),
            onOpen: (link) async {
              await launchUrl(Uri.parse(link.url));
            },
          ),
        ],
      ),
    );
  }
}
