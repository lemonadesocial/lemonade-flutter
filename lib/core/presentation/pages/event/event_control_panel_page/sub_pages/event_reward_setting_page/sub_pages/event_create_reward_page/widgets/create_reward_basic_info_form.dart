import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_reward_setting_page/sub_pages/event_create_reward_page/widgets/select_reward_icon_form.dart';
import 'package:app/core/presentation/pages/setting/widgets/setting_tile_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/bottomsheet_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CreateRewardBasicInfoForm extends StatelessWidget {
  const CreateRewardBasicInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LemonTextField(
          onChange: (value) {
            // TODO:
            // Handle on change
          },
          hintText: t.event.rewardSetting.rewardName,
        ),
        SizedBox(height: Spacing.small),
        const _ChooseRewardIconButton(),
        SizedBox(height: Spacing.small),
        SettingTileWidget(
          title: t.event.rewardSetting.limit,
          subTitle: t.event.rewardSetting.limitDescription,
          onTap: () => {},
          trailing: SizedBox(
            width: 60.w,
            child: const LemonTextField(
              textInputType: TextInputType.number,
            ),
          ),
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
            value: false,
            onToggle: (value) => {
              // TODO:
              // Handle on toggle
            },
          ),
        ),
      ],
    );
  }
}

class _ChooseRewardIconButton extends StatelessWidget {
  const _ChooseRewardIconButton();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        BottomSheetUtils.showSnapBottomSheet(
          context,
          builder: (innerContext) {
            return const SelectRewardIconForm();
          },
        );
      },
      child: Container(
        height: 60.h,
        padding: EdgeInsets.symmetric(horizontal: Spacing.medium),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LemonRadius.small),
          border: Border.all(color: colorScheme.outline),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icAdd.svg(
                colorFilter: filter,
              ),
            ),
            SizedBox(width: Spacing.medium),
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
