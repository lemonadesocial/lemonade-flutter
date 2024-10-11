import 'package:app/core/presentation/pages/notification/widgets/notification_item_by_type/notification_item_base.dart';
import 'package:app/core/presentation/pages/notification/widgets/notification_thumbnail.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/event/mutation/decide_user_join_request.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/core/domain/notification/entities/notification.dart'
    as notification_entities;
import 'package:matrix/matrix.dart';

class EventJoinRequestNotificationItem extends StatelessWidget {
  final notification_entities.Notification notification;
  final Function()? onRemove;
  const EventJoinRequestNotificationItem({
    super.key,
    required this.notification,
    this.onRemove,
  });

  Future<void> _decideJoinRequest(
    BuildContext context, {
    required String eventId,
    required String joinRequestId,
    required Enum$EventJoinRequestState decision,
  }) async {
    final response = await showFutureLoadingDialog(
      context: context,
      future: () {
        return getIt<AppGQL>().client.mutate$DecideUserJoinRequests(
              Options$Mutation$DecideUserJoinRequests(
                variables: Variables$Mutation$DecideUserJoinRequests(
                  input: Input$DecideUserJoinRequestsInput(
                    decision: decision,
                    event: eventId,
                    requests: [joinRequestId],
                  ),
                ),
              ),
            );
      },
    );
    if (response.result?.parsedData?.decideUserJoinRequests.isNotEmpty ==
        true) {
      onRemove?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final joinRequestId =
        notification.data?.tryGet('event_join_request_id') as String? ?? '';
    final eventId = notification.refEvent ?? '';
    return NotificationBaseItem(
      notification: notification,
      icon: ThemeSvgIcon(
        color: colorScheme.onSecondary,
        builder: (colorFilter) => Assets.icons.icOutlineVerified.svg(
          colorFilter: colorFilter,
          width: Sizing.small,
          height: Sizing.small,
        ),
      ),
      avatar: notification.fromExpanded != null ||
              notification.refUserExpanded != null
          ? NotificationThumbnail(
              imageUrl: notification.fromExpanded?.imageAvatar ??
                  notification.refUserExpanded?.imageAvatar ??
                  '',
              onTap: () {
                AutoRouter.of(context).push(
                  ProfileRoute(
                    userId: notification.fromExpanded?.userId ??
                        notification.refUserExpanded?.userId ??
                        '',
                  ),
                );
              },
              radius: BorderRadius.circular(Sizing.medium),
              placeholder: ImagePlaceholder.avatarPlaceholder(
                radius: BorderRadius.circular(Sizing.medium),
              ),
            )
          : null,
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
      action:
          notification.type == Enum$NotificationType.event_request_created.name
              ? Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // TODO: temporary not calling getApplicantInfo cause we cannot know
                    // if user already has submit the application form
                    // so calling this may cause throwing error
                    // FutureBuilder(
                    //   future: getIt<ApplicantRepository>().getApplicantInfo(
                    //     userId: notification.from ?? '',
                    //     eventId: notification.refEvent ?? '',
                    //   ),
                    //   builder: ((context, snapshot) {
                    //     Applicant? applicant = snapshot.data?.fold(
                    //       (l) => null,
                    //       (applicant) => applicant,
                    //     );
                    //     if (applicant == null) return const SizedBox.shrink();
                    //     final t = Translations.of(context);
                    //     return Row(
                    //       children: [
                    //         ThemeSvgIcon(
                    //           color: colorScheme.onSecondary,
                    //           builder: (colorFilter) => _Icon(
                    //             onTap: () {
                    //               showCupertinoModalBottomSheet(
                    //                 context: context,
                    //                 backgroundColor: LemonColor.atomicBlack,
                    //                 builder: (mContext) {
                    //                   return Column(
                    //                     children: [
                    //                       const BottomSheetGrabber(),
                    //                       LemonAppBar(
                    //                         leading: const SizedBox.shrink(),
                    //                         backgroundColor: LemonColor.atomicBlack,
                    //                         title: t.event.applicationForm
                    //                             .applicationFormTitle,
                    //                       ),
                    //                       Expanded(
                    //                         child: CustomScrollView(
                    //                           slivers: [
                    //                             SliverPadding(
                    //                               padding: EdgeInsets.symmetric(
                    //                                 horizontal: Spacing.xSmall,
                    //                               ),
                    //                               sliver:
                    //                                   EventJoinRequestApplicationForm(
                    //                                 applicant: applicant,
                    //                                 event: notification
                    //                                     .refEventExpanded,
                    //                               ),
                    //                             ),
                    //                           ],
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   );
                    //                 },
                    //               );
                    //             },
                    //             icon: Assets.icons.icApplication.svg(
                    //               colorFilter: colorFilter,
                    //             ),
                    //           ),
                    //         ),
                    //         SizedBox(width: Spacing.extraSmall),
                    //       ],
                    //     );
                    //   }),
                    // ),
                    ThemeSvgIcon(
                      color: LemonColor.coralReef,
                      builder: (colorFilter) => _Icon(
                        onTap: () {
                          _decideJoinRequest(
                            context,
                            eventId: eventId,
                            joinRequestId: joinRequestId,
                            decision: Enum$EventJoinRequestState.declined,
                          );
                        },
                        icon: Assets.icons.icClose.svg(
                          colorFilter: colorFilter,
                        ),
                      ),
                    ),
                    SizedBox(width: Spacing.extraSmall),
                    ThemeSvgIcon(
                      color: LemonColor.paleViolet,
                      builder: (colorFilter) => _Icon(
                        onTap: () {
                          _decideJoinRequest(
                            context,
                            eventId: eventId,
                            joinRequestId: joinRequestId,
                            decision: Enum$EventJoinRequestState.approved,
                          );
                        },
                        icon: Assets.icons.icDone.svg(
                          colorFilter: colorFilter,
                        ),
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
    );
  }
}

class _Icon extends StatelessWidget {
  final Widget icon;
  final Function()? onTap;

  const _Icon({
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Sizing.medium,
        height: Sizing.medium,
        decoration: BoxDecoration(
          color: LemonColor.atomicBlack,
          borderRadius: BorderRadius.circular(Sizing.medium),
        ),
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}
