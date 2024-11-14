import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CreateEventContentSection extends StatelessWidget {
  final Event? initialEvent;

  const CreateEventContentSection({
    super.key,
    this.initialEvent,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isEditMode = initialEvent != null;
    final speakersCount =
        isEditMode ? initialEvent?.speakerUsersExpanded?.length ?? 0 : 0;
    final photosCount =
        isEditMode ? initialEvent?.newNewPhotos?.length ?? 0 : 0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.common.content,
            style: Typo.mediumPlus.copyWith(
              color: colorScheme.onSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: Spacing.xSmall),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: LemonColor.chineseBlack,
              borderRadius: BorderRadius.circular(LemonRadius.medium),
            ),
            child: Column(
              children: [
                _buildSettingRow(
                  context,
                  icon: Assets.icons.icPhotos,
                  title: t.event.eventPhotos.photos,
                  trailingIcon: Assets.icons.icArrowRight,
                  onTap: () {
                    AutoRouter.of(context).navigate(
                      const EventPhotosSettingRoute(),
                    );
                  },
                  value: photosCount > 0 ? photosCount.toString() : null,
                ),
              ],
            ),
          ),
          SizedBox(height: Spacing.xSmall),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: LemonColor.chineseBlack,
              borderRadius: BorderRadius.circular(LemonRadius.medium),
            ),
            child: Column(
              children: [
                _buildSettingRow(
                  context,
                  icon: Assets.icons.icMic,
                  title: t.event.configuration.speakers,
                  trailingIcon: Assets.icons.icArrowRight,
                  onTap: () {
                    AutoRouter.of(context).navigate(
                      const EventSpeakersRoute(),
                    );
                  },
                  value: speakersCount > 0 ? speakersCount.toString() : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingRow(
    BuildContext context, {
    required SvgGenImage icon,
    required String title,
    String? value,
    bool isSwitch = false,
    bool? switchValue,
    SvgGenImage? trailingIcon,
    Function()? onTap,
    Function(bool)? onToggleSwitch,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Spacing.small),
        child: Row(
          children: [
            Center(
              child: SizedBox(
                width: Sizing.mSmall,
                height: Sizing.mSmall,
                child: ThemeSvgIcon(
                  color: colorScheme.onSecondary,
                  builder: (filter) => icon.svg(
                    width: Sizing.mSmall,
                    height: Sizing.mSmall,
                    colorFilter: filter,
                  ),
                ),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(
                title,
                style: Typo.medium.copyWith(color: colorScheme.onPrimary),
              ),
            ),
            if (isSwitch)
              FlutterSwitch(
                inactiveColor: colorScheme.outline,
                inactiveToggleColor: colorScheme.onSurfaceVariant,
                activeColor: LemonColor.paleViolet,
                activeToggleColor: colorScheme.onPrimary,
                height: 24.h,
                width: 42.w,
                value: switchValue ?? false,
                onToggle: (value) {
                  if (onToggleSwitch != null) {
                    onToggleSwitch(value);
                  }
                },
              )
            else if (value != null) ...[
              Text(
                value,
                style: Typo.medium.copyWith(color: colorScheme.onPrimary),
              ),
              SizedBox(width: Spacing.xSmall),
              if (trailingIcon != null)
                ThemeSvgIcon(
                  color: colorScheme.onSurfaceVariant,
                  builder: (filter) => trailingIcon.svg(
                    width: Sizing.xSmall,
                    height: Sizing.xSmall,
                    colorFilter: filter,
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
