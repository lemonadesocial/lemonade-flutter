import 'package:app/core/domain/event/entities/event_guest_detail/event_guest_detail.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:app/app_theme/app_theme.dart';

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
    final appColors = context.theme.appColors;
    final t = Translations.of(context);
    if (!isPending) return const SizedBox.shrink();

    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: appColors.pageBg,
            border: Border(
              top: BorderSide(
                color: appColors.pageDivider,
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
                label: t.common.actions.accept,
              ),
              SizedBox(height: Spacing.xSmall),
              LinearGradientButton.secondaryButton(
                onTap: onPressDecline,
                label: t.common.actions.decline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
