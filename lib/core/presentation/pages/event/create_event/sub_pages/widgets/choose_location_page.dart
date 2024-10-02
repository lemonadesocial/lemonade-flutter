import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/edit_event_detail_bloc/edit_event_detail_bloc.dart';
import 'package:app/core/application/event/event_location_setting_bloc/event_location_setting_bloc.dart';
import 'package:app/core/config.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_location_setting_page/widgets/location_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:google_maps_webservice/places.dart' as google_places_service;
import 'package:google_api_headers/google_api_headers.dart';

@RoutePage()
class ChooseLocationPage extends StatefulWidget {
  const ChooseLocationPage({
    super.key,
    this.event,
  });
  final Event? event;

  @override
  State<ChooseLocationPage> createState() => _ChooseLocationPageState();
}

class _ChooseLocationPageState extends State<ChooseLocationPage> {
  final TextEditingController placeDetailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      appBar: LemonAppBar(
        backgroundColor: colorScheme.onPrimaryContainer,
        title: t.event.locationSetting.chooseLocation,
      ),
      backgroundColor: colorScheme.onPrimaryContainer,
      resizeToAvoidBottomInset: true,
      body: _buildContent(),
    );
  }

  _onTapEnterAddress() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    final p = await PlacesAutocomplete.show(
      context: context,
      apiKey: AppConfig.googleMapKey,
      onError: (response) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.errorMessage ?? 'Unknown error'),
          ),
        );
      },
      mode: Mode.fullscreen,
      resultTextStyle: Theme.of(context).textTheme.titleMedium,
    );
    await displayPrediction(
      p != null ? google_places_service.Prediction.fromJson(p.toJson()) : null,
      ScaffoldMessenger.of(context),
    );
  }

  Future<void> displayPrediction(
    google_places_service.Prediction? p,
    ScaffoldMessengerState messengerState,
  ) async {
    if (p == null) {
      return;
    }
    FocusScope.of(context).requestFocus(FocusNode());
    // Get place detail (lat/lng)
    final places = google_places_service.GoogleMapsPlaces(
      apiKey: AppConfig.googleMapKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );
    final detail = await places.getDetailsByPlaceId(p.placeId!);
    context
        .read<EventLocationSettingBloc>()
        .add(PlaceDetailsChanged(placeDetails: detail.result));
  }

  Widget _buildContent() {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    List<Address> addresses = context.watch<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession.addresses ?? [],
          orElse: () => [],
        );
    Widget content =
        BlocBuilder<EventLocationSettingBloc, EventLocationSettingState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Spacing.small,
            vertical: Spacing.small,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LemonTextField(
                onChange: (value) {},
                hintText: t.event.locationSetting.searchLocation,
                onTap: _onTapEnterAddress,
                controller: placeDetailsController,
              ),
              SizedBox(
                height: 25.h,
              ),
              Text(
                t.event.locationSetting.savedLocations,
                style: Typo.extraMedium.copyWith(color: colorScheme.onPrimary),
              ),
              SizedBox(
                height: Spacing.xSmall,
              ),
              Expanded(
                child: AddressList(addresses: addresses, event: widget.event),
              ),
            ],
          ),
        );
      },
    );

    if (widget.event != null) {
      content = BlocListener<EditEventDetailBloc, EditEventDetailState>(
        listener: (context, state) {
          if (state.status == EditEventDetailBlocStatus.success) {
            AutoRouter.of(context).pop();
          }
        },
        child: content,
      );
    }

    return content;
  }
}

class AddressList extends StatelessWidget {
  final Event? event;
  const AddressList({
    super.key,
    required this.addresses,
    this.event,
  });

  final List<Address> addresses;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventLocationSettingBloc, EventLocationSettingState>(
      builder: (context, state) {
        return ListView.builder(
          padding: EdgeInsets.only(bottom: Spacing.medium),
          shrinkWrap: true,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              Vibrate.feedback(FeedbackType.light);
            },
            child: LocationItem(
              location: addresses[index],
              onPressEdit: () {
                Vibrate.feedback(FeedbackType.light);
                _onTapEdit(addresses[index], context);
              },
              onPressDelete: () {
                Vibrate.feedback(FeedbackType.light);
                context
                    .read<EventLocationSettingBloc>()
                    .add(DeleteLocation(id: addresses[index].id));
              },
              // onPressItem: () {
              //   Vibrate.feedback(FeedbackType.light);
              //   context
              //       .read<EventLocationSettingBloc>()
              //       .add(SelectAddress(address: addresses[index]));
              // },
              // selected: state.selectedAddress != null
              //     ? state.selectedAddress?.id == addresses[index].id
              //     : event?.address?.title == addresses[index].title,
            ),
          ),
          itemCount: addresses.length,
        );
      },
    );
  }

  _onTapEdit(Address address, BuildContext context) {
    Vibrate.feedback(FeedbackType.light);
    AutoRouter.of(context)
        .navigate(EventLocationSettingDetailRoute(address: address));
  }
}
