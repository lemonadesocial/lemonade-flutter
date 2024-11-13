import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/utils/avatar_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventSpeakerItem extends StatelessWidget {
  final User? user;
  final Function() onTapRemove;

  const EventSpeakerItem({
    super.key,
    this.user,
    required this.onTapRemove,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  LemonCircleAvatar(
                    size: Sizing.medium,
                    url: AvatarUtils.getAvatarUrl(user: user),
                  ),
                  Flexible(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Spacing.extraSmall),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.name ?? '',
                            style: Typo.small.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 2.w),
                          Text(
                            user?.username ?? '',
                            style: Typo.small.copyWith(
                              color: colorScheme.onSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                LinearGradientButton(
                  onTap: () {
                    onTapRemove();
                  },
                  label: t.common.actions.remove,
                  radius: BorderRadius.circular(LemonRadius.small * 2),
                  height: Sizing.regular,
                  mode: GradientButtonMode.defaultMode,
                  textStyle: Typo.small.copyWith(
                    color: colorScheme.onPrimary.withOpacity(0.87),
                    fontFamily: FontFamily.nohemiVariable,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
