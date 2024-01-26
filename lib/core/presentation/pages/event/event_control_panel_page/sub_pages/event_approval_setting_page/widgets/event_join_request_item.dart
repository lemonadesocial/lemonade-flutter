import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class EventJoinRequestItem extends StatelessWidget {
  final EventJoinRequest eventJoinRequest;
  final Widget Function()? actionBarBuilder;

  const EventJoinRequestItem({
    super.key,
    required this.eventJoinRequest,
    this.actionBarBuilder,
  });

  @override
  Widget build(BuildContext context) {
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
          Text(eventJoinRequest.userExpanded?.displayName ?? ''),
          const Spacer(),
          if (actionBarBuilder != null) actionBarBuilder!.call(),
        ],
      ),
    );
  }
}
