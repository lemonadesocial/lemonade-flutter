import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileFormRowPrefix extends StatelessWidget {
  const EditProfileFormRowPrefix({
    super.key,
    this.icon,
    required this.label,
  });

  final SvgGenImage? icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final appText = context.theme.appTextTheme;
    final appColors = context.theme.appColors;
    return SizedBox(
      width: 120.w,
      child: Row(
        children: [
          if (icon != null) ...[
            ThemeSvgIcon(
              color: appColors.textTertiary,
              builder: (filter) => icon!.svg(
                colorFilter: filter,
                width: Sizing.s5,
                height: Sizing.s5,
              ),
            ),
            SizedBox(width: Spacing.s3),
          ],
          Text(
            label,
            style: appText.md.copyWith(
              color: appColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
