import 'package:app/core/data/notification/notification_mutation.dart';
import 'package:app/core/data/notification/dtos/notification_dtos.dart';
import 'package:app/core/data/notification/notification_query.dart';
import 'package:app/core/data/notification/notification_subscription.dart';
import 'package:app/core/domain/notification/entities/notification.dart';
import 'package:app/core/domain/notification/input/delete_notifications_input.dart';
import 'package:app/core/domain/notification/notification_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  final client = getIt<AppGQL>().client;

  @override
  Future<Either<Failure, List<Notification>>> getNotifications() async {
    final result = await client.query<List<Notification>>(
      QueryOptions(
        document: getNotificationsQuery,
        parserFn: (data) => List.from(data['getNotifications'])
            .map(
              (item) => Notification.fromDto(NotificationDto.fromJson(item)),
            )
            .toList(),
      ),
    );
    if (result.hasException) {
      return Left(Failure());
    }
    return Right(result.parsedData ?? []);
  }

  @override
  Future<Either<Failure, bool>> deleteNotifications({
    required DeleteNotificationsInput input,
  }) async {
    final result = await client.mutate<bool>(
      MutationOptions(
        document: deleteNotificationsMutation,
        parserFn: (data) => data['deleteNotifications'] ?? false,
        variables: input.toJson(),
        update: (cache, result) {
          if (result?.parsedData != true) return;
          final data = cache.readQuery(
            Request(
              operation: Operation(
                document: getNotificationsQuery,
              ),
            ),
          );
          if (data == null) return;
          data['getNotifications'] = (data['getNotifications'] ?? [])
              .where((element) => element['_id'] != input.ids[0])
              .toList();
          cache.writeQuery(
            Request(
              operation: Operation(
                document: getNotificationsQuery,
              ),
            ),
            data: data,
          );
        },
      ),
    );
    if (result.hasException) {
      return Left(Failure());
    }
    return Right(result.parsedData!);
  }

  @override
  Stream<Either<Failure, Notification>> watchNotifications() {
    final stream = client.subscribe(
      SubscriptionOptions(
        document: watchNotificationSubscription,
        fetchPolicy: FetchPolicy.networkOnly,
        parserFn: (data) {
          return Notification.fromDto(
            NotificationDto.fromJson(data['notificationCreated']),
          );
        },
      ),
    );

    return stream.asyncMap((resultEvent) {
      if (resultEvent.hasException) return Left(Failure());
      return Right(resultEvent.parsedData!);
    });
  }
}
