import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/event_location_setting_bloc/event_location_setting_bloc.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/presentation/pages/event/create_event/sub_pages/widgets/create_event_map_location_card.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/i18n/i18n.g.dart';
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
  const EventLocationSettingDetailPage({super.key, this.address});

  final Address? address;

  @override
  State<EventLocationSettingDetailPage> createState() =>
      _EventLocationSettingDetailPageState();
}

class _EventLocationSettingDetailPageState
    extends State<EventLocationSettingDetailPage> {
  final TextEditingController placeDetailsController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController street1Controller = TextEditingController();
  final TextEditingController street2Controller = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController regionController = TextEditingController();
  final TextEditingController postalController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController additionalDirectionsController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context
          .read<EventLocationSettingBloc>()
          .add(EventLocationSettingEvent.init(address: widget.address));
      if (widget.address != null) {
        titleController.text = widget.address?.title ?? '';
        street1Controller.text = widget.address?.street1 ?? '';
        street2Controller.text = widget.address?.street2 ?? '';
        cityController.text = widget.address?.city ?? '';
        regionController.text = widget.address?.region ?? '';
        postalController.text = widget.address?.postal ?? '';
        countryController.text = widget.address?.country ?? '';
        // additionalDirectionsController.text =
        //     widget.address?.additionalDirections ?? '';
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return BlocConsumer<EventLocationSettingBloc, EventLocationSettingState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          context.read<AuthBloc>().add(const AuthEvent.refreshData());
          SnackBarUtils.showSuccess(
            message: t.event.locationSetting.addNewLocationSuccessfully,
          );
          AutoRouter.of(context).popTop();
        }
        if (state.placeDetailsText != '') {
          placeDetailsController.text = state.placeDetailsText;
        }
        titleController.text = state.title.value;
        street1Controller.text = state.street1.value;
        street2Controller.text = state.street2;
        cityController.text = state.city.value;
        regionController.text = state.region.value;
        postalController.text = state.postal.value;
        countryController.text = state.country.value;
        additionalDirectionsController.text = state.additionalDirections;
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
                        latitude: state.latitude,
                        longitude: state.longitude,
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
                color: colorScheme.onPrimaryContainer,
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
                        if (state.title.value.isNotEmpty)
                          Text(
                            state.title.value,
                            style: Typo.large.copyWith(
                              color: colorScheme.onPrimary,
                              height: 0,
                            ),
                          ),
                        if (state.street1.value.isNotEmpty) ...[
                          SizedBox(height: Spacing.extraSmall),
                          Text(
                            state.street1.value,
                            style: Typo.mediumPlus.copyWith(
                              color: colorScheme.onSecondary,
                              height: 0,
                            ),
                          ),
                        ],
                        SizedBox(height: Spacing.small),
                        LemonTextField(
                          controller: additionalDirectionsController,
                          hintText:
                              t.event.locationSetting.additionalDirections,
                          onChange: (value) {
                            context.read<EventLocationSettingBloc>().add(
                                  EventLocationSettingEvent
                                      .additionalDirectionsChanged(
                                    additionalDirections: value,
                                  ),
                                );
                          },
                        ),
                        SizedBox(height: Spacing.smMedium * 2),
                        _buildSaveButton(),
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

  _buildSaveButton() {
    return BlocBuilder<EventLocationSettingBloc, EventLocationSettingState>(
      builder: (context, state) {
        return LinearGradientButton(
          label: t.event.locationSetting.confirmLocation,
          height: 48.h,
          radius: BorderRadius.circular(24),
          mode: GradientButtonMode.lavenderMode,
          onTap: () {
            Vibrate.feedback(FeedbackType.light);
            context
                .read<EventLocationSettingBloc>()
                .add(const SubmitAddLocation());
          },
          loadingWhen: state.status.isInProgress,
        );
      },
    );
  }
}
