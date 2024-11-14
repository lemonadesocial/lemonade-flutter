import 'package:app/core/domain/event/entities/event_voting.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VotingBar extends StatelessWidget {
  final EventVoting voting;
  const VotingBar({
    super.key,
    required this.voting,
  });

  @override
  Widget build(BuildContext context) {
    final option1 = voting.votingOptions?.firstWhereOrNull(
      (option) => option.optionId == voting.speakers?[0].userId,
    );
    final option2 = voting.votingOptions?.firstWhereOrNull(
      (option) => option.optionId == voting.speakers?[1].userId,
    );

    return Row(
      children: [
        Expanded(
          flex: option1?.voters?.length ?? 1,
          child: Container(
            height: 6.w,
            decoration: BoxDecoration(
              color: LemonColor.blueBerry,
              borderRadius: BorderRadius.circular(LemonRadius.medium),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Container(
            width: 6.w,
            height: 6.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(LemonRadius.medium),
            ),
          ),
        ),
        Expanded(
          flex: option2?.voters?.length ?? 1,
          child: Container(
            height: 6.w,
            decoration: BoxDecoration(
              color: LemonColor.royalOrange,
              borderRadius: BorderRadius.circular(LemonRadius.medium),
            ),
          ),
        ),
      ],
    );
  }
}
