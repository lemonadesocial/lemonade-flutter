import 'package:app/core/application/space/get_my_space_event_requests_bloc/get_my_space_event_requests_bloc.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/presentation/pages/space/space_detail_page/widgets/space_button_by_role.dart';
import 'package:app/core/presentation/pages/space/space_detail_page/widgets/space_event_requests_list.dart';
import 'package:app/core/presentation/pages/space/space_detail_page/widgets/space_info.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/utils/dice_bear_utils.dart';

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
                      imageUrl: space.imageCover?.url?.isNotEmpty == true
                          ? space.imageCover?.url ?? ''
                          : DiceBearUtils.getImageUrl(id: space.id ?? ''),
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
                          borderRadius: BorderRadius.circular(LemonRadius.md),
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
                          borderRadius: BorderRadius.circular(LemonRadius.md),
                          placeholder: ImagePlaceholder.dicebearThumbnail(
                            seed: space.id ?? '',
                            size: _avatarSize,
                            radius: BorderRadius.circular(LemonRadius.md),
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
        SliverToBoxAdapter(
          child: BlocBuilder<GetMySpaceEventRequestsBloc,
              GetMySpaceEventRequestsState>(
            builder: (context, state) {
              return state.maybeWhen(
                success: (response) {
                  final filteredRecords = response.records
                      .where(
                        (element) =>
                            element.state ==
                            Enum$SpaceEventRequestState.pending,
                      )
                      .toList();

                  return filteredRecords.isEmpty
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: Spacing.s4),
                          child: Column(
                            children: [
                              SizedBox(height: Spacing.s4),
                              SpaceEventRequestsList(requests: filteredRecords),
                            ],
                          ),
                        );
                },
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
        ),
      ],
    );
  }
}
