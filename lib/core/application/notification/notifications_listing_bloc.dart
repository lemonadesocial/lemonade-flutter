import 'package:app/core/domain/notification/entities/notification.dart';
import 'package:app/core/service/notification/notification_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notifications_listing_bloc.freezed.dart';

class NotificationsListingBloc extends Bloc<NotificationsListingEvent, NotificationsListingState> {
  final NotificationService notificationService;
  NotificationsListingBloc(this.notificationService) : super(NotificationsListingState.loading()) {
    on<NotificationsListingEventFetch>(_onFetch);
    on<NotificationsListingEventRemoveItem>(_onRemoveItem);
  }

  _onFetch(NotificationsListingEventFetch event, Emitter emit) async {
    final result = await notificationService.getNotifications();
    result.fold(
      (l) => emit(NotificationsListingState.failure()),
      (notifications) => emit(
        NotificationsListingState.fetched(
          notifications: notifications,
        ),
      ),
    );
  }

  _onRemoveItem(NotificationsListingEventRemoveItem event, Emitter emit) async {
    List<Notification> currentList = state.maybeWhen(
      fetched: (notifications) => notifications,
      orElse: () => [],
    );
    List<Notification> newList = currentList.where((item) => item.id != event.notification.id).toList();
    emit(NotificationsListingState.fetched(notifications: newList));
  }
}

@freezed
class NotificationsListingState with _$NotificationsListingState {
  factory NotificationsListingState.loading() = NotificationsListingStateLoading;
  factory NotificationsListingState.fetched({
    required List<Notification> notifications,
  }) = NotificationsListingStateFetched;
  factory NotificationsListingState.failure() = NotificationsListingStateFailure;
}

@freezed
class NotificationsListingEvent with _$NotificationsListingEvent {
  factory NotificationsListingEvent.fetch() = NotificationsListingEventFetch;
  factory NotificationsListingEvent.removeItem({
    required int index,
    required Notification notification,
  }) = NotificationsListingEventRemoveItem;
}
