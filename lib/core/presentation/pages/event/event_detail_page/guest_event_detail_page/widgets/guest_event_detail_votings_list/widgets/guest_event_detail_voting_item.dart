import 'dart:async';

import 'package:app/core/domain/event/entities/event_voting.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/event/event_votings/widgets/voting_bar_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collection/collection.dart';

class GuestEventDetailVotingItem extends StatefulWidget {
  final EventVoting voting;
  final VoidCallback? onRefetch;
  final VoidCallback? onTap;
  const GuestEventDetailVotingItem({
    super.key,
    required this.voting,
    this.onRefetch,
    this.onTap,
  });

  @override
  State<GuestEventDetailVotingItem> createState() =>
      _GuestEventDetailVotingItemState();
}

class _GuestEventDetailVotingItemState
    extends State<GuestEventDetailVotingItem> {
  late final StreamSubscription<String> _votingUpdateSubscription;

  @override
  void initState() {
    super.initState();
    _subscribeToVotingUpdates();
  }

  void _subscribeToVotingUpdates() {
    _votingUpdateSubscription = getIt<EventRepository>()
        .watchEventVotingUpdated(votingId: widget.voting.id ?? '')
        .listen((votingId) {
      if (votingId.isNotEmpty && votingId == widget.voting.id) {
        widget.onRefetch?.call();
      }
    });
  }

  @override
  void dispose() {
    _votingUpdateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final option1 = widget.voting.votingOptions?.firstWhereOrNull(
      (option) => option.optionId == widget.voting.speakers?[0].userId,
    );
    final option2 = widget.voting.votingOptions?.firstWhereOrNull(
      (option) => option.optionId == widget.voting.speakers?[1].userId,
    );
    final option1Score = option1?.voters?.length ?? 0;
    final option2Score = option2?.voters?.length ?? 0;

    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: LemonColor.atomicBlack,
          border: Border.all(
            color: colorScheme.outlineVariant,
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(LemonRadius.medium),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _VotingTitle(voting: widget.voting),
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: Spacing.small,
                    right: Spacing.small,
                    top: Spacing.small,
                  ),
                  child: Row(
                    children: widget.voting.speakers?.asMap().entries.map(
                          (entry) {
                            final index = entry.key;
                            final isWinner = index == 0
                                ? option1Score > option2Score
                                : option2Score > option1Score;
                            return Expanded(
                              flex: 1,
                              child: _VotingOptionInfo(
                                user: entry.value,
                                alignment: index == 0
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.end,
                                hasWinnerBadge: isWinner &&
                                    widget.voting.state ==
                                        Enum$EventVotingState.closed,
                              ),
                            );
                          },
                        ).toList() ??
                        [],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(top: Spacing.small * 2),
                    child: _VotingScores(
                      voting: widget.voting,
                    ),
                  ),
                ),
              ],
            ),
            if (widget.voting.state == Enum$EventVotingState.starting)
              Padding(
                padding: EdgeInsets.all(Spacing.small),
                child: VotingBar(
                  voting: widget.voting,
                ),
              ),
            if (widget.voting.state != Enum$EventVotingState.starting) ...[
              SizedBox(height: Spacing.small),
            ],
          ],
        ),
      ),
    );
  }
}

class _VotingTitle extends StatelessWidget {
  final EventVoting voting;
  const _VotingTitle({
    required this.voting,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Spacing.small),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant,
            width: 1.w,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            voting.title ?? '',
            style: Typo.medium.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.w),
          if (voting.state == Enum$EventVotingState.starting)
            Text(
              t.event.eventVoting.debateStarting.toUpperCase(),
              style: Typo.small.copyWith(
                color: LemonColor.coralReef,
                fontWeight: FontWeight.w600,
              ),
            ),
          if (voting.state == Enum$EventVotingState.not_started)
            Text(
              DateFormatUtils.dateWithTimezone(
                dateTime: voting.start ?? DateTime.now().toUtc(),
                timezone: voting.timezone ?? '',
              ),
              style: Typo.small.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
          if (voting.state == Enum$EventVotingState.closed ||
              voting.state == Enum$EventVotingState.paused)
            Text(
              voting.state == Enum$EventVotingState.closed
                  ? t.event.eventVoting.debateEnded
                  : t.event.eventVoting.debatePaused,
              style: Typo.small.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
        ],
      ),
    );
  }
}

class _VotingOptionInfo extends StatelessWidget {
  final User user;
  final CrossAxisAlignment alignment;
  final bool hasWinnerBadge;
  const _VotingOptionInfo({
    required this.user,
    this.alignment = CrossAxisAlignment.start,
    this.hasWinnerBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: alignment,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            LemonNetworkImage(
              imageUrl: user.imageAvatar ?? '',
              width: Sizing.xLarge,
              height: Sizing.xLarge,
              borderRadius: BorderRadius.circular(Sizing.xLarge),
              border: Border.all(
                color: colorScheme.onPrimary,
                width: 2.w,
              ),
              placeholder: ImagePlaceholder.avatarPlaceholder(),
            ),
            if (hasWinnerBadge)
              Positioned(
                right: -5.w,
                top: 0.w,
                child: Assets.icons.icWinnerBadge.svg(),
              ),
          ],
        ),
        SizedBox(height: Spacing.xSmall),
        Text(
          user.name ?? user.displayName ?? '',
          style: Typo.medium.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (user.jobTitle?.isNotEmpty == true) ...[
          SizedBox(height: 2.w),
          Text(
            user.jobTitle ?? '',
            style: Typo.small.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
        ],
      ],
    );
  }
}

class _VotingScores extends StatelessWidget {
  final EventVoting voting;
  const _VotingScores({
    required this.voting,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final option1 = voting.votingOptions?.firstWhereOrNull(
      (option) => option.optionId == voting.speakers?[0].userId,
    );
    final option2 = voting.votingOptions?.firstWhereOrNull(
      (option) => option.optionId == voting.speakers?[1].userId,
    );
    final option1Score = option1?.voters?.length ?? 0;
    final option2Score = option2?.voters?.length ?? 0;
    if (voting.state == Enum$EventVotingState.paused ||
        voting.state == Enum$EventVotingState.not_started) {
      return Text(
        'VS',
        style: Typo.large.copyWith(
          color: colorScheme.onSecondary,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: option1Score.toString(),
            style: Typo.large.copyWith(
              color: option1Score > option2Score
                  ? LemonColor.royalOrange
                  : colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: ' - ',
            style: Typo.large.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: option2Score.toString(),
            style: Typo.large.copyWith(
              color: option2Score > option1Score
                  ? LemonColor.royalOrange
                  : colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
