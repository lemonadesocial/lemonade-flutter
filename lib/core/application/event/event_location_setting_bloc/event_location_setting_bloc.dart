import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/form/string_formz.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/utils/google_address_parser.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:injectable/injectable.dart';

part 'event_location_setting_bloc.freezed.dart';

@lazySingleton
class EventLocationSettingBloc
    extends Bloc<EventLocationSettingEvent, EventLocationSettingState> {
  EventLocationSettingBloc() : super(const EventLocationSettingState()) {
    on<EventLocationSettingEventInit>(_onInit);
    on<PlaceDetailsChanged>(_onPlaceDetailsChanged);
    on<TitleChanged>(_onTitleChanged);
    on<Street1Changed>(_onStreet1Changed);
    on<Street2Changed>(_onStreet2Changed);
    on<CityChanged>(_onCityChanged);
    on<RegionChanged>(_onRegionChanged);
    on<PostalChanged>(_onPostalChanged);
    on<CountryChanged>(_onCountryChanged);
    on<LocationChanged>(_onLocationChanged);
    on<SubmitAddLocation>(_onSubmitAddLocation);
    on<DeleteLocation>(_onDeleteLocation);
    on<EventLocationSettingEventClear>(_onClear);
  }

  final _userRepository = getIt<UserRepository>();

  Future<void> _onInit(
    EventLocationSettingEventInit event,
    Emitter emit,
  ) async {}

  Future<void> _onPlaceDetailsChanged(
    PlaceDetailsChanged event,
    Emitter<EventLocationSettingState> emit,
  ) async {
    GoogleAddressParser addressParser =
        GoogleAddressParser(event.placeDetails.addressComponents);
    GoogleAddress result = addressParser.result();
    final geometry = event.placeDetails.geometry!;
    final latitude = geometry.location.lat;
    final longitude = geometry.location.lng;
    emit(
      state.copyWith(
        placeDetailsText: event.placeDetails.formattedAddress!,
        title: StringFormz.dirty(event.placeDetails.name),
        street1: (result.streetNumber != null && result.streetName != null)
            ? StringFormz.dirty('${result.streetNumber} ${result.streetName}')
            : const StringFormz.pure(),
        street2: '',
        city: StringFormz.dirty(result.city ?? ''),
        region: StringFormz.dirty(result.stateCode ?? ''),
        postal: StringFormz.dirty(result.postalCode ?? ''),
        country: StringFormz.dirty(result.country ?? ''),
        latitude: latitude,
        longitude: longitude,
      ),
    );
  }

  Future<void> _onTitleChanged(
    TitleChanged event,
    Emitter<EventLocationSettingState> emit,
  ) async {
    final title = StringFormz.dirty(event.title);
    emit(
      state.copyWith(
        title: title,
        isValid: Formz.validate([
          title,
          state.street1,
          state.city,
          state.region,
          state.postal,
          state.country,
        ]),
      ),
    );
  }

  Future<void> _onStreet1Changed(
    Street1Changed event,
    Emitter<EventLocationSettingState> emit,
  ) async {
    final street1 = StringFormz.dirty(event.street1);
    emit(
      state.copyWith(
        street1: street1,
        isValid: Formz.validate([
          street1,
          state.title,
          state.city,
          state.region,
          state.postal,
          state.country,
        ]),
      ),
    );
  }

  Future<void> _onStreet2Changed(
    Street2Changed event,
    Emitter<EventLocationSettingState> emit,
  ) async {
    emit(
      state.copyWith(
        street2: event.street2,
      ),
    );
  }

  Future<void> _onCityChanged(
    CityChanged event,
    Emitter<EventLocationSettingState> emit,
  ) async {
    final city = StringFormz.dirty(event.city);
    emit(
      state.copyWith(
        city: city,
        isValid: Formz.validate([
          city,
          state.title,
          state.street1,
          state.region,
          state.postal,
          state.country,
        ]),
      ),
    );
  }

  Future<void> _onRegionChanged(
    RegionChanged event,
    Emitter<EventLocationSettingState> emit,
  ) async {
    final region = StringFormz.dirty(event.region);
    emit(
      state.copyWith(
        region: region,
        isValid: Formz.validate([
          region,
          state.title,
          state.street1,
          state.city,
          state.postal,
          state.country,
        ]),
      ),
    );
  }

  Future<void> _onPostalChanged(
    PostalChanged event,
    Emitter<EventLocationSettingState> emit,
  ) async {
    final postal = StringFormz.dirty(event.postal);
    emit(
      state.copyWith(
        postal: postal,
        isValid: Formz.validate([
          postal,
          state.title,
          state.street1,
          state.region,
          state.city,
          state.country,
        ]),
      ),
    );
  }

  Future<void> _onCountryChanged(
    CountryChanged event,
    Emitter<EventLocationSettingState> emit,
  ) async {
    final country = StringFormz.dirty(event.country);
    emit(
      state.copyWith(
        country: country,
        isValid: Formz.validate([
          country,
          state.title,
          state.street1,
          state.region,
          state.postal,
          state.city,
        ]),
      ),
    );
  }

  Future<void> _onLocationChanged(
    LocationChanged event,
    Emitter<EventLocationSettingState> emit,
  ) async {
    emit(
      state.copyWith(
        latitude: event.latitude,
        longitude: event.longitude,
      ),
    );
  }

  Future<void> _onSubmitAddLocation(
    SubmitAddLocation event,
    Emitter<EventLocationSettingState> emit,
  ) async {
    final title = StringFormz.dirty(state.title.value);
    final street1 = StringFormz.dirty(state.street1.value);
    final region = StringFormz.dirty(state.region.value);
    final country = StringFormz.dirty(state.country.value);
    final city = StringFormz.dirty(state.city.value);
    final postal = StringFormz.dirty(state.postal.value);
    emit(
      state.copyWith(
        title: title,
        street1: street1,
        postal: postal,
        city: city,
        region: region,
        country: country,
        isValid:
            Formz.validate([title, street1, postal, region, city, country]),
      ),
    );
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final userAddresses = getIt<AuthBloc>().state.maybeWhen(
            authenticated: (authSession) => authSession.addresses,
            orElse: () => null,
          );
      if (userAddresses == null) return;
      List<Input$AddressInput> newUserAddresses = [];
      for (var i = 0; i < userAddresses.length; i++) {
        final userAddress = userAddresses[i];
        newUserAddresses.add(
          Input$AddressInput(
            title: userAddress.title,
            street_1: userAddress.street1,
            street_2: userAddress.street2,
            city: userAddress.city,
            country: userAddress.country,
            postal: userAddress.postal,
            region: userAddress.region,
            latitude: userAddress.latitude,
            longitude: userAddress.longitude,
          ),
        );
      }
      newUserAddresses.add(
        Input$AddressInput(
          title: state.title.value,
          street_1: state.street1.value,
          street_2: state.street2,
          city: state.city.value,
          country: state.country.value,
          postal: state.postal.value,
          region: state.region.value,
          latitude: state.latitude,
          longitude: state.longitude,
        ),
      );

      final result = await _userRepository.updateUserAddresses(
        input: Input$UserInput(
          addresses: newUserAddresses,
        ),
      );
      result.fold(
        (failure) =>
            emit(state.copyWith(status: FormzSubmissionStatus.failure)),
        (createEvent) =>
            emit(state.copyWith(status: FormzSubmissionStatus.success)),
      );
    }
  }

  Future<void> _onDeleteLocation(
    DeleteLocation event,
    Emitter<EventLocationSettingState> emit,
  ) async {
    final userAddresses = getIt<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession.addresses,
          orElse: () => null,
        );
    if (userAddresses == null) return;
    emit(state.copyWith(deleteStatus: FormzSubmissionStatus.inProgress));
    userAddresses.removeAt(event.index);
    List<Input$AddressInput> newUserAddresses = [];
    for (var i = 0; i < userAddresses.length; i++) {
      final userAddress = userAddresses[i];
      newUserAddresses.add(
        Input$AddressInput(
          title: userAddress.title,
          street_1: userAddress.street1,
          street_2: userAddress.street2,
          city: userAddress.city,
          country: userAddress.country,
          postal: userAddress.postal,
          region: userAddress.region,
          latitude: userAddress.latitude,
          longitude: userAddress.longitude,
        ),
      );
    }
    final result = await _userRepository.updateUserAddresses(
      input: Input$UserInput(
        addresses: newUserAddresses,
      ),
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(deleteStatus: FormzSubmissionStatus.failure)),
      (createEvent) =>
          emit(state.copyWith(deleteStatus: FormzSubmissionStatus.success)),
    );
  }

  Future<void> _onClear(
    EventLocationSettingEventClear event,
    Emitter<EventLocationSettingState> emit,
  ) async {
    emit(
      state.copyWith(
        status: FormzSubmissionStatus.initial,
        deleteStatus: FormzSubmissionStatus.initial,
      ),
    );
  }
}

