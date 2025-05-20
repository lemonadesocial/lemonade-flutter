import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/graphql/backend/event/query/get_upcoming_events.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';

enum SpaceListItemLayout {
  list,
  grid,
  horizontal,
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
        borderRadius: BorderRadius.circular(LemonRadius.xs),
        placeholder: ImagePlaceholder.spaceThumbnail(
          iconColor: Theme.of(context).colorScheme.onSecondary,
        ),
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.outline,
        ),
      );

  Widget get coverImageMode {
    final appTextTheme = Theme.of(context).appTextTheme;
    final appColors = Theme.of(context).appColors;

    return Container(
      width: 132.w,
      height: 132.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(LemonRadius.md),
        border: Border.all(
          width: 1,
          color: appColors.cardBorder,
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        fit: StackFit.expand,
        children: [
          // Base image
          ClipRRect(
            borderRadius: BorderRadius.circular(LemonRadius.md),
            child: Image.network(
              widget.space.getSpaceImageUrl(),
              fit: BoxFit.cover,
              alignment: Alignment.center,
              errorBuilder: (
                BuildContext context,
                Object exception,
                StackTrace? stackTrace,
              ) {
                return ImagePlaceholder.spaceThumbnail(
                  iconColor: appColors.textSecondary,
                );
              },
            ),
          ),
          // Blur and gradient overlay
          ClipRRect(
            borderRadius: BorderRadius.circular(LemonRadius.md),
            child: Stack(
              children: [
                ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: 16.w,
                    sigmaY: 16.w,
                  ),
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black,
                          Colors.black,
                          Colors.black,
                          Colors.black38,
                          Colors.transparent,
                        ],
                        stops: [0.2, 0.4, 0.6, 0.75, 0.85],
                      ).createShader(rect);
                    },
                    blendMode: BlendMode.dstOut,
                    child: Image.network(
                      widget.space.getSpaceImageUrl(),
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      errorBuilder: (
                        BuildContext context,
                        Object exception,
                        StackTrace? stackTrace,
                      ) {
                        return ImagePlaceholder.spaceThumbnail(
                          iconColor: appColors.textSecondary,
                        );
                      },
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.3),
                          ],
                          stops: const [0.3, 0.9],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.65),
                            Colors.transparent,
                          ],
                          stops: const [0.2, 0.8],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Text content
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.space.title ?? '',
                  style: appTextTheme.sm.copyWith(
                    color: appColors.textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appColors = Theme.of(context).appColors;
    final appTextTheme = Theme.of(context).appTextTheme;
    final userId = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user.userId,
        );
    final followersCount = widget.space.followers?.length ?? 0;
    final isAdmin = widget.space.isAdmin(userId: userId ?? '');
    final isOwner = widget.space.isCreator(userId: userId ?? '');

    return InkWell(
      onTap: widget.onTap,
      child: widget.layout == SpaceListItemLayout.horizontal
          ? coverImageMode
          : Container(
              decoration: BoxDecoration(
                color: appColors.cardBg,
                borderRadius: BorderRadius.circular(LemonRadius.md),
                border: Border.all(
                  color: appColors.cardBorder,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(14.w),
                child: widget.layout == SpaceListItemLayout.grid
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          spaceThumbnail,
                          SizedBox(height: Spacing.xSmall),
                          Text(
                            widget.space.title ?? '',
                            style: appTextTheme.md.copyWith(
                              color: appColors.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )
                    : widget.layout == SpaceListItemLayout.horizontal
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              spaceThumbnail,
                              SizedBox(height: Spacing.xSmall),
                              SizedBox(
                                width: 80.w,
                                child: Text(
                                  widget.space.title ?? '',
                                  style: appTextTheme.md.copyWith(
                                    color: appColors.textPrimary,
                                  ),
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
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
                                      style: appTextTheme.md.copyWith(
                                        color: appColors.textPrimary,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: Spacing.s0_5),
                                    if (widget.featured)
                                      Text(
                                        widget.space.description ?? '',
                                        style: appTextTheme.sm.copyWith(
                                          color: appColors.textSecondary,
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
                                        style: appTextTheme.sm.copyWith(
                                          color: appColors.textSecondary,
                                        ),
                                      )
                                    else
                                      Query$GetUpcomingEvents$Widget(
                                        options:
                                            Options$Query$GetUpcomingEvents(
                                          variables:
                                              Variables$Query$GetUpcomingEvents(
                                            space: widget.space.id,
                                            limit: 20,
                                          ),
                                        ),
                                        builder: (
                                          result, {
                                          refetch,
                                          fetchMore,
                                        }) {
                                          final upcomingEvents = result
                                                  .parsedData
                                                  ?.getUpcomingEvents ??
                                              [];
                                          return Text(
                                            result.isLoading
                                                ? '--'
                                                : t.event.upcomingEvents(
                                                    n: upcomingEvents.length,
                                                  ),
                                            style: appTextTheme.sm.copyWith(
                                              color: appColors.textSecondary,
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
