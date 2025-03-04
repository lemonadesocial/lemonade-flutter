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
  const SpaceHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverStack(
      insetOnOverlap: true,
      children: [
        SliverAppBar(
          expandedHeight: _coverHeight,
          pinned: false,
          floating: false,
          stretch: true,
          backgroundColor: Colors.transparent,
          flexibleSpace: const FlexibleSpaceBar(
            stretchModes: [
              StretchMode.zoomBackground,
            ],
            background: _CoverPhoto(),
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
              imageUrl: 'https://picsum.photos/id/238/200/300',
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(LemonRadius.small),
            ),
          ),
        ),
      ],
    );
  }
}

// Widget cho cover photo có thể giãn (không bao gồm avatar)
class _CoverPhoto extends StatelessWidget {
  const _CoverPhoto();

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Stack(
      fit: StackFit.expand,
      children: [
        const LemonNetworkImage(
          imageUrl: 'https://picsum.photos/id/237/200/300',
          fit: BoxFit.cover,
        ),
        // Back button - đặt ở vị trí an toàn dưới status bar
        Positioned(
          top: statusBarHeight,
          left: Spacing.small,
          child: Row(
            children: [
              BlurCircle(
                child: LemonBackButton(
                  onPressBack: () {
                    context.router.pop();
                  },
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
