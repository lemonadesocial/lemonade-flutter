import 'package:app/core/data/event/dtos/event_voting_dto/event_voting_dto.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_voting.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/event/event_votings/event_voting_detail_page/widgets/voting_action_wiget.dart';
import 'package:app/core/presentation/pages/event/event_votings/event_voting_detail_page/widgets/voting_option_card.dart';
import 'package:app/core/presentation/pages/event/event_votings/event_voting_detail_page/widgets/voting_status_widget.dart';
import 'package:app/core/presentation/pages/event/event_votings/widgets/voting_bar_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/event/mutation/cast_vote.graphql.dart';
import 'package:app/graphql/backend/event/query/list_event_votings.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

@RoutePage()
class EventVotingDetailPage extends StatefulWidget {
  final EventVoting voting;
  final Event event;
  const EventVotingDetailPage({
    super.key,
    required this.voting,
    required this.event,
  });

  @override
  State<EventVotingDetailPage> createState() => _EventVotingDetailPageState();
}

class _EventVotingDetailPageState extends State<EventVotingDetailPage> {
  late EventVoting _voting;

  @override
  void initState() {
    super.initState();
    _voting = widget.voting;
  }

  VotingOption? get myVote {
    final userId = AuthUtils.getUserId(context);
    final myVote = _voting.votingOptions?.firstWhereOrNull(
      (option) => (option.voters ?? []).any((voter) => voter.userId == userId),
    );
    return myVote;
  }

