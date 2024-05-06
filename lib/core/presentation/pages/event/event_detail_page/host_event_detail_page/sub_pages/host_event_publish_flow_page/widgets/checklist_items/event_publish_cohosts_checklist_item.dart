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

class EventPublishCohostsChecklistItem extends StatelessWidget {
  final bool fulfilled;
  final Event event;
  const EventPublishCohostsChecklistItem({
    super.key,
    required this.fulfilled,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final hosts = [
      event.hostExpanded,
      ...(event.cohostsExpanded ?? []),
    ].where((element) => element != null).cast<User>().toList().asMap().entries;

    return CheckListItemBaseWidget(
      onTap: () => AutoRouter.of(context).push(
        const EventCohostsSettingRoute(),
      ),
      title: t.event.eventPublish.addCohosts,
      icon: Assets.icons.icHostOutline,
      fulfilled: fulfilled,
      child: hosts.isNotEmpty
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...hosts.map((entry) {
                  return _CohostItem(
                    host: entry.value,
                    isLast: entry.key == hosts.length - 1,
                  );
                }),
              ],
            )
          : null,
    );
  }
}

class _CohostItem extends StatelessWidget {
  final User host;
  final bool isLast;
  const _CohostItem({required this.isLast, required this.host});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isMe = AuthUtils.isMe(context, user: host);
    return InkWell(
      onTap: () => AutoRouter.of(context).push(
        ProfileRoute(userId: host.userId),
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
                  imageUrl: host.newPhotosExpanded?.isNotEmpty == true
                      ? ImageUtils.generateUrl(
                          file: host.newPhotosExpanded?.firstOrNull,
                        )
                      : '',
                  placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(),
                  errorWidget: (_, __, ___) =>
                      ImagePlaceholder.defaultPlaceholder(),
                ),
              ),
            ),
            SizedBox(width: Spacing.xSmall),
            Expanded(
              flex: 1,
              child: Text.rich(
                TextSpan(
                  text: host.name ?? host.email ?? '',
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
