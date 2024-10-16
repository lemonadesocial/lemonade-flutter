import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_buy_tickets_prerequisite_check_bloc.freezed.dart';

class EventBuyTicketsPrerequisiteCheckBloc extends Bloc<
    EventBuyTicketsPrerequisiteCheckEvent,
    EventBuyTicketsPrerequisiteCheckState> {
  EventBuyTicketsPrerequisiteCheckBloc()
      : super(EventBuyTicketsPrerequisiteCheckState.initial()) {
    on<_EventBuyTicketsPrerequisiteCheck>(_onCheck);
  }

  void _onCheck(
    _EventBuyTicketsPrerequisiteCheck blocEvent,
    Emitter emit,
  ) async {
    emit(EventBuyTicketsPrerequisiteCheckState.checking());

    if (blocEvent.event.private == true) {
      if (!EventUtils.isInvited(blocEvent.event, userId: blocEvent.userId)) {
        emit(EventBuyTicketsPrerequisiteCheckState.isNotInvited());
        return;
      }
    }

    final checkApplicationResult =
        await _checkApplicationFormCompleted(blocEvent.event);
    final isCompleted = checkApplicationResult.value1;
    final user = checkApplicationResult.value2;
    if (!isCompleted) {
      emit(
        EventBuyTicketsPrerequisiteCheckState.applicationFormNotCompleted(
          user: user!,
        ),
      );
      return;
    }

    // NOTE: We let user buy ticket and BE will auto create join request

    // if (blocEvent.event.approvalRequired == true) {
    //   final joinRequest = await _checkEventJoinRequest(blocEvent.event);
    //   if (joinRequest == null) {
    //     final createdJoinRequest = await _createEventJoinRequest(blocEvent.event);
    //     if (createdJoinRequest != null) {
    //       emit(
    //         EventBuyTicketsPrerequisiteCheckState.hasJoinRequest(
    //           eventJoinRequest: createdJoinRequest,
    //         ),
    //       );
    //     }
    //   }
    // }
    emit(EventBuyTicketsPrerequisiteCheckState.allPassed());
  }

  // Future<EventJoinRequest?> _createEventJoinRequest(Event event) async {
  //   final result = await getIt<EventRepository>().createEventJoinRequest(eventId: event.id ?? '');
  //   return result.fold((l) => null, (r) => r);
  // }

  // Future<EventJoinRequest?> _checkEventJoinRequest(Event event) async {
  //   final result = await getIt<EventRepository>().getMyEventJoinRequest(eventId: event.id ?? '');
  //   return result.fold((l) => null, (r) => r);
  // }

  Future<Tuple2<bool, User?>> _checkApplicationFormCompleted(
    Event event,
  ) async {
    List<String> profileRequiredFields = (event.applicationProfileFields ?? [])
        .where((e) => e.required == true)
        .map((e) => e.field ?? '')
        .map(StringUtils.snakeToCamel)
        .toList();

    final userResult = await getIt<UserRepository>().getMe();

    User? user = userResult.fold((l) => null, (user) => user);
    if (user != null) {
      final alreadySubmitted = event.applicationFormSubmission != null;
      final hasRequiredProfileFields = profileRequiredFields.isNotEmpty;
      final hasApplicationQuestions =
          event.applicationQuestions?.isNotEmpty ?? false;
      if ((hasRequiredProfileFields && !alreadySubmitted) ||
          (hasApplicationQuestions && !alreadySubmitted)) {
        return Tuple2(false, user);
      }
      return Tuple2(true, user);
    }
    return Tuple2(true, user);
  }
}

@freezed
class EventBuyTicketsPrerequisiteCheckEvent
    with _$EventBuyTicketsPrerequisiteCheckEvent {
  factory EventBuyTicketsPrerequisiteCheckEvent.check({
    required Event event,
    required String userId,
  }) = _EventBuyTicketsPrerequisiteCheck;
}

@freezed
class EventBuyTicketsPrerequisiteCheckState
    with _$EventBuyTicketsPrerequisiteCheckState {
  factory EventBuyTicketsPrerequisiteCheckState.initial() =
      EventBuyTicketsPrerequisiteCheckStateInitial;
  factory EventBuyTicketsPrerequisiteCheckState.checking() =
      EventBuyTicketsPrerequisiteCheckStateChecking;
  factory EventBuyTicketsPrerequisiteCheckState.isNotInvited() =
      EventBuyTicketsPrerequisiteCheckStateIsNotInvited;
  factory EventBuyTicketsPrerequisiteCheckState.hasJoinRequest({
    required EventJoinRequest eventJoinRequest,
  }) = EventBuyTicketsPrerequisiteCheckStateHasJoinRequest;
  factory EventBuyTicketsPrerequisiteCheckState.applicationFormNotCompleted({
    required User user,
  }) = EventBuyTicketsPrerequisiteCheckStateApplicationFormNotCompleted;
  factory EventBuyTicketsPrerequisiteCheckState.allPassed() =
      EventBuyTicketsPrerequisiteCheckStateAllPassed;
}
