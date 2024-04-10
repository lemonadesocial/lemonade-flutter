import 'package:app/core/utils/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'invite_event_bloc.freezed.dart';

class InviteEventBloc extends Bloc<InviteEventBlocEvent, InviteEventBlocState> {
  InviteEventBloc()
      : super(
          InviteEventBlocState(
            emails: [
              '',
            ],
            isValid: false,
          ),
        ) {
    on<InviteEventBlocEventUpdateEmail>(onUpdateEmail);
    on<InviteEventBlocEventAddNewEmail>(onAddNewEmail);
    on<InviteEventBlocEventRemoveEmail>(onRemoveEmail);
  }

  void onUpdateEmail(
    InviteEventBlocEventUpdateEmail event,
    Emitter emit,
  ) {
    final newEmails = state.emails.asMap().entries.map((entry) {
      if (entry.key == event.index) {
        return event.email;
      }
      return entry.value;
    }).toList();

    emit(
      _validate(state.copyWith(emails: newEmails)),
    );
  }

  void onAddNewEmail(
    InviteEventBlocEventAddNewEmail event,
    Emitter emit,
  ) {
    final newEmails = [...state.emails, ''];

    emit(
      _validate(
        state.copyWith(emails: newEmails),
      ),
    );
  }

  void onRemoveEmail(
    InviteEventBlocEventRemoveEmail event,
    Emitter emit,
  ) {
    List<String> newEmails = [...state.emails];
    newEmails.removeAt(event.index);

    emit(
      _validate(
        state.copyWith(emails: newEmails),
      ),
    );
  }

  InviteEventBlocState _validate(InviteEventBlocState state) {
    final allEmailsValid = state.emails
        .map((email) => EmailValidator.validate(email))
        .every((element) => element == true);

    return state.copyWith(
      isValid: state.emails.isNotEmpty && allEmailsValid,
    );
  }
}

@freezed
class InviteEventBlocEvent with _$InviteEventBlocEvent {
  factory InviteEventBlocEvent.updateEmail({
    required int index,
    required String email,
  }) = InviteEventBlocEventUpdateEmail;
  factory InviteEventBlocEvent.addNewEmail() = InviteEventBlocEventAddNewEmail;
  factory InviteEventBlocEvent.removeEmail({
    required int index,
  }) = InviteEventBlocEventRemoveEmail;
}

@freezed
class InviteEventBlocState with _$InviteEventBlocState {
  factory InviteEventBlocState({
    required List<String> emails,
    required bool isValid,
  }) = _InviteEventBlocState;
}
