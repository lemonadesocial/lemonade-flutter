import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'scroll_notification_bloc.freezed.dart';

class ScrollNotificationBloc
    extends Bloc<ScrollNotificationEvent, ScrollNotificationState> {
  ScrollNotificationBloc() : super(const ScrollNotificationState.initial()) {
    on<ScrollNotificationEventScroll>((event, emit) {
      emit(const ScrollNotificationState.initial());
    });
    on<ScrollNotificationEventReachEnd>(
      (event, emit) async {
        emit(const ScrollNotificationState.endReached());
      },
      transformer: droppable(),
    );
  }
}

@freezed
class ScrollNotificationEvent with _$ScrollNotificationEvent {
  const factory ScrollNotificationEvent.scroll() =
      ScrollNotificationEventScroll;
  const factory ScrollNotificationEvent.reachEnd() =
      ScrollNotificationEventReachEnd;
}

@freezed
class ScrollNotificationState with _$ScrollNotificationState {
  const factory ScrollNotificationState.initial() =
      ScrollNotificationStateInitial;
  const factory ScrollNotificationState.endReached() =
      ScrollNotificationStateEndReached;
}
