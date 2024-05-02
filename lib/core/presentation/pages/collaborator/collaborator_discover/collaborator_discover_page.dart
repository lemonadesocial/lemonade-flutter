import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_actions_bar.dart';
import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_declined_overlay.dart';
import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_view.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/widgets/collaborator_send_like_bottomsheet/collaborator_send_like_bottomsheet.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

@RoutePage()
class CollaboratorDiscoverPage extends StatefulWidget {
  const CollaboratorDiscoverPage({super.key});

  @override
  State<CollaboratorDiscoverPage> createState() =>
      _CollaboratorDiscoverPageState();
}

class _CollaboratorDiscoverPageState extends State<CollaboratorDiscoverPage> {
  bool? isVisibleDeclinedOverlay = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: LemonAppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Spacing.medium),
            child: InkWell(
              onTap: () {},
              child: Icon(
                Icons.filter_alt_outlined,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: Spacing.medium),
            child: InkWell(
              onTap: () {
                AutoRouter.of(context).push(const CollaboratorLikesRoute());
              },
              child: Icon(
                Icons.favorite_border,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: Spacing.smMedium),
            child: InkWell(
              onTap: () {
                AutoRouter.of(context).push(const CollaboratorChatRoute());
              },
              child: ThemeSvgIcon(
                color: colorScheme.onPrimary,
                builder: (filter) => Assets.icons.icChatBubble.svg(
                  colorFilter: filter,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: Spacing.xSmall),
            child: InkWell(
              onTap: () {},
              child: Icon(
                Icons.more_vert,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                const CollaboratorDiscoverView(),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Sizing.large * 2,
                  ),
                ),
              ],
            ),
            if (isVisibleDeclinedOverlay == true)
              const CollaboratorDiscoverDeclinedOverlay(),
            CollaboratorDiscoverActionsBar(
              onDecline: () async {
                // TODO: Add decline logic
                setState(() {
                  isVisibleDeclinedOverlay = true;
                });
                await Future.delayed(
                  const Duration(seconds: 2),
                );
                setState(() {
                  isVisibleDeclinedOverlay = false;
                });
              },
              onLike: () {
                showCupertinoModalBottomSheet(
                  context: context,
                  backgroundColor: colorScheme.surface,
                  topRadius: Radius.circular(30.r),
                  builder: (mContext) {
                    return const CollaboratorSendLikeBottomSheet();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
