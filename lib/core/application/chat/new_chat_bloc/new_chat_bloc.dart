import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:matrix/matrix.dart';

part 'new_chat_bloc.freezed.dart';

class NewChatBloc extends Bloc<NewChatEvent, NewChatState> {
  final matrixService = getIt<MatrixService>();

  NewChatBloc()
      : super(
          const NewChatState(
            userSearchResult: null,
          ),
        ) {
    on<NewChatEventSearchUsers>(_onSearchUsers);
  }

  _onSearchUsers(NewChatEventSearchUsers event, Emitter emit) async {
    var text = event.text;
    final result = await matrixService.client.searchUserDirectory(
      text!,
      limit: 20,
    );
    emit(state.copyWith(userSearchResult: result));
  }
}

@freezed
class NewChatEvent with _$NewChatEvent {
  const factory NewChatEvent.searchUsers({
    String? text,
  }) = NewChatEventSearchUsers;
}

@freezed
class NewChatState with _$NewChatState {
  const factory NewChatState({
    required SearchUserDirectoryResponse? userSearchResult,
  }) = _NewChatState;
}
