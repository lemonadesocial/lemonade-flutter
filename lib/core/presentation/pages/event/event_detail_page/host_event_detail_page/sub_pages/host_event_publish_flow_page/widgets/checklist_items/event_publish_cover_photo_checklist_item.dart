import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/widgets/checklist_items/checklist_item_base_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_utils.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventPublishCoverPhotoChecklistItem extends StatelessWidget {
  final bool fulfilled;
  final Event event;
  const EventPublishCoverPhotoChecklistItem({
    super.key,
    required this.fulfilled,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return CheckListItemBaseWidget(
      onTap: () {
        AutoRouter.of(context).push(EventPhotosSettingRoute());
      },
      title: t.event.eventPublish.addCoverPhoto,
      icon: Assets.icons.icCoverPhoto,
      fulfilled: fulfilled,
      child: fulfilled
          ? Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(3.w),
                  child: Container(
                    width: Sizing.xSmall,
                    height: Sizing.xSmall,
                    color: LemonColor.atomicBlack,
                    child: CachedNetworkImage(
                      width: Sizing.xSmall,
                      height: Sizing.xSmall,
                      imageUrl: EventUtils.getEventThumbnailUrl(event: event),
                      placeholder: (_, __) => ImagePlaceholder.ticketThumbnail(
                        iconSize: 8.w,
                      ),
                      errorWidget: (_, __, ___) =>
                          ImagePlaceholder.ticketThumbnail(
                        iconSize: 8.w,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: Spacing.xSmall),
                Expanded(
                  flex: 1,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: EventUtils.getEventThumbnailUrl(event: event)
                              .split('/')
                              .last,
                          style: Typo.medium
                              .copyWith(color: colorScheme.onSecondary),
                        ),
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ThemeSvgIcon(
                  color: colorScheme.onSecondary,
                  builder: (colorFilter) => Assets.icons.icEdit.svg(
                    colorFilter: colorFilter,
                    width: Sizing.xSmall,
                    height: Sizing.xSmall,
                  ),
                ),
              ],
            )
          : null,
    );
  }
}
