import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event/modify_reward_bloc/modify_reward_bloc.dart';
import 'package:app/core/config.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/entities/reward.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_reward_setting_page/sub_pages/event_create_reward_page/widgets/select_reward_icon_form.dart';
import 'package:app/core/presentation/pages/setting/widgets/setting_tile_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CreateRewardBasicInfoForm extends StatefulWidget {
  final Reward? initialReward;
  const CreateRewardBasicInfoForm({super.key, this.initialReward});

  @override
  State<CreateRewardBasicInfoForm> createState() =>
      _CreateRewardBasicInfoFormState();
}

class _CreateRewardBasicInfoFormState extends State<CreateRewardBasicInfoForm> {
  bool selectedAllTicketTiers = false;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    List<EventTicketType> eventTicketTypes =
        context.watch<GetEventDetailBloc>().state.maybeWhen(
                  fetched: (event) => event.eventTicketTypes,
                  orElse: () => [],
                ) ??
            [];
    final modifyRewardBloc = context.read<ModifyRewardBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<ModifyRewardBloc, ModifyRewardState>(
          builder: (context, state) {
            return LemonTextField(
              initialText: modifyRewardBloc.initialReward?.title ?? '',
              onChange: (value) {
                modifyRewardBloc.add(
                  ModifyRewardEvent.onTitleChanged(
                    title: value,
                  ),
                );
              },
              errorText: state.title.displayError
                  ?.getMessage(t.event.rewardSetting.rewardName),
              hintText: t.event.rewardSetting.rewardName,
            );
          },
        ),
        SizedBox(height: Spacing.small),
        _ChooseRewardIconButton(
          initialReward: widget.initialReward,
        ),
        SizedBox(height: Spacing.small),
        BlocBuilder<ModifyRewardBloc, ModifyRewardState>(
          builder: (context, state) {
            return SettingTileWidget(
              title: t.event.rewardSetting.limit,
              subTitle: t.event.rewardSetting.limitDescription,
              onTap: () => {},
              trailing: SizedBox(
                width: 60.w,
                child: LemonTextField(
                  initialText:
                      modifyRewardBloc.initialReward?.limitPer.toString() ??
                          '1',
                  textInputType: TextInputType.number,
                  onChange: (value) {
                    modifyRewardBloc.add(
                      ModifyRewardEvent.onLimitPerChanged(
                        limitPer: value.isNotEmpty ? double.parse(value) : 1,
                      ),
                    );
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
            );
          },
        ),
        SizedBox(height: Spacing.small),
        SettingTileWidget(
          title: t.event.rewardSetting.selectAllTicketTiers,
          onTap: () => {},
          trailing: FlutterSwitch(
            inactiveColor:
                Theme.of(context).colorScheme.onPrimary.withOpacity(0.12),
            inactiveToggleColor:
                Theme.of(context).colorScheme.onPrimary.withOpacity(0.18),
            activeColor: LemonColor.switchActive,
            activeToggleColor: Theme.of(context).colorScheme.onPrimary,
            height: 24.h,
            width: 42.w,
            value: selectedAllTicketTiers,
            onToggle: (value) => {
              FocusScope.of(context).unfocus(),
              setState(() {
                selectedAllTicketTiers = value;
              }),
              modifyRewardBloc.add(
                ModifyRewardEvent.onToggleSelectAll(
                  value: value,
                  eventTicketTypes: eventTicketTypes,
                ),
              ),
            },
          ),
        ),
      ],
    );
  }
}

class _ChooseRewardIconButton extends StatelessWidget {
  final Reward? initialReward;
  const _ChooseRewardIconButton({this.initialReward});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus();
        showCupertinoModalBottomSheet(
          context: context,
          backgroundColor: LemonColor.atomicBlack,
          expand: true,
          builder: (innerContext) {
            return SelectRewardIconForm(
              initialReward: initialReward,
              onConfirm: (String iconUrl) {
                context.read<ModifyRewardBloc>().add(
                      ModifyRewardEvent.onIconChanged(
                        iconUrl: iconUrl,
                      ),
                    );
              },
            );
          },
        );
      },
      child: Container(
        height: 60.w,
        padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LemonRadius.small),
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BlocBuilder<ModifyRewardBloc, ModifyRewardState>(
              builder: (context, state) {
                if (state.iconUrl != '' && state.iconUrl != null) {
                  final fullIconUrl =
                      '${AppConfig.assetPrefix}${state.iconUrl}';
                  return Container(
                    width: Sizing.regular,
                    height: Sizing.regular,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Sizing.regular),
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
                        placeholder: (_, __) =>
                            ImagePlaceholder.defaultPlaceholder(),
                        errorWidget: (_, __, ___) =>
                            ImagePlaceholder.defaultPlaceholder(),
                      ),
                    ),
                  );
                }
                return ThemeSvgIcon(
                  color: colorScheme.onSecondary,
                  builder: (filter) => Assets.icons.icAdd.svg(
                    colorFilter: filter,
                  ),
                );
              },
            ),
            SizedBox(width: Spacing.extraSmall),
            Text(
              t.event.rewardSetting.chooseAnIcon,
              style: Typo.medium.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
