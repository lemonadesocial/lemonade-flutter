import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/presentation/pages/event/event_settings_page/sub_pages/event_guest_settings_page/widgets/delete_event_information_card.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class DeleteEventConfirmationBottomSheet extends StatefulWidget {
  final Event? event;
  const DeleteEventConfirmationBottomSheet({
    this.event,
    super.key,
  });

  @override
  State<DeleteEventConfirmationBottomSheet> createState() =>
      _DeleteEventConfirmationBottomSheetState();
}

class _DeleteEventConfirmationBottomSheetState
    extends State<DeleteEventConfirmationBottomSheet> {
  bool cancelled = false;
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final title = cancelled == true
        ? t.event.cancelEvent.cancelled
        : t.event.cancelEvent.title;
    final description = cancelled == true
        ? t.event.cancelEvent
            .cancelledSuccessfully(event_name: widget.event?.title ?? '')
        : t.event.cancelEvent.description;
    final ctaButtonLabel =
        cancelled == true ? t.common.done : t.event.cancelEvent.cancelAndRefund;
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      color: LemonColor.atomicBlack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BottomSheetGrabber(),
          LemonAppBar(
            backgroundColor: LemonColor.atomicBlack,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: Spacing.smMedium,
              right: Spacing.smMedium,
              top: Spacing.superExtraSmall,
              bottom: Spacing.smMedium,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Typo.extraLarge.copyWith(
                    fontFamily: FontFamily.nohemiVariable,
                    fontWeight: FontWeight.w900,
                    color: colorScheme.onPrimary,
                  ),
                ),
                SizedBox(
                  height: Spacing.superExtraSmall,
                ),
                Text(
                  description,
                  style: Typo.mediumPlus.copyWith(
                    color: colorScheme.onSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: Spacing.medium,
                ),
                // TODO: Get data from backend about guest count and refund amount
                DeleteEventInformationCard(
                  guestCount: 0,
                  refundAmount: 0,
                  cancelled: cancelled,
                ),
                Visibility(
                  visible: cancelled == false,
                  child: Padding(
                    padding: EdgeInsets.only(top: Spacing.medium),
                    child: const _NotReversableWarningCard(),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: LemonColor.atomicBlack,
                border: Border(top: BorderSide(color: colorScheme.outline)),
              ),
              padding: EdgeInsets.all(Spacing.smMedium),
              child: SafeArea(
                child: LinearGradientButton.secondaryButton(
                  onTap: () async {
                    Vibrate.feedback(FeedbackType.light);
                    FocusManager.instance.primaryFocus?.unfocus();
                    // Press done button
                    if (cancelled == true) {
                      AutoRouter.of(context).root.popUntilRoot();
                    }
                    // Trigger cancel event
                    else {
                      await showFutureLoadingDialog(
                        context: context,
                        future: () {
                          return getIt<EventRepository>()
                              .cancelEvent(eventId: widget.event?.id ?? '');
                        },
                      );
                      setState(() {
                        cancelled = !cancelled;
                      });
                    }
                  },
                  label: ctaButtonLabel,
                  textColor: colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotReversableWarningCard extends StatelessWidget {
  const _NotReversableWarningCard();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.small),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: colorScheme.outline,
          ),
          borderRadius: BorderRadius.circular(LemonRadius.medium),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: Sizing.mSmall,
            height: Sizing.mSmall,
            child: Assets.icons.icError.svg(
              width: Sizing.small,
              height: Sizing.small,
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          Expanded(
            child: SizedBox(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${t.event.cancelEvent.notReversableAction}\n',
                      style: Typo.medium.copyWith(
                        height: 0,
                        color: LemonColor.coralReef,
                      ),
                    ),
                    TextSpan(
                      text: t.event.cancelEvent.areYouSure,
                      style: Typo.medium.copyWith(
                        height: 0,
                        fontSize: 13,
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
