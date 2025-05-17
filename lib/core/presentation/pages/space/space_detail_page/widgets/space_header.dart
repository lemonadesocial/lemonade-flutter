import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/presentation/pages/space/space_detail_page/widgets/space_button_by_role.dart';
import 'package:app/core/presentation/pages/space/space_detail_page/widgets/space_info.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/app_theme/app_theme.dart';

final _avatarSize = 77.w;
final transformHeight = _avatarSize / 2 + Spacing.s4 / 2;

class SpaceHeader extends StatelessWidget {
  final Space space;

  const SpaceHeader({
    super.key,
    required this.space,
  });

  @override
  Widget build(BuildContext context) {
    final hasCover = space.imageCover?.url?.isNotEmpty == true;
    final appColors = context.theme.appColors;

    return MultiSliver(
      children: [
        if (hasCover)
          SliverToBoxAdapter(
            child: SizedBox(height: transformHeight),
          ),
        SliverToBoxAdapter(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              if (hasCover)
                Transform.translate(
                  offset: Offset(0, -transformHeight),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.s4),
                    child: LemonNetworkImage(
                      width: double.infinity,
                      height: 98.w,
                      imageUrl: space.imageCover?.url ?? '',
                      fit: BoxFit.cover,
                      placeholder: ImagePlaceholder.eventCard(),
                      borderRadius: BorderRadius.circular(LemonRadius.md),
                    ),
                  ),
                )
              else
                Container(
                  height: _avatarSize,
                ),
              Positioned.fill(
                bottom: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.s4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: _avatarSize,
                        height: _avatarSize,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(LemonRadius.small),
                          border: Border.all(
                            color: appColors.cardBorder,
                            width: 1.w,
                          ),
                        ),
                        child: LemonNetworkImage(
                          imageUrl: space.imageAvatar?.url ?? '',
                          fit: BoxFit.cover,
                          width: _avatarSize,
                          height: _avatarSize,
                          borderRadius:
                              BorderRadius.circular(LemonRadius.small),
                          placeholder: ImagePlaceholder.spaceThumbnail(
                            iconColor: appColors.textTertiary,
                          ),
                        ),
                      ),
                      SpaceButtonByRole(space: space),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: Spacing.s4),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.s4),
            child: SpaceInfo(
              space: space,
            ),
          ),
        ),
      ],
    );
  }
}
