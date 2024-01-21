import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/config.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/entities/reward.dart';
import 'package:app/core/domain/event/repository/event_reward_repository.dart';
import 'package:app/core/presentation/dpos/common/dropdown_item_dpo.dart';
import 'package:app/core/presentation/widgets/floating_frosted_glass_dropdown_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/modal_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slang/builder/utils/string_extensions.dart';

enum RewardOptions { edit, delete }

class RewardItem extends StatelessWidget {
  final Reward reward;
  const RewardItem({
    super.key,
    required this.reward,
  });

  Future<void> onPressDelete(BuildContext context) async {
    final rewards = context.read<GetEventDetailBloc>().state.maybeWhen(
              fetched: (event) => event.rewards,
              orElse: () => [] as List<Reward>,
            ) ??
        [];
    final eventId = context.read<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => '',
          fetched: (eventDetail) => eventDetail.id ?? '',
        );
    final newRewards =
        rewards.where((element) => element.id != reward.id).toList();
    showFutureLoadingDialog(
      context: context,
      future: () async {
        final result = await getIt<EventRewardRepository>().deleteEventReward(
          eventId: eventId,
          input: [
            ...newRewards
                .map(
                  (reward) => Input$EventRewardInput(
                    $_id: reward.id,
                    active: reward.active!,
                    title: reward.title!,
                    limit: reward.limit?.toDouble(),
                    limit_per: reward.limitPer!.toDouble(),
                    icon_color: reward.iconColor,
                    icon_url: reward.iconUrl,
                  ),
                )
                .toList(),
          ],
        );
        if (result.isRight()) {
          context.read<GetEventDetailBloc>().add(
                GetEventDetailEvent.fetch(eventId: eventId),
              );
        }
      },
    );
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
              SizedBox(
                height: Spacing.superExtraSmall / 2,
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
                  value: RewardOptions.edit,
                ),
                DropdownItemDpo(
                  leadingIcon: Assets.icons.icDelete.svg(
                    width: Sizing.xSmall,
                    height: Sizing.xSmall,
                    color: colorScheme.onPrimary,
                  ),
                  label: t.common.delete.capitalize(),
                  value: RewardOptions.delete,
                ),
              ],
              onItemPressed: (item) {
                switch (item?.value) {
                  case RewardOptions.delete:
                    onPressDelete(context);
                  case RewardOptions.edit:
                    showComingSoonDialog(context);
                  default:
                    showComingSoonDialog(context);
                }
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
}
