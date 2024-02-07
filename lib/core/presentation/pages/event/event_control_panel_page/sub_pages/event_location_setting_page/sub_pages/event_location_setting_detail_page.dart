import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/event_location_setting_bloc/event_location_setting_bloc.dart';
import 'package:app/core/config.dart';
import 'package:app/core/domain/common/entities/common.dart';
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
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:formz/formz.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

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
    return Scaffold(
      appBar: LemonAppBar(
        backgroundColor: colorScheme.onPrimaryContainer,
        title: widget.address != null
            ? t.event.locationSetting.edit
            : t.event.locationSetting.addNew,
      ),
      backgroundColor: colorScheme.onPrimaryContainer,
      body: SafeArea(
        child:
            BlocListener<EventLocationSettingBloc, EventLocationSettingState>(
          listener: (context, state) async {
            if (state.status.isSuccess) {
              context.read<AuthBloc>().add(const AuthEvent.refreshData());
              SnackBarUtils.showSuccessSnackbar(
                t.event.locationSetting.addNewLocationSuccessfully,
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
          },
          child:
              BlocBuilder<EventLocationSettingBloc, EventLocationSettingState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: Spacing.xLarge),
                        child: Column(
                          children: [
                            LemonTextField(
                              onChange: (value) {},
                              hintText: t.event.locationSetting.enterAnAddress,
                              onTap: _onTapEnterAddress,
                              controller: placeDetailsController,
                            ),
                            SizedBox(height: Spacing.smMedium),
                            LemonTextField(
                              onChange: (value) => context
                                  .read<EventLocationSettingBloc>()
                                  .add(TitleChanged(title: value)),
                              hintText: t.event.locationSetting.nameThisPlace,
                              controller: titleController,
                              errorText: state.title.displayError?.getMessage(
                                t.event.locationSetting.nameThisPlace,
                              ),
                            ),
                            SizedBox(height: Spacing.smMedium),
                            LemonTextField(
                              onChange: (value) => context
                                  .read<EventLocationSettingBloc>()
                                  .add(Street1Changed(street1: value)),
                              hintText: t.event.locationSetting.street1,
                              controller: street1Controller,
                              errorText: state.street1.displayError?.getMessage(
                                t.event.locationSetting.street1,
                              ),
                            ),
                            SizedBox(height: Spacing.smMedium),
                            LemonTextField(
                              hintText: t.event.locationSetting.street2,
                              controller: street2Controller,
                              onChange: (value) => context
                                  .read<EventLocationSettingBloc>()
                                  .add(Street2Changed(street2: value)),
                            ),
                            SizedBox(height: Spacing.smMedium),
                            LemonTextField(
                              hintText: t.event.locationSetting.city,
                              controller: cityController,
                              errorText: state.city.displayError?.getMessage(
                                t.event.locationSetting.city,
                              ),
                              onChange: (value) => context
                                  .read<EventLocationSettingBloc>()
                                  .add(CityChanged(city: value)),
                            ),
                            SizedBox(height: Spacing.smMedium),
                            LemonTextField(
                              hintText: t.event.locationSetting.region,
                              controller: regionController,
                              errorText: state.region.displayError?.getMessage(
                                t.event.locationSetting.region,
                              ),
                              onChange: (value) => context
                                  .read<EventLocationSettingBloc>()
                                  .add(RegionChanged(region: value)),
                            ),
                            SizedBox(height: Spacing.smMedium),
                            LemonTextField(
                              hintText: t.event.locationSetting.postalCode,
                              controller: postalController,
                              errorText: state.postal.displayError?.getMessage(
                                t.event.locationSetting.postalCode,
                              ),
                              onChange: (value) => context
                                  .read<EventLocationSettingBloc>()
                                  .add(PostalChanged(postal: value)),
                            ),
                            SizedBox(height: Spacing.smMedium),
                            LemonTextField(
                              hintText: t.event.locationSetting.country,
                              controller: countryController,
                              errorText: state.country.displayError?.getMessage(
                                t.event.locationSetting.country,
                              ),
                              onChange: (value) => context
                                  .read<EventLocationSettingBloc>()
                                  .add(CountryChanged(country: value)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    _buildSaveButton(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _onTapEnterAddress() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    final p = await PlacesAutocomplete.show(
      context: context,
      apiKey: AppConfig.googleMapKey,
      onError: (PlacesAutocompleteResponse response) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.errorMessage ?? 'Unknown error'),
          ),
        );
      },
      mode: Mode.overlay,
      resultTextStyle: Theme.of(context).textTheme.titleMedium,
    );

    await displayPrediction(p, ScaffoldMessenger.of(context));
  }

  Future<void> displayPrediction(
    Prediction? p,
    ScaffoldMessengerState messengerState,
  ) async {
    if (p == null) {
      return;
    }
    FocusScope.of(context).requestFocus(FocusNode());
    // Get place detail (lat/lng)
    final places = GoogleMapsPlaces(
      apiKey: AppConfig.googleMapKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );
    final detail = await places.getDetailsByPlaceId(p.placeId!);
    context
        .read<EventLocationSettingBloc>()
        .add(PlaceDetailsChanged(placeDetails: detail.result));
  }

  _buildSaveButton() {
    return BlocBuilder<EventLocationSettingBloc, EventLocationSettingState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: LinearGradientButton(
            label: widget.address != null
                ? t.common.actions.edit
                : t.common.actions.add,
            height: 48.h,
            radius: BorderRadius.circular(24),
            textStyle: Typo.medium.copyWith(),
            mode: state.placeDetailsText == ''
                ? GradientButtonMode.lavenderDisableMode
                : GradientButtonMode.lavenderMode,
            onTap: () {
              Vibrate.feedback(FeedbackType.light);
              context
                  .read<EventLocationSettingBloc>()
                  .add(const SubmitAddLocation());
            },
            loadingWhen: state.status.isInProgress,
          ),
        );
      },
    );
  }
}
