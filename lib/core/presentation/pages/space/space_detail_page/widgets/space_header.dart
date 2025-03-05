import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_appbar.dart';
import 'package:app/core/presentation/widgets/lemon_back_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:app/theme/spacing.dart';

final _coverHeight = 170.w;
final _avatarSize = 80.w;

class SpaceHeader extends StatelessWidget {
  final Space space;

  const SpaceHeader({
    super.key,
    required this.space,
  });

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return SliverStack(
      insetOnOverlap: true,
      children: [
        SliverAppBar(
          expandedHeight: _coverHeight,
          pinned: false,
          floating: false,
          stretch: true,
          backgroundColor: Colors.transparent,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.zoomBackground,
            ],
            background: LemonNetworkImage(
              imageUrl: space.imageCover?.url ?? '',
              fit: BoxFit.cover,
            ),
          ),
          automaticallyImplyLeading: false,
          toolbarHeight: 0,
        ),
        SliverPositioned(
          bottom: -_avatarSize / 2,
          left: Spacing.small,
          child: Container(
            width: _avatarSize,
            height: _avatarSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LemonRadius.small),
              border: Border.all(
                color: Theme.of(context).colorScheme.background,
                width: 3.w,
              ),
            ),
            child: LemonNetworkImage(
              imageUrl: space.imageAvatar?.url ?? '',
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(LemonRadius.small),
            ),
          ),
        ),
        SliverPositioned(
          top: statusBarHeight,
          left: Spacing.small,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  context.router.pop();
                },
                child: BlurCircle(
                  child: LemonBackButton(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
