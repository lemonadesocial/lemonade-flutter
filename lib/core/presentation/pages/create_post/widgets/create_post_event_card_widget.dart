import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../theme/spacing.dart';
import '../../../../../theme/typo.dart';
import '../../../../domain/event/entities/event.dart';
import '../../../../utils/date_format_utils.dart';
import '../../../../utils/image_utils.dart';
import '../../../widgets/image_placeholder_widget.dart';
import '../../../widgets/lemon_circle_avatar_widget.dart';
import '../../../widgets/theme_svg_icon_widget.dart';

class CreatePostEventCardWidget extends StatelessWidget {
  const CreatePostEventCardWidget({
    Key? key,
    required this.event,
    required this.onDismiss,
  }) : super(key: key);

  final Event event;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: colorScheme.outline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (event.newNewPhotosExpanded?.isNotEmpty ?? false)
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: CachedNetworkImage(
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => ImagePlaceholder.eventCard(),
                    errorWidget: (_, __, ___) => ImagePlaceholder.eventCard(),
                    imageUrl: ImageUtils.generateUrl(
                      file: event.newNewPhotosExpanded?.first,
                      imageConfig: ImageConfig.eventPhoto,
                    ),
                  ),
                )
              else
                ImagePlaceholder.eventCard(),
              SizedBox(height: Spacing.small),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                child: Text(
                  event.title ?? '',
                  style: Typo.medium.copyWith(
                    fontSize: 16,
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                child: Text(
                  DateFormatUtils.fullDateWithTime(event.start),
                  style: Typo.small.copyWith(color: colorScheme.onSecondary),
                ),
              ),
              SizedBox(height: Spacing.xSmall),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                child: LemonCircleAvatar(
                  url: ImageUtils.generateUrl(
                      file: event.hostExpanded?.newPhotosExpanded?.first,
                      imageConfig: ImageConfig.profile),
                  label: event.hostExpanded?.name ?? '',
                ),
              ),
              SizedBox(height: Spacing.xSmall),
            ],
          ),
        ),
        Positioned(
          top: 9,
          left: 9,
          child: InkWell(
            onTap: onDismiss,
            child: Container(
              padding: EdgeInsets.all(Spacing.extraSmall),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: colorScheme.outline),
              ),
              child: ThemeSvgIcon(
                color: colorScheme.onSurface,
                builder: (filter) =>
                    Assets.icons.icClose.svg(colorFilter: filter),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
