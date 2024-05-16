import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum CollaboratorAboutYouField {
  age,
  basedIn,
}

class CollaboratorDiscoverAboutYou extends StatelessWidget {
  final User? user;
  const CollaboratorDiscoverAboutYou({
    super.key,
    this.user,
  });

  (Widget, String) getIconAndTextDisplay(
    BuildContext context, {
    required CollaboratorAboutYouField field,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (field) {
      case CollaboratorAboutYouField.age:
        return (
          ThemeSvgIcon(
            color: colorScheme.onPrimary,
            builder: (filter) => Assets.icons.icOutlineCake.svg(
              width: 15.w,
              height: 15.w,
              colorFilter: filter,
            ),
          ),
          user?.age?.toInt().toString() ?? '',
        );
      case CollaboratorAboutYouField.basedIn:
        return (
          ThemeSvgIcon(
            color: colorScheme.onPrimary,
            builder: (filter) => Assets.icons.icLocationPin.svg(
              width: 15.w,
              height: 15.w,
              colorFilter: filter,
            ),
          ),
          user?.locationLine ?? ''
        );
      default:
        return (const SizedBox(), '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizing.medium,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: CollaboratorAboutYouField.values.length,
        itemBuilder: (context, index) {
          final field = CollaboratorAboutYouField.values[index];
          final (icon, textDisplay) = getIconAndTextDisplay(
            context,
            field: field,
          );
          if (textDisplay.isEmpty) {
            return const SizedBox();
          }
          return _TagChip(
            icon: icon,
            label: textDisplay,
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          width: Spacing.superExtraSmall,
        ),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final Widget? icon;
  final String? label;

  const _TagChip({
    this.icon,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.xSmall,
      ),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: LemonColor.white09,
          ),
          borderRadius: BorderRadius.circular(LemonRadius.button),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon ?? const SizedBox(),
          const SizedBox(width: 6),
          Text(
            label ?? '',
            style: Typo.medium.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }
}
