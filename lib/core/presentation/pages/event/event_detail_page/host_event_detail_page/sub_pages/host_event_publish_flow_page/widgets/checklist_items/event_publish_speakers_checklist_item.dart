import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/widgets/checklist_items/checklist_item_base_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EventPublishSpeakersChecklistItem extends StatelessWidget {
  final bool fulfilled;
  final Event event;

  const EventPublishSpeakersChecklistItem({
    super.key,
    required this.fulfilled,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final speakers =
        (event.speakerUsersExpanded ?? []).where((element) => element != null).cast<User>().toList().asMap().entries;

    return CheckListItemBaseWidget(
      onTap: () => AutoRouter.of(context).push(
        const EventSpeakersRoute(),
      ),
      title: t.event.eventPublish.addSpeakers,
      icon: Assets.icons.icSpeakerMic,
      fulfilled: fulfilled,
      child: speakers.isNotEmpty ? Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...speakers.map((entry) {
            return _SpeakerItem(
              speaker: entry.value,
              isLast: entry.key == speakers.length - 1,
            );
          }),
        ],
      ) : null,
    );
  }
}

class _SpeakerItem extends StatelessWidget {
  final User speaker;
  final bool isLast;
  const _SpeakerItem({
    required this.isLast,
    required this.speaker,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isMe = AuthUtils.isMe(context, user: speaker);
    return InkWell(
      onTap: () => AutoRouter.of(context).push(
        ProfileRoute(userId: speaker.userId),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: isLast ? 0 : Spacing.small,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Sizing.xSmall),
              child: Container(
                width: Sizing.xSmall,
                height: Sizing.xSmall,
                color: LemonColor.atomicBlack,
                child: CachedNetworkImage(
                  width: Sizing.xSmall,
                  height: Sizing.xSmall,
                  imageUrl: speaker.newPhotosExpanded?.isNotEmpty == true
                      ? ImageUtils.generateUrl(
                          file: speaker.newPhotosExpanded?.first,
                        )
                      : '',
                  placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(),
                  errorWidget: (_, __, ___) => ImagePlaceholder.defaultPlaceholder(),
                ),
              ),
            ),
            SizedBox(width: Spacing.xSmall),
            Expanded(
              flex: 1,
              child: Text.rich(
                TextSpan(
                  text: speaker.name ?? speaker.email ?? '',
                  style: Typo.medium.copyWith(color: colorScheme.onSecondary),
                  children: [
                    if (isMe)
                      TextSpan(
                        text: ' (${t.common.you})',
                        style: Typo.medium.copyWith(
                          color: colorScheme.onPrimary.withOpacity(
                            0.24,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
