import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectSpotlightEventList extends StatefulWidget {
  const SelectSpotlightEventList({super.key});

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
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
          sliver: SliverList.separated(
            itemBuilder: (context, index) => const _EventItem(),
            separatorBuilder: (context, index) =>
                SizedBox(height: Spacing.xSmall),
            itemCount: 10,
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: Spacing.xLarge * 4),
        ),
      ],
    );
  }
}

class _EventItem extends StatelessWidget {
  const _EventItem();

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
            imageUrl: "",
            borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
            border: Border.all(color: colorScheme.outline),
            placeholder: ImagePlaceholder.defaultPlaceholder(
              radius: BorderRadius.circular(LemonRadius.extraSmall),
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Secret warehouse party",
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
          Assets.icons.icChecked.svg(),
        ],
      ),
    );
  }
}
