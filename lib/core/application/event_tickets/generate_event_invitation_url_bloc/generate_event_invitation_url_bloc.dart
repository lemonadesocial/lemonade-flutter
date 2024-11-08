import 'package:app/core/config.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generate_event_invitation_url_bloc.freezed.dart';

class GenerateEventInvitationUrlBloc extends Bloc<
    GenerateEventInvitationUrlEvent, GenerateEventInvitationUrlState> {
  final _eventRepository = getIt<EventRepository>();

  GenerateEventInvitationUrlBloc()
      : super(GenerateEventInvitationUrlStateInitial()) {
    on<GenerateEventInvitationUrlEventGenerate>(_onGenerate);
  }

  Future<void> _onGenerate(
    GenerateEventInvitationUrlEventGenerate event,
    Emitter emit,
  ) async {
    emit(GenerateEventInvitationUrlState.loading());
    final result = await _eventRepository.generateEventInvitationUrl(
      eventId: event.eventId,
    );

    result.fold(
      (failure) => emit(GenerateEventInvitationUrlState.failure()),
      (response) {
        final baseUrl = '${AppConfig.webUrl}/e/${response.shortid}';
        // Add token parameter if available
        final invitationUrl =
            response.tk != null ? '$baseUrl?tk=${response.tk}' : baseUrl;

        emit(
          GenerateEventInvitationUrlState.success(
            invitationUrl: invitationUrl,
          ),
        );
      },
    );
  }
}

@freezed
class GenerateEventInvitationUrlEvent with _$GenerateEventInvitationUrlEvent {
  factory GenerateEventInvitationUrlEvent.generate({
    required String eventId,
  }) = GenerateEventInvitationUrlEventGenerate;
}

@freezed
class GenerateEventInvitationUrlState with _$GenerateEventInvitationUrlState {
  factory GenerateEventInvitationUrlState.initial() =
      GenerateEventInvitationUrlStateInitial;
  factory GenerateEventInvitationUrlState.loading() =
      GenerateEventInvitationUrlStateLoading;
  factory GenerateEventInvitationUrlState.success({
    required String invitationUrl,
  }) = GenerateEventInvitationUrlStateSuccess;
  factory GenerateEventInvitationUrlState.failure() =
      GenerateEventInvitationUrlStateFailure;
}
