import 'package:app/core/domain/collaborator/entities/user_discovery_swipe/user_discovery_swipe.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/widgets/collaborator_counter_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/matrix_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matrix/matrix.dart';
import 'package:sliver_tools/sliver_tools.dart';

class MatchedSwipeRoom {
  final UserDiscoverySwipe swipe;
  final Room room;

  MatchedSwipeRoom({
    required this.room,
    required this.swipe,
  });
}

class CollaboratorChatList extends StatelessWidget {
  final List<UserDiscoverySwipe> matchedSwipes;
  const CollaboratorChatList({
    super.key,
    required this.matchedSwipes,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return MultiSliver(
      children: [
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                Text(
                  t.collaborator.matches,
                  style: Typo.mediumPlus.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
                SizedBox(
                  width: Spacing.extraSmall,
                ),
                CollaboratorCounter(
                  count: matchedSwipes.length,
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: Spacing.xSmall)),
        if (matchedSwipes.isEmpty)
          SliverToBoxAdapter(
            child: EmptyList(
              emptyText: t.collaborator.emptyMatches,
            ),
          ),
        if (matchedSwipes.isNotEmpty)
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
            sliver: SliverList.separated(
              itemCount: matchedSwipes.length,
              itemBuilder: (context, index) => _ChatItem(
                swipe: matchedSwipes[index],
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: Spacing.small,
              ),
            ),
          ),
      ],
    );
  }
}

class _ChatItem extends StatelessWidget {
  final UserDiscoverySwipe swipe;
  const _ChatItem({
    required this.swipe,
  });

  Future<String> getRoomId() async {
    final matrixClient = getIt<MatrixService>().client;
    return await matrixClient.startDirectChat(
      LemonadeMatrixUtils.generateMatrixUserId(
        lemonadeMatrixLocalpart: swipe.otherExpanded?.matrixLocalpart ?? '',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () async {
        final result = await showFutureLoadingDialog(
          context: context,
          future: () => getRoomId(),
        );
        if (result.result != null) {
          AutoRouter.of(context).push(
            ChatRoute(
              roomId: result.result!,
            ),
          );
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              LemonNetworkImage(
                borderRadius: BorderRadius.circular(42.w),
                imageUrl: swipe.otherExpanded?.imageAvatar ?? '',
                width: 42.w,
                height: 42.w,
                placeholder: ImagePlaceholder.defaultPlaceholder(
                  radius: BorderRadius.circular(42.w),
                ),
                fit: BoxFit.cover,
              ),
            ],
          ),
          SizedBox(width: Spacing.xSmall),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    swipe.otherExpanded?.name ?? '',
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateFormatUtils.timeOnly(swipe.stamp),
                style: Typo.small.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
