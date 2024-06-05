import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/presentation/widgets/animation/ripple_animation.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class GuestEventApprovalStatusPage extends StatelessWidget {
  final Event event;
  final EventJoinRequest? eventJoinRequest;
  const GuestEventApprovalStatusPage({
    super.key,
    required this.event,
    this.eventJoinRequest,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final isPendingJoinRequest =
        eventJoinRequest != null && eventJoinRequest?.isPending == true;
    final isDeclinedJoinRequest =
        eventJoinRequest != null && eventJoinRequest?.isDeclined != null;
    final isApproved = eventJoinRequest?.isApproved != null;

    String title = '';
    String description = '';
    String buttonLabel = '';
    SvgGenImage icon = Assets.icons.icApprovalPending;

    if (isPendingJoinRequest) {
      title = t.event.eventApproval.awaitingHostApprovalGuestViewTitle;
      description =
          t.event.eventApproval.awaitingHostApprovalGuestViewDescription;
      buttonLabel = t.common.done;
    }

    if (isDeclinedJoinRequest) {
      title = t.event.eventApproval.declinedApprovalGuestViewTitle;
      description = t.event.eventApproval.declinedApprovalGuestViewDescription;
      buttonLabel = t.common.done;
      icon = Assets.icons.icApprovalDeclined;
    }

    if (isApproved) {
      title = t.event.eventApproval.approvedApprovalGuestViewTitle;
      description = t.event.eventApproval.approvedApprovalGuestViewDescription;
      buttonLabel = t.event.eventApproval.completePayment;
      icon = Assets.icons.icApprovalApproved;
    }

    return Scaffold(
      appBar: const LemonAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Spacer(),
          _CircularAnimation(
            icon: icon,
          ),
          const Spacer(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(Spacing.smMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: Typo.extraLarge.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontFamily.nohemiVariable,
                    ),
                  ),
                  SizedBox(height: Spacing.superExtraSmall),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: Spacing.xSmall * 2.5),
                  if (isApproved)
                    LinearGradientButton.primaryButton(
                      onTap: () async {
                        await AutoRouter.of(context).pop();
                        AutoRouter.of(context).navigate(
                          EventBuyTicketsRoute(event: event),
                        );
                      },
                      label: buttonLabel,
                    )
                  else
                    LinearGradientButton.secondaryButton(
                      onTap: () => AutoRouter.of(context).pop(),
                      label: buttonLabel,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircularAnimation extends StatelessWidget {
  final SvgGenImage icon;
  const _CircularAnimation({
    required this.icon,
  });

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
                scale: 1.5,
                child: RippleAnimation(
                  size: constraints.maxWidth,
                  color: const Color.fromRGBO(11, 11, 11, 1),
                  scaleTween: Tween<double>(begin: 0.3, end: 1),
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
                    Color.fromRGBO(12, 12, 12, 1),
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
            child: icon.svg(),
          ),
        ],
      ),
    );
  }
}
