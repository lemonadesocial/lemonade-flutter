import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/graphql/backend/event/query/get_upcoming_events.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpaceListItem extends StatelessWidget {
  final Space space;
  final VoidCallback? onTap;

  const SpaceListItem({
    super.key,
    required this.space,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final userId = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user.userId,
        );
    final followersCount = space.followers?.length ?? 0;
    final isAdmin = space.isAdmin(userId: userId ?? '');
    final isOwner = space.isCreator(userId: userId ?? '');

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: LemonColor.atomicBlack,
          borderRadius: BorderRadius.circular(LemonRadius.small),
          border: Border.all(
            color: colorScheme.outline,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(Spacing.small),
          child: Row(
            children: [
              LemonNetworkImage(
                width: Sizing.medium,
                height: Sizing.medium,
                imageUrl: space.imageAvatar?.url ?? '',
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
                placeholder: ImagePlaceholder.spaceThumbnail(
                  iconColor: colorScheme.onSecondary,
                ),
              ),
              SizedBox(width: Spacing.small),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      space.title ?? '',
                      style: Typo.mediumPlus.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    if (isAdmin || isOwner || space.isAmbassador == true)
                      Text(
                        '$followersCount ${t.common.subscriber(n: followersCount)}',
                        style: Typo.small.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      )
                    else
                      Query$GetUpcomingEvents$Widget(
                        options: Options$Query$GetUpcomingEvents(
                          variables: Variables$Query$GetUpcomingEvents(
                            space: space.id,
                            limit: 20,
                          ),
                        ),
                        builder: (
                          result, {
                          refetch,
                          fetchMore,
                        }) {
                          final upcomingEvents =
                              result.parsedData?.getUpcomingEvents ?? [];
                          return Text(
                            result.isLoading
                                ? '--'
                                : t.event
                                    .upcomingEvents(n: upcomingEvents.length),
                            style: Typo.small.copyWith(
                              color: colorScheme.onSecondary,
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
