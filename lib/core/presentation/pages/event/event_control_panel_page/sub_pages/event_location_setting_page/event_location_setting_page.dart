import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/edit_event_detail_bloc/edit_event_detail_bloc.dart';
import 'package:app/core/application/event/event_location_setting_bloc/event_location_setting_bloc.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_location_setting_page/sub_pages/event_location_setting_detail_page.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_location_setting_page/widgets/location_item.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/service/google/google_place_autocomplete_service.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:formz/formz.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'dart:async';

@RoutePage()
class EventLocationSettingPage extends StatefulWidget {
  const EventLocationSettingPage({
    super.key,
    this.event,
  });
  final Event? event;

  @override
  State<EventLocationSettingPage> createState() =>
      _EventLocationSettingPageState();
}

class _EventLocationSettingPageState extends State<EventLocationSettingPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Prediction> _predictions = [];
  Timer? _debounce;
  late GooglePlaceAutocompleteService _placeAutocompleteService;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _placeAutocompleteService = GooglePlaceAutocompleteService();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        _searchPlaces(query);
      } else {
        setState(() {
          _predictions = [];
          _isLoading = false;
        });
      }
    });
  }

  Future<void> _searchPlaces(String query) async {
    if (query.isEmpty) return;

    setState(() => _isLoading = true);
    try {
      final predictions =
          await _placeAutocompleteService.getAutocompleteSuggestions(query);
      setState(() {
        _predictions = predictions;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _predictions = [];
        _isLoading = false;
      });
    }
  }

  Widget _buildContent() {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    List<Address> addresses = context.watch<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession.addresses ?? [],
          orElse: () => [],
        );

    return BlocListener<EventLocationSettingBloc, EventLocationSettingState>(
      listener: (context, state) {
        if (state.deleteStatus == FormzSubmissionStatus.success) {
          context.read<AuthBloc>().add(const AuthEvent.refreshData());
          _searchController.clear();
          setState(() {
            _predictions = [];
          });
        }
      },
      child: BlocBuilder<EventLocationSettingBloc, EventLocationSettingState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(
              left: Spacing.small,
              right: Spacing.small,
              top: Spacing.superExtraSmall,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LemonTextField(
                  controller: _searchController,
                  onChange: _onSearchChanged,
                  hintText: t.event.locationSetting.searchLocation,
                ),
                SizedBox(height: Spacing.smMedium),
                if (_isLoading)
                  Padding(
                    padding: EdgeInsets.only(top: Spacing.small),
                    child: Loading.defaultLoading(context),
                  )
                else
                  Expanded(
                    child: _predictions.isNotEmpty
                        ? ListView.builder(
                            itemCount: _predictions.length,
                            itemBuilder: (context, index) {
                              return LocationItem(
                                location: Address(
                                  id: _predictions[index].placeId ?? '',
                                  title: _predictions[index]
                                          .structuredFormatting
                                          ?.mainText ??
                                      '',
                                  street1: _predictions[index]
                                          .structuredFormatting
                                          ?.secondaryText ??
                                      '',
                                ),
                                onPressItem: () =>
                                    _onSelectPrediction(_predictions[index]),
                                isGooglePrediction: true,
                              );
                            },
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: Spacing.xSmall,
                                ),
                                child: Text(
                                  t.event.locationSetting.savedLocations,
                                  style: Typo.medium.copyWith(
                                    color: colorScheme.onPrimary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: AddressList(
                                  addresses: addresses,
                                  event: widget.event,
                                ),
                              ),
                            ],
                          ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _onSelectPrediction(Prediction prediction) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final result = await showFutureLoadingDialog(
      context: context,
      future: () async {
        return await _placeAutocompleteService
            .getPlaceDetails(prediction.placeId!);
      },
    );

    if (result.error != null) return;

    final detail = result.result!;
    final address = Address(
      title: detail.result.name,
      street1: detail.result.formattedAddress,
      longitude: detail.result.geometry?.location.lng,
      latitude: detail.result.geometry?.location.lat,
    );

    context
        .read<EventLocationSettingBloc>()
        .add(PlaceDetailsChanged(placeDetails: detail.result));

    showBottomSheetDetail(context, address);

    _searchController.clear();
    setState(() {
      _predictions = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.secondaryContainer,
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          const BottomSheetGrabber(),
          LemonAppBar(
            backgroundColor: Colors.transparent,
            title: t.event.locationSetting.chooseLocation,
          ),
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
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
              isDeleting: state.deletingId == addresses[index].id,
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
              onPressItem: () async {
                Vibrate.feedback(FeedbackType.light);
                // Edit event
                if (event != null) {
                  context.read<EditEventDetailBloc>().add(
                        EditEventDetailEvent.update(
                          eventId: event?.id ?? '',
                          address: addresses[index],
                        ),
                      );
                } else {
                  context
                      .read<EventLocationSettingBloc>()
                      .add(SelectAddress(address: addresses[index]));
                  AutoRouter.of(context).pop();
                }
              },
            ),
          ),
          itemCount: addresses.length,
        );
      },
    );
  }

  _onTapEdit(Address address, BuildContext context) {
    Vibrate.feedback(FeedbackType.light);
    showBottomSheetDetail(context, address);
  }
}

void showBottomSheetDetail(BuildContext context, Address address) {
  showCupertinoModalBottomSheet(
    expand: true,
    context: context,
    backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
    topRadius: Radius.circular(30.r),
    useRootNavigator: true,
    builder: (mContext) {
      return BlocProvider.value(
        value: context.read<EventLocationSettingBloc>(),
        child: EventLocationSettingDetailPage(address: address),
      );
    },
  );
}
