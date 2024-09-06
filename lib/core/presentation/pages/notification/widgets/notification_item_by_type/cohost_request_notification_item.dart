import 'package:app/core/presentation/pages/notification/widgets/notification_item_by_type/notification_item_base.dart';
import 'package:app/core/presentation/pages/notification/widgets/notification_thumbnail.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/event/mutation/decide_event_cohost_request.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/core/domain/notification/entities/notification.dart'
    as notification_entities;

class CohostRequestNotificationItem extends StatelessWidget {
  final notification_entities.Notification notification;
  final Function()? onRemove;

  const CohostRequestNotificationItem({
    super.key,
    required this.notification,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return NotificationBaseItem(
      notification: notification,
      icon: ThemeSvgIcon(
        color: colorScheme.onSecondary,
        builder: (colorFilter) => Assets.icons.icHostOutline.svg(
          colorFilter: colorFilter,
          width: Sizing.small,
          height: Sizing.small,
        ),
      ),
      avatar: NotificationThumbnail(
        imageUrl: ImageUtils.generateUrl(
          file: notification.fromExpanded?.newPhotosExpanded?.isNotEmpty == true
              ? notification.fromExpanded?.newPhotosExpanded!.first
              : null,
        ),
        onTap: () {
          AutoRouter.of(context).push(
            ProfileRoute(
              userId: notification.from ?? '',
            ),
          );
        },
        radius: BorderRadius.circular(Sizing.medium),
      ),
      cover: NotificationThumbnail(
        imageUrl: notification.refEventExpanded != null
            ? EventUtils.getEventThumbnailUrl(
                event: notification.refEventExpanded!,
              )
            : '',
        onTap: () {
          AutoRouter.of(context).push(
            EventDetailRoute(eventId: notification.refEventExpanded?.id ?? ''),
          );
        },
        placeholder: ImagePlaceholder.eventCard(),
      ),
      action: SizedBox(
        height: Sizing.medium,
        child: LinearGradientButton.primaryButton(
          onTap: () async {
            final response = await showFutureLoadingDialog(
              context: context,
              future: () async {
                return await getIt<AppGQL>()
                    .client
                    .mutate$DecideEventCohostRequest(
                      Options$Mutation$DecideEventCohostRequest(
                        variables: Variables$Mutation$DecideEventCohostRequest(
                          input: Input$DecideEventCohostRequestInput(
                            event: notification.refEvent ?? '',
                            decision: true,
                          ),
                        ),
                      ),
                    );
              },
            );
            if (response.result?.parsedData?.decideEventCohostRequest == true) {
              onRemove?.call();
            }
          },
          textStyle: Typo.small.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
          label: t.common.actions.accept,
        ),
      ),
      extra: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (notification.fromExpanded?.username != null) ...[
            Text(
              '@${notification.fromExpanded?.username}',
              style: Typo.medium.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: Spacing.superExtraSmall),
          ],
          if (notification.fromExpanded?.description?.isNotEmpty == true ||
              notification.fromExpanded?.jobTitle?.isNotEmpty == true)
            Text(
              notification.fromExpanded?.description ??
                  notification.fromExpanded?.jobTitle ??
                  '',
              style: Typo.medium.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
        ],
      ),
    );
  }
}
