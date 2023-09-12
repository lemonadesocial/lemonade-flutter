import 'dart:ui';

import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestEventDetailHosts extends StatelessWidget {
  const GuestEventDetailHosts({
    super.key,
    required this.event,
  });

  final Event event;

  List<User?> get hosts {
    final coHosts = event.cohostsExpanded ?? [];
    return coHosts.where((item) => item != null).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final userId = context.read<AuthBloc>().state.maybeWhen(
          orElse: () => '',
          authenticated: (session) => session.userId,
        );
    final isAttending = EventUtils.isAttending(event: event, userId: userId);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
          child: Text(
            StringUtils.capitalize(t.common.host(n: 2)),
            style: Typo.mediumPlus.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onPrimary,
            ),
          ),
        ),
        SizedBox(
          height: Spacing.xSmall,
        ),
        SizedBox(
          height: isAttending ? 178.w : 144.w,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(
              width: Spacing.extraSmall,
            ),
            itemCount: hosts.length,
            itemBuilder: (context, index) {
              final host = hosts[index];
              return _EventHostItem(
                host: host,
                colorScheme: colorScheme,
                isAttending: isAttending,
              );
            },
          ),
        )
      ],
    );
  }
}

class _EventHostItem extends StatelessWidget {
  const _EventHostItem({
    required this.host,
    required this.colorScheme,
    this.isAttending = false,
  });

  final User? host;
  final ColorScheme colorScheme;
  final bool isAttending;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AutoRouter.of(context).navigate(ProfileRoute(userId: host?.id ?? ''));
      },
      child: Container(
        width: 130.w,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.r),
          child: Stack(
            children: [
              Positioned.fill(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: 100,
                    sigmaY: 50,
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    placeholder: (_, __) => ImagePlaceholder.eventCard(),
                    errorWidget: (_, __, ___) => ImagePlaceholder.eventCard(),
                    imageUrl: ImageUtils.generateUrl(
                      file: host?.newPhotosExpanded?.first,
                      imageConfig: ImageConfig.eventPhoto,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Spacing.small,
                  horizontal: Spacing.extraSmall,
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60.w),
                        ),
                        width: 60.w,
                        height: 60.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60.r),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            placeholder: (_, __) =>
                                ImagePlaceholder.eventCard(),
                            errorWidget: (_, __, ___) =>
                                ImagePlaceholder.eventCard(),
                            imageUrl: ImageUtils.generateUrl(
                              file: host?.newPhotosExpanded?.first,
                              imageConfig: ImageConfig.eventPhoto,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Spacing.xSmall),
                      Text(
                        host?.displayName ?? host?.name ?? '',
                        style: Typo.small.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        host?.jobTitle ?? '',
                        style: Typo.small.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (isAttending) ...[
                        SizedBox(height: Spacing.xSmall),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 30.w,
                              padding: EdgeInsets.symmetric(
                                horizontal: Spacing.xSmall,
                              ),
                              decoration: ShapeDecoration(
                                color: colorScheme.onPrimary.withOpacity(0.06),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    LemonRadius.xSmall,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  t.common.actions.follow,
                                  style: Typo.small.copyWith(
                                    color: colorScheme.onSecondary,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: Spacing.superExtraSmall),
                            InkWell(
                              onTap: () {
                                AutoRouter.of(context)
                                    .navigate(const ChatListRoute());
                              },
                              child: Container(
                                height: 30.w,
                                padding: EdgeInsets.symmetric(
                                  horizontal: Spacing.superExtraSmall,
                                ),
                                decoration: ShapeDecoration(
                                  color:
                                      colorScheme.onPrimary.withOpacity(0.06),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      LemonRadius.xSmall,
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: ThemeSvgIcon(
                                    color: colorScheme.onSecondary,
                                    builder: (filter) =>
                                        Assets.icons.icChatBubble.svg(
                                      colorFilter: filter,
                                      width: Sizing.xSmall,
                                      height: Sizing.xSmall,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
