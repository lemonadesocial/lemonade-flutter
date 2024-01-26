import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestEventDetailRewards extends StatelessWidget {
  const GuestEventDetailRewards({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: LinearGradientButton(
            onTap: () {
              AutoRouter.of(context)
                  .navigate(const GuestEventRewardUsesRoute());
            },
            height: 42.w,
            leading: const Icon(
              Icons.card_giftcard,
            ),
            label: t.event.rewards,
            textStyle: Typo.medium.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}
