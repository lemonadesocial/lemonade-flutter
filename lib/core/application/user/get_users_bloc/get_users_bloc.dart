import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

part 'get_users_bloc.freezed.dart';

class GetUsersBloc extends Bloc<GetUsersEvent, GetUsersState> {
  final _userRepository = getIt<UserRepository>();
  GetUsersBloc() : super(GetUsersState.initial()) {
    on<GetUsersEventFetch>(
      _onFetch,
      transformer: (events, mapper) {
        return events
            .debounceTime(const Duration(milliseconds: 300))
            .asyncExpand(mapper);
      },
    );
    on<GetUsersEventReset>(_onReset);
  }

  void _onFetch(GetUsersEventFetch event, Emitter emit) async {
    emit(GetUsersState.loading());
    final result = await _userRepository.getUsers(
      skip: 0,
      limit: event.limit ?? 5,
      search: event.search,
    );
    result.fold(
      (failure) => emit(GetUsersState.failure()),
      (users) => emit(
        GetUsersState.success(
          users: users,
        ),
      ),
    );
  }

  void _onReset(GetUsersEventReset event, Emitter emit) async {
    emit(GetUsersState.initial());
    emit(
      GetUsersState.success(
        users: [],
      ),
    );
  }
}

@freezed
class GetUsersEvent with _$GetUsersEvent {
  factory GetUsersEvent.fetch({
    int? skip,
    int? limit,
    String? search,
  }) = GetUsersEventFetch;

  factory GetUsersEvent.reset() = GetUsersEventReset;
}

@freezed
class GetUsersState with _$GetUsersState {
  factory GetUsersState.initial() = GetUsersStateInitial;
  factory GetUsersState.loading() = GetUsersStateLoading;
  factory GetUsersState.success({
    required List<User> users,
  }) = GetUsersStateSuccess;
  factory GetUsersState.failure() = GetUsersStateFailure;
}
