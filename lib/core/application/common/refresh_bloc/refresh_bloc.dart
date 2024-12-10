import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_bloc.freezed.dart';

class RefreshBloc extends Bloc<RefreshEvent, RefreshState> {
  RefreshBloc() : super(const RefreshState.initial()) {
    on<RefreshEvent>(_onRefreshEvent);
  }

  Future<void> _onRefreshEvent(
    RefreshEvent event,
    Emitter<RefreshState> emit,
  ) async {
    await event.map(
      refreshEvents: (_) async {
        emit(const RefreshState.refreshingEvents());
        await Future.delayed(const Duration(milliseconds: 100));
        emit(const RefreshState.initial());
      },
    );
  }
}

@freezed
class RefreshEvent with _$RefreshEvent {
  const factory RefreshEvent.refreshEvents() = RefreshEventsEventFetch;
}

@freezed
class RefreshState with _$RefreshState {
  const factory RefreshState.initial() = RefreshStateInitial;
  const factory RefreshState.refreshingEvents() = RefreshStateRefreshingEvents;
}
