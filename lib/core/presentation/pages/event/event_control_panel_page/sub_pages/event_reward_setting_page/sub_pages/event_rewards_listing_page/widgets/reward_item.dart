import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/config.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/entities/reward.dart';
import 'package:app/core/presentation/dpos/common/dropdown_item_dpo.dart';
import 'package:app/core/presentation/widgets/floating_frosted_glass_dropdown_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/modal_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slang/builder/utils/string_extensions.dart';

class RewardItem extends StatelessWidget {
  final Reward reward;
  const RewardItem({
    super.key,
    required this.reward,
  });

  String getSubtitle(BuildContext context) {
    List<EventTicketType> eventTicketTypes =
        context.watch<GetEventDetailBloc>().state.maybeWhen(
                  fetched: (event) => event.eventTicketTypes,
                  orElse: () => [],
                ) ??
            [];
    List<String> paymentTicketTypes = reward.paymentTicketTypes ?? [];
    List<EventTicketType> selectedTypes = eventTicketTypes
        .where((type) => paymentTicketTypes.contains(type.id))
        .toList();
    String allTitles =
        selectedTypes.map((type) => type.title).toList().join(', ').toString();
    if (allTitles.isEmpty) {
      return '${t.event.rewardSetting.limit}: ${reward.limitPer} - ${t.event.allTicketTiers}';
    }
    return '${t.event.rewardSetting.limit}: ${reward.limitPer} - $allTitles';
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    final colorScheme = Theme.of(context).colorScheme;
    final fullIconUrl = '${AppConfig.assetPrefix}${reward.iconUrl}';
    return Row(
      children: [
        Container(
          width: Sizing.medium,
          height: Sizing.medium,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
            border: Border.all(
              color: LemonColor.chineseBlack,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              LemonRadius.small,
            ),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: fullIconUrl,
              placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(),
              errorWidget: (_, __, ___) =>
                  ImagePlaceholder.defaultPlaceholder(),
            ),
          ),
        ),
        SizedBox(width: Spacing.xSmall),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                reward.title ?? '',
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary.withOpacity(0.87),
                ),
              ),
              Text(
                getSubtitle(context),
                style: Typo.small.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        ),
        // Edit icon
        SizedBox(
          width: Sizing.medium,
          height: Sizing.medium,
          child: Center(
            child: FloatingFrostedGlassDropdown(
              offset: Offset(0, -Sizing.xSmall),
              items: [
                DropdownItemDpo(
                  leadingIcon: Assets.icons.icEdit.svg(
                    width: Sizing.xSmall,
                    height: Sizing.xSmall,
                    color: colorScheme.onPrimary,
                  ),
                  label: t.common.actions.edit.capitalize(),
                  value: "edit",
                ),
                DropdownItemDpo(
                  leadingIcon: Assets.icons.icDelete.svg(
                    width: Sizing.xSmall,
                    height: Sizing.xSmall,
                    color: colorScheme.onPrimary,
                  ),
                  label: t.common.delete.capitalize(),
                  value: "delete",
                ),
              ],
              onItemPressed: (item) {
                showComingSoonDialog(context);
              },
              child: ThemeSvgIcon(
                color: colorScheme.onPrimary,
                builder: (filter) => Assets.icons.icMoreHoriz.svg(
                  colorFilter: filter,
                  width: 24.w,
                  height: 24.w,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
