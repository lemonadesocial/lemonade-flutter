import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/event/entities/event_story.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class EventStoryItem extends StatelessWidget {
  final EventStory eventStory;

  const EventStoryItem({
    super.key,
    required this.eventStory,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final photoUrl = ImageUtils.generateUrl(
      file: DbFile(
        url: eventStory.url,
        bucket: eventStory.bucket,
        key: eventStory.key,
        type: eventStory.type,
      ),
    );

    return Container(
      padding: EdgeInsets.symmetric(vertical: Spacing.small),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              ClipRRect(
                borderRadius: BorderRadius.circular(Sizing.medium),
                child: SizedBox(
                  width: Sizing.medium,
                  height: Sizing.medium,
                  child: ClipRRect(
                    child: CachedNetworkImage(
                      width: Sizing.medium,
                      height: Sizing.medium,
                      imageUrl: ImageUtils.generateUrl(
                        file:
                            (eventStory.ownerExpanded?.newPhotosExpanded ?? [])
                                .firstOrNull,
                      ),
                      placeholder: (context, url) =>
                          ImagePlaceholder.defaultPlaceholder(),
                      errorWidget: (_, __, ___) =>
                          ImagePlaceholder.defaultPlaceholder(),
                    ),
                  ),
                ),
              ),
              SizedBox(width: Spacing.extraSmall),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: eventStory.ownerExpanded?.name ??
                            eventStory.ownerExpanded?.username ??
                            '',
                        style: Typo.medium.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          if (eventStory.stamp != null)
                            TextSpan(
                              text: '  •  ${timeago.format(
                                DateTime.tryParse(eventStory.stamp!) ??
                                    DateTime.now(),
                              )}',
                              style: Typo.medium.copyWith(
                                color: colorScheme.onSecondary,
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: Spacing.extraSmall / 2),
                    Text(
                      eventStory.description ?? '',
                      style: Typo.medium.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                    ),
                    SizedBox(height: Spacing.xSmall),
                    Hero(
                      tag: photoUrl,
                      child: InkWell(
                        onTap: () {
                          AutoRouter.of(context).push(
                            PhotosGalleryRoute(
                              initialIndex: 0,
                              photos: [photoUrl],
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(LemonRadius.normal),
                          child: CachedNetworkImage(
                            imageUrl: photoUrl,
                            placeholder: (_, __) =>
                                Loading.defaultLoading(context),
                            errorWidget: (_, __, ___) =>
                                const SizedBox.shrink(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
