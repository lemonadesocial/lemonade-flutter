import 'package:app/core/domain/lens/entities/lens_post.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/graphql/backend/event/query/get_event.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class LensPostLemonadeEventThumbnail extends StatelessWidget {
  final LensLemonadeEventLink? lemonadeEventLink;
  const LensPostLemonadeEventThumbnail({
    super.key,
    this.lemonadeEventLink,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (lemonadeEventLink?.eventId?.isNotEmpty == true) {
          AutoRouter.of(context).push(
            EventDetailRoute(
              eventId: lemonadeEventLink!.eventId!,
            ),
          );
          return;
        }
        final shortId = lemonadeEventLink?.shortId;
        final response =
            await showFutureLoadingDialog<QueryResult<Query$GetEvent>>(
          context: context,
          future: () async {
            return await getIt<AppGQL>().client.query$GetEvent(
                  Options$Query$GetEvent(
                    variables: Variables$Query$GetEvent(shortid: shortId),
                  ),
                );
          },
        );
        final eventId = response.result?.parsedData?.getEvent?.$_id;
        if (eventId != null) {
          AutoRouter.of(context).push(
            EventDetailRoute(
              eventId: eventId,
            ),
          );
        }
      },
      child: LemonNetworkImage(
        imageUrl: lemonadeEventLink?.imageUrl ?? '',
        borderRadius: BorderRadius.circular(
          LemonRadius.sm,
        ),
      ),
    );
  }
}
