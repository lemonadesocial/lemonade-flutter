import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RSVPEventSuccessPopupWidget extends StatelessWidget {
  const RSVPEventSuccessPopupWidget({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const _SuccessCircle(),
                SizedBox(
                  height: 56.w,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.xLarge),
                  child: Text(
                    t.event.youreIn,
                    style: Typo.extraLarge.copyWith(
                      fontFamily: FontFamily.nohemiVariable,
                      fontWeight: FontWeight.w900,
                      height: 1.2,
                    ),
                  ),
                ),
                SizedBox(height: Spacing.superExtraSmall),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.xLarge),
                  child: Text(
                    t.event.rsvpSuccessful(eventName: event.title ?? ''),
                    style: Typo.mediumPlus.copyWith(
                      fontWeight: FontWeight.w400,
                      color: colorScheme.onSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: Spacing.xLarge),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.xLarge),
                  child: LinearGradientButton(
                    mode: GradientButtonMode.lavenderMode,
                    height: Sizing.large,
                    textStyle: Typo.medium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onPrimary.withOpacity(0.87),
                      fontFamily: FontFamily.nohemiVariable,
                    ),
                    radius: BorderRadius.circular(LemonRadius.small * 2),
                    label: t.event.takeMeToEvent,
                  ),
                )
              ],
            ),
            Positioned(
              top: 0,
              left: Spacing.smMedium,
              height: Sizing.xLarge,
              child: LemonBackButton(
                color: colorScheme.onPrimary,
              ),
            ),
            Positioned(
              top: Spacing.smMedium / 2,
              right: Spacing.smMedium,
              child: Container(
                width: 125.w,
                height: Sizing.medium,
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary.withOpacity(0.09),
                  borderRadius: BorderRadius.circular(LemonRadius.normal),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.icons.icUserAdd.svg(),
                    SizedBox(width: Spacing.extraSmall),
                    Text(
                      t.event.inviteFriends,
                      style: Typo.small.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuccessCircle extends StatelessWidget {
  const _SuccessCircle();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 450.w,
      height: 450.w,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: LayoutBuilder(
              builder: (context, constraints) => Transform.scale(
                scale: 1.2,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const RadialGradient(
                      colors: [
                        Colors.black,
                        Color.fromRGBO(5, 10, 7, 1),
                      ],
                      stops: [
                        0.8,
                        1,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(constraints.maxWidth),
                  ),
                  width: constraints.maxWidth,
                  height: constraints.maxWidth,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                gradient: const RadialGradient(
                  colors: [
                    Colors.black,
                    Color.fromRGBO(12, 20, 17, 1),
                  ],
                  stops: [
                    0.5,
                    1,
                  ],
                ),
                borderRadius: BorderRadius.circular(240.w),
              ),
              width: 240.w,
              height: 240.w,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Assets.icons.icSuccess.svg(),
          ),
        ],
      ),
    );
  }
}
