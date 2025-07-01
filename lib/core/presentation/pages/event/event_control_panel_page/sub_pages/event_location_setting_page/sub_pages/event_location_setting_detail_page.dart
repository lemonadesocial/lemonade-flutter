import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/event_location_setting_bloc/event_location_setting_bloc.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/create_event/sub_pages/widgets/create_event_map_location_card.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:formz/formz.dart';

@RoutePage()
class EventLocationSettingDetailPage extends StatefulWidget {
  const EventLocationSettingDetailPage({
    super.key,
    this.address,
    this.event,
    this.onConfirmLocation,
    this.isSubEvent = false,
  });

  final Address? address;
  final Event? event;
  final Function(Address)? onConfirmLocation;
  final bool isSubEvent;

  @override
  State<EventLocationSettingDetailPage> createState() =>
      _EventLocationSettingDetailPageState();
}

class _EventLocationSettingDetailPageState
    extends State<EventLocationSettingDetailPage> {
  final TextEditingController additionalDirectionsController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.address != null) {
        additionalDirectionsController.text =
            widget.address?.additionalDirections ?? '';
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final t = Translations.of(context);

    return BlocConsumer<EventLocationSettingBloc, EventLocationSettingState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          context.read<AuthBloc>().add(const AuthEvent.refreshData());
        }
        additionalDirectionsController.text =
            state.selectedAddress?.additionalDirections ?? '';
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CreateEventMapLocationCard(
                        latitude: widget.address?.latitude ?? 0,
                        longitude: widget.address?.longitude ?? 0,
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 10.w),
                        const BottomSheetGrabber(),
                        const LemonAppBar(
                          backgroundColor: Colors.transparent,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Input fields and button
              Container(
                color: appColors.inputBg,
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: Spacing.smMedium,
                      left: Spacing.smMedium,
                      right: Spacing.smMedium,
                      bottom: Spacing.superExtraSmall,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (widget.address?.title?.isNotEmpty ?? false)
                          Text(
                            widget.address!.title!,
                            style: Typo.large.copyWith(
                              color: appColors.textPrimary,
                              height: 0,
                            ),
                          ),
                        if (widget.address?.street1?.isNotEmpty ?? false) ...[
                          SizedBox(height: Spacing.extraSmall),
                          Text(
                            widget.address!.street1!,
                            style: Typo.mediumPlus.copyWith(
                              color: appColors.textTertiary,
                              height: 0,
                            ),
                          ),
                        ],
                        // Don't show additional_direction for subEvent
                        if (!widget.isSubEvent) ...[
                          SizedBox(height: Spacing.small),
                          LemonTextField(
                            controller: additionalDirectionsController,
                            hintText:
                                t.event.locationSetting.additionalDirections,
                          ),
                        ],
                        SizedBox(height: Spacing.smMedium * 2),
                        _buildConfirmLocationButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _buildConfirmLocationButton() {
    return BlocBuilder<EventLocationSettingBloc, EventLocationSettingState>(
      builder: (context, state) {
        return LinearGradientButton.primaryButton(
          label: t.event.locationSetting.confirmLocation,
          onTap: () {
            Vibrate.feedback(FeedbackType.light);
            Navigator.of(context).pop();
            if (widget.address == null) return;
            final finalAddress = widget.address!.copyWith(
              additionalDirections: additionalDirectionsController.text,
            );
            context.read<EventLocationSettingBloc>().add(
                  SelectAddress(address: finalAddress),
                );
            context
                .read<EventLocationSettingBloc>()
                .add(const SubmitAddLocation());
            widget.onConfirmLocation?.call(finalAddress);
          },
          loadingWhen: state.status.isInProgress,
        );
      },
    );
  }
}