@freezed
class EventLocationSettingEvent with _$EventLocationSettingEvent {
  factory EventLocationSettingEvent.init() = EventLocationSettingEventInit;

  const factory EventLocationSettingEvent.PlaceDetailsChanged({
    required PlaceDetails placeDetails,
  }) = PlaceDetailsChanged;

  const factory EventLocationSettingEvent.TitleChanged({
    required String title,
  }) = TitleChanged;

  const factory EventLocationSettingEvent.Street1Changed({
    required String street1,
  }) = Street1Changed;

  const factory EventLocationSettingEvent.Street2Changed({
    required String street2,
  }) = Street2Changed;

  const factory EventLocationSettingEvent.CityChanged({
    required String city,
  }) = CityChanged;

  const factory EventLocationSettingEvent.RegionChanged({
    required String region,
  }) = RegionChanged;

  const factory EventLocationSettingEvent.PostalChanged({
    required String postal,
  }) = PostalChanged;

  const factory EventLocationSettingEvent.CountryChanged({
    required String country,
  }) = CountryChanged;

  const factory EventLocationSettingEvent.LocationChanged({
    required double latitude,
    required double longitude,
  }) = LocationChanged;

  const factory EventLocationSettingEvent.submitAddLocation() =
      SubmitAddLocation;

  const factory EventLocationSettingEvent.deleteLocation({
    required int index,
  }) = DeleteLocation;

  const factory EventLocationSettingEvent.clear() =
      EventLocationSettingEventClear;
}

@freezed
class EventLocationSettingState with _$EventLocationSettingState {
  const factory EventLocationSettingState({
    @Default("") String placeDetailsText,
    @Default(StringFormz.pure()) StringFormz title,
    @Default(StringFormz.pure()) StringFormz street1,
    @Default('') String street2,
    @Default(StringFormz.pure()) StringFormz city,
    @Default(StringFormz.pure()) StringFormz region,
    @Default(StringFormz.pure()) StringFormz postal,
    @Default(StringFormz.pure()) StringFormz country,
    @Default(0) double latitude,
    @Default(0) double longitude,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus deleteStatus,
    @Default(false) bool isValid,
  }) = _EventLocationSettingState;
}
