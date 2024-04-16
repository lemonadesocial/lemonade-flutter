import 'package:app/core/domain/event/entities/event_cohost_request.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/utils/avatar_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventCohostItem extends StatelessWidget {
  final User? user;
  final Function() onTapRevoke;
  final EventCohostRequest request;

  const EventCohostItem({
    super.key,
    this.user,
    required this.request,
    required this.onTapRevoke,
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
                if (request.state == EventCohostRequestState.accepted ||
                    request.state == EventCohostRequestState.declined)
                  LemonOutlineButton(
                    onTap: () {
                      onTapRevoke();
                    },
                    backgroundColor: LemonColor.coralReef.withOpacity(0.1),
                    textStyle: Typo.small.copyWith(
                      color: LemonColor.coralReef,
                      fontWeight: FontWeight.w600,
                    ),
                    borderColor: Colors.transparent,
                    radius: BorderRadius.circular(LemonRadius.button),
                    label: t.common.actions.remove,
                  ),
                if (request.state == EventCohostRequestState.pending)
                  LinearGradientButton(
                    onTap: () {
                      onTapRevoke();
                    },
                    label: t.common.actions.revoke,
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