  Future<void> _onVote(VotingOption option) async {
    await getIt<AppGQL>().client.mutate$CastVote(
          Options$Mutation$CastVote(
            fetchPolicy: FetchPolicy.networkOnly,
            variables: Variables$Mutation$CastVote(
              input: Input$CastVoteInput(
                voting_id: _voting.id ?? '',
                option_id: option.optionId,
              ),
            ),
          ),
        );

    final result = await getIt<AppGQL>().client.query$ListEventVotings(
          Options$Query$ListEventVotings(
            fetchPolicy: FetchPolicy.networkOnly,
            variables: Variables$Query$ListEventVotings(
              event: widget.event.id ?? '',
              votings: [_voting.id ?? ''],
            ),
          ),
        );
    final updatedVote = (result.parsedData?.listEventVotings ?? []).firstOrNull;
    if (updatedVote != null) {
      setState(() {
        _voting = EventVoting.fromDto(
          EventVotingDto.fromJson(
            updatedVote.toJson(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final option1 = _voting.votingOptions?[0];
    final option2 = _voting.votingOptions?[1];
    final speaker1 = _voting.speakers?.firstWhereOrNull(
      (speaker) => speaker.userId == option1?.optionId,
    );
    final speaker2 = _voting.speakers?.firstWhereOrNull(
      (speaker) => speaker.userId == option2?.optionId,
    );
    final option1Score = option1?.voters?.length ?? 0;
    final option2Score = option2?.voters?.length ?? 0;
    final winner = option1Score > option2Score ? speaker1 : speaker2;

    return Scaffold(
      appBar: const LemonAppBar(title: ''),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.small),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VotingStatusWidget(voting: _voting),
                      SizedBox(height: Spacing.superExtraSmall),
                      Text(
                        _voting.title ?? '',
                        style: Typo.extraLarge.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                      SizedBox(height: Spacing.smMedium),
                      Row(
                        children: [
                          ThemeSvgIcon(
                            color: colorScheme.onSecondary,
                            builder: (filter) => Assets.icons.icCalendarAlt.svg(
                              width: Sizing.mSmall,
                              height: Sizing.mSmall,
                              colorFilter: filter,
                            ),
                          ),
                          SizedBox(width: Spacing.small),
                          Text(
                            DateFormatUtils.dateWithTimezone(
                              dateTime: _voting.start ?? DateTime.now().toUtc(),
                              timezone: _voting.timezone ?? '',
                            ),
                            style: Typo.medium.copyWith(
                              color: colorScheme.onSecondary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Spacing.medium),
                      if (_voting.state == Enum$EventVotingState.closed) ...[
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(
                            Spacing.small,
                          ),
                          decoration: BoxDecoration(
                            color: LemonColor.atomicBlack,
                            borderRadius:
                                BorderRadius.circular(LemonRadius.medium),
                            border: Border.all(
                              color: colorScheme.outlineVariant,
                              width: 1.w,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LemonNetworkImage(
                                imageUrl: winner?.imageAvatar ?? '',
                                width: Sizing.medium,
                                height: Sizing.medium,
                                placeholder:
                                    ImagePlaceholder.avatarPlaceholder(),
                                borderRadius:
                                    BorderRadius.circular(Sizing.medium),
                              ),
                              SizedBox(height: Spacing.small),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: t.event.eventVoting.teamName(
                                        name: winner?.name ??
                                            winner?.displayName ??
                                            '',
                                      ),
                                      style: Typo.medium.copyWith(
                                        color:
                                            speaker1?.userId == winner?.userId
                                                ? LemonColor.blueBerry
                                                : LemonColor.royalOrange,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' ${t.event.eventVoting.won}',
                                      style: Typo.medium.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 2.w),
                              Text(
                                winner?.userId == myVote?.optionId
                                    ? t.event.eventVoting.correctVoteDescription
                                    : t.event.eventVoting.wrongVoteDescription,
                                style: Typo.small.copyWith(
                                  color: colorScheme.onSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Spacing.medium),
                      ],
                      Stack(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: VotingOptionCard(
                                  user: speaker1 ?? User(userId: ''),
                                  isLeft: true,
                                  isWinner: option1Score > option2Score &&
                                      _voting.state ==
                                          Enum$EventVotingState.closed,
                                ),
                              ),
                              SizedBox(width: Spacing.small),
                              Expanded(
                                flex: 1,
                                child: VotingOptionCard(
                                  user: speaker2 ?? User(userId: ''),
                                  isLeft: false,
                                  isWinner: option2Score > option1Score &&
                                      _voting.state ==
                                          Enum$EventVotingState.closed,
                                ),
                              ),
                            ],
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: colorScheme.background,
                                  borderRadius:
                                      BorderRadius.circular(Sizing.large),
                                ),
                                width: Sizing.large,
                                height: Sizing.large,
                                child: Center(
                                  child: Text(
                                    "VS",
                                    style: Typo.medium.copyWith(
                                      color: colorScheme.onPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Spacing.medium),
                if (myVote == null && _voting.description?.isNotEmpty == true)
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: colorScheme.outline,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: Spacing.small,
                      vertical: Spacing.medium,
                    ),
                    child: Text(
                      _voting.description ?? '',
                      style: Typo.medium.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                if (myVote != null)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.small),
                    child: _CurrentVotingResult(voting: _voting),
                  ),
                SizedBox(height: Spacing.xLarge * 3),
              ],
            ),
          ),
          VotingActionWidget(
            voting: _voting,
            myVote: myVote,
            onVote: _onVote,
          ),
        ],
      ),
    );
  }
}

class _CurrentVotingResult extends StatelessWidget {
  final EventVoting voting;
  const _CurrentVotingResult({
    required this.voting,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final option1 = voting.votingOptions?[0];
    final option2 = voting.votingOptions?[1];
    final speaker1 = voting.speakers?.firstWhereOrNull(
      (speaker) => speaker.userId == option1?.optionId,
    );
    final speaker2 = voting.speakers?.firstWhereOrNull(
      (speaker) => speaker.userId == option2?.optionId,
    );
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${option1?.voters?.length ?? 0} \n',
                    style: Typo.large.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  TextSpan(
                    text: t.event.eventVoting
                        .vote(n: option1?.voters?.length ?? 0),
                    style: Typo.medium.copyWith(color: colorScheme.onSecondary),
                  ),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${option2?.voters?.length ?? 0} \n',
                    style: Typo.large.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  TextSpan(
                    text: t.event.eventVoting
                        .vote(n: option2?.voters?.length ?? 0),
                    style: Typo.medium.copyWith(color: colorScheme.onSecondary),
                  ),
                ],
              ),
              textAlign: TextAlign.end,
            ),
          ],
        ),
        SizedBox(height: Spacing.xSmall),
        VotingBar(voting: voting),
        SizedBox(height: Spacing.xSmall),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t.event.eventVoting.teamName(
                name: speaker1?.name ?? speaker1?.displayName ?? '',
              ),
              style: Typo.medium.copyWith(color: colorScheme.onSecondary),
            ),
            Text(
              t.event.eventVoting.teamName(
                name: speaker2?.name ?? speaker2?.displayName ?? '',
              ),
              style: Typo.medium.copyWith(color: colorScheme.onSecondary),
            ),
          ],
        ),
      ],
    );
  }
}
