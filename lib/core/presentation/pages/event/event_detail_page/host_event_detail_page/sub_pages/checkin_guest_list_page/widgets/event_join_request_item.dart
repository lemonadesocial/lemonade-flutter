import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
    final t = Translations.of(context);
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
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Sizing.medium),
                child: CachedNetworkImage(
                  width: Sizing.medium,
                  height: Sizing.medium,
                  imageUrl: eventJoinRequest.userExpanded?.imageAvatar ?? '',
                  placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(),
                  errorWidget: (_, __, ___) =>
                      ImagePlaceholder.defaultPlaceholder(),
                ),
              ),
              SizedBox(width: Spacing.extraSmall),
              Text(
                eventJoinRequest.userExpanded?.username ??
                    eventJoinRequest.userExpanded?.displayName ??
                    t.common.anonymous,
              ),
            ],
          ),
          const Spacer(),
          if (actionBarBuilder != null) actionBarBuilder!.call(),
        ],
      ),
    );
  }
}
