import 'package:app/core/domain/user/entities/user.dart';
// import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
// import 'package:app/core/service/matrix/matrix_service.dart';
// import 'package:app/core/utils/auth_utils.dart';
// import 'package:app/core/utils/matrix_utils.dart';
import 'package:app/gen/assets.gen.dart';
// import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GuestDirectoryItem extends StatelessWidget {
  final User guest;
  const GuestDirectoryItem({
    super.key,
    required this.guest,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // final currentUserId = AuthUtils.getUserId(context);
    // final isMe = currentUserId == guest.userId;

    return Container(
      padding: EdgeInsets.all(Spacing.smMedium),
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.circular(
          LemonRadius.normal,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  AutoRouter.of(context).navigate(
                    ProfileRoute(userId: guest.userId),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Sizing.xLarge),
                  child: SizedBox(
                    width: Sizing.xLarge,
                    height: Sizing.xLarge,
                    child: CachedNetworkImage(
                      imageUrl: guest.imageAvatar ?? '',
                      placeholder: (_, __) =>
                          ImagePlaceholder.defaultPlaceholder(),
                      errorWidget: (_, __, ___) =>
                          ImagePlaceholder.defaultPlaceholder(),
                    ),
                  ),
                ),
              ),
              // TODO: hide chat
              // if (!isMe)
              //   InkWell(
              //     onTap: () async {
              //       final matrixClient = getIt<MatrixService>().client;
              //       final response = await showFutureLoadingDialog(
              //         context: context,
              //         future: () => matrixClient.startDirectChat(
              //           LemonadeMatrixUtils.generateMatrixUserId(
              //             lemonadeMatrixLocalpart: guest.matrixLocalpart ?? '',
              //           ),
              //         ),
              //       );
              //       if (response.result == null) {
              //         return;
              //       }
              //       AutoRouter.of(context).navigate(
              //         ChatRoute(roomId: response.result ?? ''),
              //       );
              //     },
              //     child: Container(
              //       width: Sizing.medium,
              //       height: Sizing.medium,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(Sizing.medium),
              //         border: Border.all(color: colorScheme.outline),
              //       ),
              //       child: Center(
              //         child: ThemeSvgIcon(
              //           builder: (colorFilter) => Assets.icons.icChatBubble.svg(
              //             colorFilter: colorFilter,
              //             width: Sizing.xSmall,
              //             height: Sizing.xSmall,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
            ],
          ),
          SizedBox(height: Spacing.small),
          if (guest.name != null)
            Text(
              guest.name ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Typo.medium.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
          if (guest.username != null)
            Text(
              '@${guest.username}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Typo.small.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
          SizedBox(height: Spacing.small),
          if (guest.jobTitle != null)
            Row(
              children: [
                ThemeSvgIcon(
                  color: colorScheme.onSecondary,
                  builder: (colorFilter) => Assets.icons.icBriefcase.svg(
                    colorFilter: colorFilter,
                  ),
                ),
                SizedBox(width: Spacing.superExtraSmall),
                Text(
                  guest.jobTitle ?? '',
                  style: Typo.small.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          if (guest.companyName != null) ...[
            SizedBox(height: Spacing.superExtraSmall),
            Row(
              children: [
                ThemeSvgIcon(
                  color: colorScheme.onSecondary,
                  builder: (colorFilter) => Assets.icons.icBuilding.svg(
                    colorFilter: colorFilter,
                  ),
                ),
                SizedBox(width: Spacing.superExtraSmall),
                Text(
                  guest.companyName ?? '',
                  style: Typo.small.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
