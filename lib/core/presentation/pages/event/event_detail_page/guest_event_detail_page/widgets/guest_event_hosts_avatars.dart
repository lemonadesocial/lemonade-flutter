import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/theme/sizing.dart';
import 'package:flutter/material.dart';

class GuestEventHostsAvatars extends StatelessWidget {
  final Event event;
  const GuestEventHostsAvatars({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hosts = [
      ...event.cohostsExpanded ?? [],
      event.hostExpanded,
    ];
    return SizedBox(
      width: (1 + 1 / 2 * (hosts.length - 1)) * Sizing.small,
      height: Sizing.small,
      child: Stack(
        children: hosts.asMap().entries.map((entry) {
          final url = entry.value?.imageAvatar;
          return Positioned(
            right: entry.key * 12,
            child: Container(
              width: Sizing.small,
              height: Sizing.small,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                border: Border.all(color: colorScheme.outline),
                borderRadius: BorderRadius.circular(Sizing.small),
              ),
              child: LemonNetworkImage(
                width: Sizing.small,
                height: Sizing.small,
                borderRadius: BorderRadius.circular(Sizing.small),
                imageUrl: url ?? '',
                placeholder: ImagePlaceholder.avatarPlaceholder(),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
