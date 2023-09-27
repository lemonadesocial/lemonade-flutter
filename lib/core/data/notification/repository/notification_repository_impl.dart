import 'package:app/core/data/notification/dtos/notification_dtos.dart';
import 'package:app/core/data/notification/notification_query.dart';
import 'package:app/core/domain/notification/entities/notification.dart';
import 'package:app/core/domain/notification/notification_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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
}
