import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/get_events_listing_input.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectSpotlightEventList extends StatefulWidget {
  final Future? futureRequest;

  const SelectSpotlightEventList({super.key, this.futureRequest});

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
                  return _EventItem(event: event);
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
  const _EventItem({this.event});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.small),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
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
                  DateFormatUtils.fullDateWithTime(DateTime.now()),
                  style: Typo.xSmall.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: Spacing.smMedium,
          ),
          Assets.icons.icChecked.svg(),
        ],
      ),
    );
  }
}
