import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/reward.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collection/collection.dart';

class ChartRewardFilter extends StatelessWidget {
  final Event event;
  final String? selectedRewardId;
  final Function(String? rewardId)? onSelect;

  const ChartRewardFilter({
    super.key,
    required this.event,
    this.onSelect,
    this.selectedRewardId,
  });

  String get rewardTitle {
    return (event.rewards ?? [])
            .firstWhereOrNull((element) => element.id == selectedRewardId)
            ?.title ??
        t.event.eventDashboard.insights.allRewards;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          value: selectedRewardId,
          onChanged: (value) {
            onSelect?.call(value);
          },
          customButton: LemonOutlineButton(
            key: Key(selectedRewardId ?? ''),
            backgroundColor: colorScheme.secondaryContainer,
            borderColor: Colors.transparent,
            radius: BorderRadius.circular(LemonRadius.normal),
            textStyle: Typo.small.copyWith(
              color: colorScheme.onSecondary,
            ),
            label: rewardTitle,
            trailing: ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icArrowDown.svg(
                width: Sizing.xSmall,
                height: Sizing.xSmall,
                colorFilter: filter,
              ),
            ),
          ),
          items: [
            ...(event.rewards ?? []).map(
              (reward) => DropdownMenuItem(
                value: reward.id,
                child: _RewardItem(
                  reward: reward,
                ),
              ),
            ),
          ],
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LemonRadius.small),
              color: colorScheme.secondaryContainer,
            ),
            offset: Offset(0, -Spacing.superExtraSmall),
            maxHeight: 200.w,
            width: 242.w,
          ),
          menuItemStyleData: const MenuItemStyleData(
            overlayColor: MaterialStatePropertyAll(LemonColor.darkBackground),
          ),
        ),
      ),
    );
  }
}

class _RewardItem extends StatelessWidget {
  final Reward? reward;
  const _RewardItem({
    required this.reward,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            reward?.title ?? '',
            style: Typo.mediumPlus.copyWith(
              color: colorScheme.onSecondary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
