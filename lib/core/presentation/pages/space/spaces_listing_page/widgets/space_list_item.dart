import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/graphql/backend/event/query/get_upcoming_events.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum SpaceListItemLayout {
  list,
  grid,
}

class SpaceListItem extends StatefulWidget {
  final Space space;
  final VoidCallback? onTap;
  final SpaceListItemLayout layout;
  final bool featured;

  const SpaceListItem({
    super.key,
    required this.space,
    this.onTap,
    this.layout = SpaceListItemLayout.list,
    this.featured = false,
  });

  @override
  State<SpaceListItem> createState() => _SpaceListItemState();
}

class _SpaceListItemState extends State<SpaceListItem> {
  Widget get spaceThumbnail => LemonNetworkImage(
        width: widget.layout == SpaceListItemLayout.grid ? 42.w : 48.w,
        height: widget.layout == SpaceListItemLayout.grid ? 42.w : 48.w,
        imageUrl: widget.space.imageAvatar?.url ?? '',
        fit: BoxFit.cover,
        borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
        placeholder: ImagePlaceholder.spaceThumbnail(
          iconColor: Theme.of(context).colorScheme.onSecondary,
        ),
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.outline,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final userId = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user.userId,
        );
    final followersCount = widget.space.followers?.length ?? 0;
    final isAdmin = widget.space.isAdmin(userId: userId ?? '');
    final isOwner = widget.space.isCreator(userId: userId ?? '');

    return InkWell(
      onTap: widget.onTap,
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
          child: widget.layout == SpaceListItemLayout.grid
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spaceThumbnail,
                    SizedBox(height: Spacing.xSmall),
                    Text(
                      widget.space.title ?? '',
                      style: Typo.medium.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )
              : Row(
                  children: [
                    spaceThumbnail,
                    SizedBox(width: Spacing.small),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.space.title ?? '',
                            style: Typo.mediumPlus.copyWith(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.h),
                          if (widget.featured)
                            Text(
                              widget.space.description ?? '',
                              style: Typo.small.copyWith(
                                color: colorScheme.onSecondary,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 2,
                            )
                          else if (isAdmin ||
                              isOwner ||
                              widget.space.isAmbassador == true)
                            Text(
                              widget.featured
                                  ? ''
                                  : '$followersCount ${t.common.subscriber(n: followersCount)}',
                              style: Typo.small.copyWith(
                                color: colorScheme.onSecondary,
                              ),
                            )
                          else
                            Query$GetUpcomingEvents$Widget(
                              options: Options$Query$GetUpcomingEvents(
                                variables: Variables$Query$GetUpcomingEvents(
                                  space: widget.space.id,
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
                                      : t.event.upcomingEvents(
                                          n: upcomingEvents.length,
                                        ),
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
