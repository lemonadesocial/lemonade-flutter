import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectSpotlightEventList extends StatefulWidget {
  final Future? futureRequest;
  final Function(Event event)? onToggleEvent;
  final List<String>? selectedEventIds;

  const SelectSpotlightEventList({
    super.key,
    this.futureRequest,
    this.onToggleEvent,
    this.selectedEventIds,
  });

  @override
  State<SelectSpotlightEventList> createState() =>
      _SelectSpotlightEventListState();
}

class _SelectSpotlightEventListState extends State<SelectSpotlightEventList>
    with AutomaticKeepAliveClientMixin<SelectSpotlightEventList> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(height: Spacing.smMedium),
        ),
        FutureBuilder(
          future: widget.futureRequest,
          builder: (context, snapshot) {
            final events = snapshot.data?.fold((l) => null, (event) => event);
            return SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
              sliver: SliverList.separated(
                itemBuilder: (context, index) {
                  final event = events?[index];
                  final isChecked =
                      widget.selectedEventIds?.contains(event?.id);
                  return _EventItem(
                    event: event,
                    onTap: () {
                      widget.onToggleEvent!(events[index]);
                    },
                    isChecked: isChecked,
                  );
                },
                separatorBuilder: (context, index) =>
                    SizedBox(height: Spacing.xSmall),
                itemCount: events?.length ?? 0,
              ),
            );
          },
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: Spacing.xLarge * 4),
        ),
      ],
    );
  }
}

class _EventItem extends StatelessWidget {
  final Event? event;
  final Function()? onTap;
  final bool? isChecked;
  const _EventItem({
    this.event,
    this.onTap,
    this.isChecked,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.small),
      decoration: BoxDecoration(
        color: LemonColor.white06,
        borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
      ),
      child: Row(
        children: [
          LemonNetworkImage(
            width: Sizing.medium,
            height: Sizing.medium,
            imageUrl: ImageUtils.generateUrl(
              file: event?.newNewPhotosExpanded?.firstOrNull,
              imageConfig: ImageConfig.eventPhoto,
            ),
            borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
            border: Border.all(color: colorScheme.outline),
            placeholder: ImagePlaceholder.eventCard(),
          ),
          SizedBox(width: Spacing.xSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event?.title ?? '',
                  style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.w),
                Text(
                  DateFormatUtils.fullDateWithTime(event?.start),
                  style: Typo.small.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: Spacing.smMedium,
          ),
          InkWell(
            onTap: () {
              onTap?.call();
            },
            child: isChecked == true
                ? Assets.icons.icChecked.svg()
                : Assets.icons.icUncheck.svg(),
          ),
        ],
      ),
    );
  }
}
