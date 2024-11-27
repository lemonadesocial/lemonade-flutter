import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/common/entities/common.dart';
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
    on<PlaceDetailsChanged>(_onPlaceDetailsChanged);
    on<SubmitAddLocation>(_onSubmitAddLocation);
    on<DeleteLocation>(_onDeleteLocation);
    on<SelectAddress>(_onSelectAddress);
    on<ClearSelectedAddress>(_onClearSelectedAddress);
    on<AdditionalDirectionsChanged>(_onAdditionalDirectionsChanged);
  }

  final _userRepository = getIt<UserRepository>();

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
        selectedAddress: Address(
          title: event.placeDetails.name,
          street1: (result.streetNumber != null && result.streetName != null)
              ? '${result.streetNumber} ${result.streetName}'
              : '',
          street2: '',
          city: result.city ?? '',
          region: result.stateCode ?? '',
          postal: result.postalCode ?? '',
          country: result.country ?? '',
          latitude: latitude,
          longitude: longitude,
        ),
      ),
    );
  }

  Future<void> _onSubmitAddLocation(
    SubmitAddLocation event,
    Emitter<EventLocationSettingState> emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final userAddresses = getIt<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession.addresses,
          orElse: () => null,
        );
    if (userAddresses == null) return;
    List<Input$AddressInput> newUserAddresses = [];
    for (var i = 0; i < userAddresses.length; i++) {
      final userAddress = userAddresses[i];
      Input$AddressInput addressInput;
      if (state.selectedAddress != null &&
          userAddress.id == state.selectedAddress!.id) {
        addressInput = Input$AddressInput(
          title: state.selectedAddress?.title ?? '',
          street_1: state.selectedAddress?.street1 ?? '',
          street_2: state.selectedAddress?.street2 ?? '',
          city: state.selectedAddress?.city ?? '',
          country: state.selectedAddress?.country ?? '',
          postal: state.selectedAddress?.postal ?? '',
          region: state.selectedAddress?.region ?? '',
          latitude: state.selectedAddress?.latitude ?? 0,
          longitude: state.selectedAddress?.longitude ?? 0,
          additional_directions:
              state.selectedAddress?.additionalDirections ?? '',
        );
      } else {
        addressInput = Input$AddressInput(
          title: userAddress.title,
          street_1: userAddress.street1,
          street_2: userAddress.street2,
          city: userAddress.city,
          country: userAddress.country,
          postal: userAddress.postal,
          region: userAddress.region,
          latitude: userAddress.latitude,
          longitude: userAddress.longitude,
          additional_directions: userAddress.additionalDirections,
        );
      }

      newUserAddresses.add(addressInput);
    }

    // Insert new address if it's not in the user's addresses
    if (state.selectedAddress != null && state.selectedAddress?.id == null) {
      newUserAddresses.add(
        Input$AddressInput(
          title: state.selectedAddress?.title ?? '',
          street_1: state.selectedAddress?.street1 ?? '',
          street_2: state.selectedAddress?.street2 ?? '',
          city: state.selectedAddress?.city ?? '',
          country: state.selectedAddress?.country ?? '',
          postal: state.selectedAddress?.postal ?? '',
          region: state.selectedAddress?.region ?? '',
          latitude: state.selectedAddress?.latitude ?? 0,
          longitude: state.selectedAddress?.longitude ?? 0,
          additional_directions:
              state.selectedAddress?.additionalDirections ?? '',
        ),
      );
    }
    final result = await _userRepository.updateUserAddresses(
      input: Input$UserInput(
        addresses: newUserAddresses,
      ),
    );
    result.fold(
      (failure) => emit(state.copyWith(status: FormzSubmissionStatus.failure)),
      (address) => emit(state.copyWith(status: FormzSubmissionStatus.success)),
    );
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
    emit(
      state.copyWith(
        deleteStatus: FormzSubmissionStatus.inProgress,
        deletingId: event.id,
      ),
    );

    // Create a new mutable list from the immutable one
    List<Address> mutableAddresses = List.from(userAddresses);
    mutableAddresses.removeWhere((address) => address.id == event.id);

    List<Input$AddressInput> newUserAddresses = mutableAddresses
        .map(
          (userAddress) => Input$AddressInput(
            title: userAddress.title,
            street_1: userAddress.street1,
            street_2: userAddress.street2,
            city: userAddress.city,
            country: userAddress.country,
            postal: userAddress.postal,
            region: userAddress.region,
            latitude: userAddress.latitude,
            longitude: userAddress.longitude,
            additional_directions: userAddress.additionalDirections,
          ),
        )
        .toList();
    final result = await _userRepository.updateUserAddresses(
      input: Input$UserInput(
        addresses: newUserAddresses,
      ),
    );
    result.fold((failure) {
      emit(
        state.copyWith(
          deleteStatus: FormzSubmissionStatus.failure,
          deletingId: null,
        ),
      );
    }, (success) {
      emit(
        state.copyWith(
          deleteStatus: FormzSubmissionStatus.success,
          deletingId: null,
        ),
      );
    });
  }

  Future<void> _onSelectAddress(
    SelectAddress event,
    Emitter<EventLocationSettingState> emit,
  ) async {
    return emit(
      state.copyWith(
        selectedAddress: event.address,
      ),
    );
  }

  Future<void> _onClearSelectedAddress(
    ClearSelectedAddress event,
    Emitter<EventLocationSettingState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedAddress: null,
      ),
    );
  }

  Future<void> _onAdditionalDirectionsChanged(
    AdditionalDirectionsChanged event,
    Emitter<EventLocationSettingState> emit,
  ) async {
    if (state.selectedAddress == null) return;

    final newAddress = state.selectedAddress!.copyWith(
      additionalDirections: event.additionalDirections,
    );

    emit(
      state.copyWith(
        selectedAddress: newAddress,
      ),
    );
  }
}

@freezed
class EventLocationSettingEvent with _$EventLocationSettingEvent {
  const factory EventLocationSettingEvent.PlaceDetailsChanged({
    required PlaceDetails placeDetails,
  }) = PlaceDetailsChanged;

  const factory EventLocationSettingEvent.submitAddLocation() =
      SubmitAddLocation;

  const factory EventLocationSettingEvent.deleteLocation({
    required String? id,
  }) = DeleteLocation;

  const factory EventLocationSettingEvent.selectAddress({
    required Address address,
  }) = SelectAddress;

  const factory EventLocationSettingEvent.clearSelectedAddress() =
      ClearSelectedAddress;

  const factory EventLocationSettingEvent.additionalDirectionsChanged({
    required String additionalDirections,
  }) = AdditionalDirectionsChanged;
}

@freezed
class EventLocationSettingState with _$EventLocationSettingState {
  const factory EventLocationSettingState({
    @Default("") String placeDetailsText,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus deleteStatus,
    Address? selectedAddress,
    String? deletingId,
  }) = _EventLocationSettingState;
}
