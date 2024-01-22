import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/entities/reward.dart';
import 'package:app/core/domain/event/repository/event_reward_repository.dart';
import 'package:app/core/domain/form/string_formz.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'modify_reward_bloc.freezed.dart';

class ModifyRewardBloc extends Bloc<ModifyRewardEvent, ModifyRewardState> {
  final Reward? initialReward;
  final Event? eventDetail;
  ModifyRewardBloc(this.initialReward, this.eventDetail)
      : super(ModifyRewardState.initial()) {
    on<_ModifyRewardEventOnTitleChanged>(_onTitleChanged);
    on<_ModifyRewardEventOnIconChanged>(_onIconChanged);
    on<_ModifyRewardEventOnLimitPerChanged>(_onLimitPerChanged);
    on<_ModifyRewardEventOnToggleSelectAll>(
      _onToggleSelectAll,
    );
    on<_ModifyRewardEventOnToggleTicketTier>(
      _onToggleEventTicketType,
    );
    on<_ModifyRewardEventOnValidate>(_onValidate);
    on<_ModifyRewardEventOnCreateSubmitted>(_onCreateSubmitted);
    on<_ModifyRewardEventOnEditSubmitted>(_onEditSubmitted);
    on<_ModifyRewardEventPopulateReward>(_onPopulateReward);
    if (initialReward != null) {
      add(ModifyRewardEvent.populateInitialReward());
    }
  }
  final _eventRepository = getIt<EventRewardRepository>();

  void _onTitleChanged(
    _ModifyRewardEventOnTitleChanged event,
    Emitter emit,
  ) {
    final newState = state.copyWith(
      title: StringFormz.dirty(event.title),
    );
    emit(_validate(newState));
  }

  void _onIconChanged(
    _ModifyRewardEventOnIconChanged event,
    Emitter emit,
  ) {
    final newState = state.copyWith(
      iconUrl: event.iconUrl,
    );
    emit(_validate(newState));
  }

  void _onLimitPerChanged(
    _ModifyRewardEventOnLimitPerChanged event,
    Emitter emit,
  ) {
    final newState = state.copyWith(
      limitPer: event.limitPer,
    );
    emit(_validate(newState));
  }

  void _onToggleSelectAll(
    _ModifyRewardEventOnToggleSelectAll event,
    Emitter emit,
  ) {
    List<String> eventTicketTypesIds =
        event.eventTicketTypes.map((obj) => obj.id ?? '').toList();
    if (event.value == true) {
      final newState = state.copyWith(
        selectedEventTicketTypeIds: eventTicketTypesIds,
      );
      emit(_validate(newState));
    } else {
      final newState = state.copyWith(
        selectedEventTicketTypeIds: [],
      );
      emit(_validate(newState));
    }
  }

  void _onToggleEventTicketType(
    _ModifyRewardEventOnToggleTicketTier event,
    Emitter emit,
  ) {
    // Deselect if exist
    if (state.selectedEventTicketTypeIds.contains(event.eventTicketTypeId)) {
      final newState = state.copyWith(
        selectedEventTicketTypeIds: state.selectedEventTicketTypeIds
            .where((id) => id != event.eventTicketTypeId)
            .toList(),
      );
      emit(_validate(newState));
    }
    // Add new if not exist yet
    else {
      final newState = state.copyWith(
        selectedEventTicketTypeIds: [
          ...state.selectedEventTicketTypeIds,
          event.eventTicketTypeId ?? '',
        ],
      );
      emit(_validate(newState));
    }
  }

  void _onValidate(
    _ModifyRewardEventOnValidate event,
    Emitter emit,
  ) {
    emit(_validate(state));
  }

  ModifyRewardState _validate(ModifyRewardState state) {
    final isValid = Formz.validate([
          state.title,
        ]) &&
        state.selectedEventTicketTypeIds.isNotEmpty;
    return state.copyWith(isValid: isValid);
  }

  void _onCreateSubmitted(
    _ModifyRewardEventOnCreateSubmitted event,
    Emitter emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final title = StringFormz.dirty(state.title.value);
    _validate(state.copyWith(title: title));
    if (state.isValid) {
      final result = await _eventRepository.createEventReward(
        input: [
          ...event.existingRewards
              .map(
                (reward) => Input$EventRewardInput(
                  $_id: reward.id,
                  active: true,
                  title: reward.title!,
                  limit: reward.limit?.toDouble(),
                  limit_per: reward.limitPer!.toDouble(),
                  icon_color: reward.iconColor,
                  icon_url: reward.iconUrl,
                ),
              )
              .toList(),
          Input$EventRewardInput(
            active: true,
            title: title.value,
            limit_per: state.limitPer ?? 1,
            payment_ticket_types: state.selectedEventTicketTypeIds,
            icon_url: state.iconUrl,
          ),
        ],
        eventId: event.eventId,
      );
      result.fold(
        (failure) =>
            emit(state.copyWith(status: FormzSubmissionStatus.failure)),
        (createEvent) =>
            emit(state.copyWith(status: FormzSubmissionStatus.success)),
      );
    }
  }

