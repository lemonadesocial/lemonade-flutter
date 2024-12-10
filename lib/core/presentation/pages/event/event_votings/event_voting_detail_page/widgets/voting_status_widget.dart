import 'package:app/core/domain/event/entities/event_voting.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class VotingStatusWidget extends StatelessWidget {
  final EventVoting voting;
  const VotingStatusWidget({
    super.key,
    required this.voting,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    if (voting.state == Enum$EventVotingState.starting) {
      return Text(
        t.event.eventVoting.debateStarting,
        style: Typo.medium.copyWith(
          color: LemonColor.coralReef,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    if (voting.state == Enum$EventVotingState.paused) {
      return Text(
        t.event.eventVoting.debatePaused,
        style: Typo.medium.copyWith(
          color: colorScheme.onSecondary,
        ),
      );
    }

    if (voting.state == Enum$EventVotingState.closed) {
      return Text(
        t.event.eventVoting.debateEnded,
        style: Typo.medium.copyWith(
          color: colorScheme.onSecondary,
        ),
      );
    }

    final durationFromNowToEvent =
        voting.start?.difference(DateTime.now()).inDays ?? 1;
    final isUpcoming = (voting.start ?? DateTime.now()).isAfter(DateTime.now());

    if (!isUpcoming) {
      return Text(
        t.event.eventStartedDaysAgo(days: durationFromNowToEvent.abs()),
        style: Typo.medium.copyWith(
          color: colorScheme.onSecondary,
        ),
      );
    }

    return Text.rich(
      TextSpan(
        text: StringUtils.capitalize(
          '${isUpcoming ? t.event.startingIn : t.common.started} ',
        ),
        style: Typo.medium.copyWith(
          color: colorScheme.onSecondary,
        ),
        children: [
          if (isUpcoming)
            TextSpan(
              text: t.common.day(n: durationFromNowToEvent),
              style: Typo.medium.copyWith(
                color: LemonColor.paleViolet,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }
}
