import 'package:app/core/domain/event/entities/event_voting.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_votings_list/widgets/guest_event_detail_voting_item.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class GuestEventDetailVotingsList extends StatelessWidget {
  final Event event;
  final List<EventVoting> votings;
  final VoidCallback? onRefetch;
  const GuestEventDetailVotingsList({
    super.key,
    required this.event,
    required this.votings,
    this.onRefetch,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.smMedium,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.event.eventVoting.debates,
                style: Typo.extraMedium.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: Spacing.smMedium),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: votings.length,
            separatorBuilder: (context, index) {
              return SizedBox(height: Spacing.xSmall);
            },
            itemBuilder: (context, index) {
              return GuestEventDetailVotingItem(
                voting: votings[index],
                onRefetch: onRefetch,
              );
            },
          ),
        ],
      ),
    );
  }
}