  void _onEditSubmitted(
    _ModifyRewardEventOnEditSubmitted event,
    Emitter emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final title = StringFormz.dirty(state.title.value);
    _validate(state.copyWith(title: title));
    if (state.isValid) {
      final result = await _eventRepository.updateEventReward(
        input: [
          ...event.existingRewards.map(
            (reward) {
              if (reward.id == initialReward?.id) {
                return Input$EventRewardInput(
                  active: true,
                  title: title.value,
                  limit_per: state.limitPer ?? 1,
                  payment_ticket_types: state.selectedEventTicketTypeIds,
                  icon_url: state.iconUrl,
                );
              }
              return Input$EventRewardInput(
                $_id: reward.id,
                active: true,
                title: reward.title!,
                limit: reward.limit?.toDouble(),
                limit_per: reward.limitPer!.toDouble(),
                icon_color: reward.iconColor,
                icon_url: reward.iconUrl,
              );
            },
          ).toList(),
        ],
        eventId: event.eventId,
      );
      result.fold(
        (failure) =>
            emit(state.copyWith(status: FormzSubmissionStatus.failure)),
        (createEvent) =>
            emit(state.copyWith(status: FormzSubmissionStatus.success)),
      );
    }
  }

  void _onPopulateReward(
    _ModifyRewardEventPopulateReward event,
    Emitter emit,
  ) {
    if (initialReward == null) {
      return;
    }
    List<String> eventTicketTypesIds =
        eventDetail?.eventTicketTypes?.map((obj) => obj.id ?? '').toList() ??
            [];
    emit(
      _validate(
        ModifyRewardState(
          title: StringFormz.pure(initialReward?.title ?? ''),
          iconUrl: initialReward?.iconUrl,
          limitPer: initialReward?.limitPer?.toDouble(),
          selectedEventTicketTypeIds:
              initialReward?.paymentTicketTypes ?? eventTicketTypesIds,
          isValid: false,
        ),
      ),
    );
  }
}

@freezed
class ModifyRewardEvent with _$ModifyRewardEvent {
  factory ModifyRewardEvent.onTitleChanged({
    required String title,
  }) = _ModifyRewardEventOnTitleChanged;
  factory ModifyRewardEvent.onIconChanged({
    required String iconUrl,
  }) = _ModifyRewardEventOnIconChanged;
  factory ModifyRewardEvent.onLimitPerChanged({
    required double? limitPer,
  }) = _ModifyRewardEventOnLimitPerChanged;
  factory ModifyRewardEvent.onToggleSelectAll({
    required bool value,
    required List<EventTicketType> eventTicketTypes,
  }) = _ModifyRewardEventOnToggleSelectAll;
  factory ModifyRewardEvent.onToggleEventTicketType({
    required String? eventTicketTypeId,
  }) = _ModifyRewardEventOnToggleTicketTier;
  factory ModifyRewardEvent.onValidate() = _ModifyRewardEventOnValidate;
  factory ModifyRewardEvent.onCreateSubmitted({
    required String eventId,
    required List<Reward> existingRewards,
  }) = _ModifyRewardEventOnCreateSubmitted;
  factory ModifyRewardEvent.onEditSubmitted({
    required String eventId,
    required List<Reward> existingRewards,
  }) = _ModifyRewardEventOnEditSubmitted;
  factory ModifyRewardEvent.populateInitialReward() =
      _ModifyRewardEventPopulateReward;
}

@freezed
class ModifyRewardState with _$ModifyRewardState {
  factory ModifyRewardState({
    required StringFormz title,
    String? iconUrl,
    double? limitPer,
    required List<String> selectedEventTicketTypeIds,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    @Default(false) bool isValid,
  }) = _ModifyRewardState;

  factory ModifyRewardState.initial() => ModifyRewardState(
        title: const StringFormz.pure(),
        limitPer: 1,
        iconUrl: null,
        selectedEventTicketTypeIds: [],
        isValid: false,
      );
}
