import 'package:app/core/domain/event/entities/event_voting.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/horizontal_slidable_button/horizontal_slidable_button.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collection/collection.dart';

class VotingActionWidget extends StatefulWidget {
  final EventVoting voting;
  final VotingOption? myVote;
  final Future<void> Function(VotingOption option)? onVote;
  const VotingActionWidget({
    super.key,
    required this.voting,
    this.myVote,
    this.onVote,
  });

  @override
  State<VotingActionWidget> createState() => _VotingActionWidgetState();
}

class _VotingActionWidgetState extends State<VotingActionWidget> {
  bool updateVoteRequested = false;
  bool isProcessing = false;
  VotingOption? selectedOption;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final option1 = widget.voting.votingOptions?[0];
    final option2 = widget.voting.votingOptions?[1];
    final speaker1 = widget.voting.speakers?.firstWhereOrNull(
      (speaker) => speaker.userId == option1?.optionId,
    );
    final speaker2 = widget.voting.speakers?.firstWhereOrNull(
      (speaker) => speaker.userId == option2?.optionId,
    );

    if (widget.voting.state == Enum$EventVotingState.closed ||
        widget.voting.state == Enum$EventVotingState.paused) {
      return const SizedBox.shrink();
    }

    if (widget.voting.state == Enum$EventVotingState.not_started) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            top: Spacing.smMedium,
            left: Spacing.small,
            right: Spacing.small,
          ),
          decoration: BoxDecoration(
            color: colorScheme.background,
            border: Border(
              top: BorderSide(
                color: colorScheme.outline,
              ),
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  t.event.eventVoting.votingNotOpenYet,
                  style: Typo.medium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onPrimary,
                  ),
                ),
                Text(
                  t.event.eventVoting.votingNotOpenYetDescription,
                  style: Typo.small.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          top: Spacing.smMedium,
          left: Spacing.small,
          right: Spacing.small,
        ),
        decoration: BoxDecoration(
          color: colorScheme.background,
          border: Border(
            top: BorderSide(
              color: colorScheme.outline,
            ),
          ),
        ),
        child: SafeArea(
          child: (widget.myVote != null && !updateVoteRequested)
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        LemonNetworkImage(
                          width: Sizing.medium,
                          height: Sizing.medium,
                          borderRadius: BorderRadius.circular(Sizing.medium),
                          imageUrl: widget.myVote?.optionId == option1?.optionId
                              ? speaker1?.imageAvatar ?? ''
                              : speaker2?.imageAvatar ?? '',
                          placeholder: ImagePlaceholder.avatarPlaceholder(),
                        ),
                        SizedBox(width: Spacing.small),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: "${t.event.eventVoting.youAreFor} ",
                                children: [
                                  TextSpan(
                                    text: t.event.eventVoting.teamName(
                                      name: widget.myVote?.optionId ==
                                              option1?.optionId
                                          ? speaker1?.name ?? ''
                                          : speaker2?.name ?? '',
                                    ),
                                    style: Typo.medium.copyWith(
                                      color: widget.myVote?.optionId ==
                                              option1?.optionId
                                          ? LemonColor.blueBerry
                                          : LemonColor.royalOrange,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              style: Typo.medium.copyWith(
                                color: colorScheme.onPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2.w),
                            Text(
                              t.event.eventVoting.waitingResultDescription,
                              style: Typo.small.copyWith(
                                color: colorScheme.onSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: Spacing.small),
                    LinearGradientButton.secondaryButton(
                      height: Sizing.xLarge,
                      label: t.event.eventVoting.changeVote,
                      mode: GradientButtonMode.light,
                      radius: BorderRadius.circular(Sizing.xLarge),
                      onTap: () {
                        setState(() {
                          updateVoteRequested = true;
                        });
                      },
                    ),
                  ],
                )
              : isProcessing
                  ? Container(
                      height: Sizing.xLarge,
                      decoration: BoxDecoration(
                        color: selectedOption?.optionId == option1?.optionId
                            ? LemonColor.blueBerry
                            : LemonColor.royalOrange,
                        borderRadius: BorderRadius.circular(Sizing.xLarge),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: Sizing.xSmall,
                            height: Sizing.xSmall,
                            child: CircularProgressIndicator(
                              backgroundColor:
                                  LemonColor.black.withOpacity(0.36),
                              color: LemonColor.white.withOpacity(0.72),
                            ),
                          ),
                          SizedBox(width: Spacing.extraSmall),
                          Text(
                            t.event.eventVoting.castingVote,
                            style: Typo.mediumPlus.copyWith(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                  : HorizontalSlidableButton(
                      initialPosition: SlidableButtonPosition.center,
                      height: Sizing.xLarge,
                      width: double.infinity,
                      color: LemonColor.chineseBlack,
                      dismissible: false,
                      buttonWidth: Sizing.large,
                      buttonHeight: Sizing.large,
                      buttonColor: Colors.white,
                      centerPoint: true,
                      label: Center(
                        child: Assets.icons.icArrowOutward.svg(),
                      ),
                      child: Container(
                        height: 60.w,
                        padding:
                            EdgeInsets.symmetric(horizontal: Spacing.medium),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  t.common.actions.vote,
                                  style: Typo.medium.copyWith(
                                    color: LemonColor.blueBerry,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 2.w),
                                Text(
                                  speaker1?.name ?? '',
                                  style: Typo.medium
                                      .copyWith(color: colorScheme.onSecondary),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  t.common.actions.vote,
                                  style: Typo.medium.copyWith(
                                    color: LemonColor.royalOrange,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 2.w),
                                Text(
                                  speaker2?.name ?? '',
                                  style: Typo.medium
                                      .copyWith(color: colorScheme.onSecondary),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      onChanged: (position) async {
                        setState(() {
                          isProcessing = true;
                          selectedOption =
                              position == SlidableButtonPosition.start
                                  ? option1
                                  : option2;
                        });
                        if (position == SlidableButtonPosition.start) {
                          await widget.onVote?.call(option1!);
                        } else if (position == SlidableButtonPosition.end) {
                          await widget.onVote?.call(option2!);
                        }
                        setState(() {
                          isProcessing = false;
                          updateVoteRequested = false;
                        });
                      },
                    ),
        ),
      ),
    );
  }
}
