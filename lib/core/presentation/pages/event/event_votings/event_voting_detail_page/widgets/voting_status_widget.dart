import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_voting.dart';
import 'package:app/core/utils/event_utils.dart';
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
    String statusText = '';
    switch (voting.state) {
      case Enum$EventVotingState.paused:
        statusText = t.event.eventVoting.debatePaused;
      case Enum$EventVotingState.not_started:
        statusText = t.event.startingIn;
      case Enum$EventVotingState.closed:
        statusText = t.common.started;
      default:
        statusText = '';
    }
    final durationText = EventUtils.getDurationToEventText(
      Event(start: voting.start, end: voting.end, timezone: voting.timezone),
      durationOnly: true,
    );
    return Text.rich(
      TextSpan(
        text: '${StringUtils.capitalize(statusText)} ',
        style: Typo.medium.copyWith(
          color: colorScheme.onSecondary,
        ),
        children: [
          if (voting.state != Enum$EventVotingState.paused)
            TextSpan(
              text: durationText,
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
