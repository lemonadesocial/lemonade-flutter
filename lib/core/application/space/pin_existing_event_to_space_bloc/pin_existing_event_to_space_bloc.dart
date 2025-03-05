import 'package:app/core/domain/space/entities/pin_events_to_space_response.dart';
import 'package:app/core/domain/space/space_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/graphql/backend/event/query/get_event.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pin_existing_event_to_space_bloc.freezed.dart';

@freezed
class PinExistingEventToSpaceEvent with _$PinExistingEventToSpaceEvent {
  const factory PinExistingEventToSpaceEvent.pinEvent({
    required String eventUrl,
    required String spaceId,
    List<String>? tags,
  }) = _PinEvent;
}

@freezed
class PinExistingEventToSpaceState with _$PinExistingEventToSpaceState {
  const factory PinExistingEventToSpaceState.idle() =
      PinExistingEventToSpaceStateIdle;
  const factory PinExistingEventToSpaceState.loading() =
      PinExistingEventToSpaceStateLoading;
  const factory PinExistingEventToSpaceState.eventNotFound() =
      PinExistingEventToSpaceStateEventNotFound;
  const factory PinExistingEventToSpaceState.success(
    PinEventsToSpaceResponse response,
  ) = PinExistingEventToSpaceStateSuccess;
  const factory PinExistingEventToSpaceState.failure(
    Failure failure,
  ) = PinExistingEventToSpaceStateFailure;
}

class PinExistingEventToSpaceBloc
    extends Bloc<PinExistingEventToSpaceEvent, PinExistingEventToSpaceState> {
  final SpaceRepository _spaceRepository;

  PinExistingEventToSpaceBloc(
    this._spaceRepository,
  ) : super(const PinExistingEventToSpaceState.idle()) {
    on<_PinEvent>(_onPinEvent);
  }

  Future<void> _onPinEvent(_PinEvent e, Emitter emit) async {
    emit(const PinExistingEventToSpaceState.loading());

    final shortId = _extractShortIdFromUrl(e.eventUrl);
    if (shortId == null) {
      emit(
        PinExistingEventToSpaceState.failure(
          Failure(message: 'Invalid event URL format'),
        ),
      );
      return;
    }

    // Check if event exists
    final eventResult = await getIt<AppGQL>().client.query$GetEvent(
          Options$Query$GetEvent(
            variables: Variables$Query$GetEvent(
              shortid: shortId,
            ),
          ),
        );

    if (eventResult.hasException || eventResult.parsedData?.getEvent == null) {
      emit(
        const PinExistingEventToSpaceState.eventNotFound(),
      );
      return;
    }
    final eventId = eventResult.parsedData?.getEvent?.$_id;
    if (eventId == null) {
      emit(const PinExistingEventToSpaceState.eventNotFound());
      return;
    }

    final pinResult = await _spaceRepository.pinEventsToSpace(
      events: [eventId],
      spaceId: e.spaceId,
      tags: e.tags,
    );

    pinResult.fold(
      (failure) => emit(PinExistingEventToSpaceState.failure(failure)),
      (response) => emit(PinExistingEventToSpaceState.success(response)),
    );
  }

  String? _extractShortIdFromUrl(String url) {
    try {
      final uri = Uri.parse(url);
      final pathSegments = uri.pathSegments;
      if (pathSegments.isNotEmpty) {
        return pathSegments.last;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
