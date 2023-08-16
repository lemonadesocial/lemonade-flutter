import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../domain/event/entities/event.dart';
import '../../../../utils/date_format_utils.dart';
import '../../../../utils/image_utils.dart';
import '../../../widgets/image_placeholder_widget.dart';

class EventTileWidget extends StatelessWidget {
  const EventTileWidget({
    Key? key,
    required this.event,
    required this.onTap,
  }) : super(key: key);

  final Event event;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: ListTile(
        minLeadingWidth: 80,
        leading: SizedBox(
          width: 80,
          height: 48,
          child: CachedNetworkImage(
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (_, __) => ImagePlaceholder.eventCard(),
            errorWidget: (_, __, ___) => ImagePlaceholder.eventCard(),
            imageUrl: ImageUtils.generateUrl(
              file: event.newNewPhotosExpanded?.firstOrNull,
              imageConfig: ImageConfig.eventPhoto,
            ),
            imageBuilder: (context, imageProvider) {
              return Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: colorScheme.outline),
                  image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              );
            },
          ),
        ),
        title: Text(
          event.title ?? '',
          style: Typo.medium.copyWith(
            fontSize: 16,
            color: colorScheme.onPrimary,
          ),
        ),
        subtitle: Text(
          DateFormatUtils.fullDateWithTime(event.start),
          style: Typo.small.copyWith(color: colorScheme.onSecondary),
        ),
      ),
    );
  }
}
