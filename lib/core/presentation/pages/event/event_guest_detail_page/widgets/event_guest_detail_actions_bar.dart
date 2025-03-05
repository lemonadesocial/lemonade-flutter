import 'package:app/core/domain/event/entities/event_guest_detail/event_guest_detail.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class EventGuestDetailActionsBar extends StatelessWidget {
  final VoidCallback? onPressApprove;
  final VoidCallback? onPressDecline;
  final EventGuestDetail eventGuestDetail;
  const EventGuestDetailActionsBar({
    super.key,
    this.onPressApprove,
    this.onPressDecline,
    required this.eventGuestDetail,
  });

  bool get isPending => eventGuestDetail.joinRequest?.isPending == true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    if (!isPending) return const SizedBox.shrink();

    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.background,
            border: Border(
              top: BorderSide(
                color: colorScheme.outline,
              ),
            ),
          ),
          padding: EdgeInsets.only(
            top: Spacing.smMedium,
            left: Spacing.xSmall,
            right: Spacing.xSmall,
          ),
          child: Column(
            children: [
              LinearGradientButton.primaryButton(
                onTap: onPressApprove,
                radius: BorderRadius.circular(LemonRadius.small),
                height: Sizing.large,
                label: t.common.actions.accept,
                textStyle: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontFamily.nohemiVariable,
                ),
              ),
              SizedBox(height: Spacing.xSmall),
              LinearGradientButton.secondaryButton(
                onTap: onPressDecline,
                radius: BorderRadius.circular(LemonRadius.small),
                height: Sizing.large,
                label: t.common.actions.decline,
                textStyle: Typo.medium.copyWith(
                  color: LemonColor.coralReef,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontFamily.nohemiVariable,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
