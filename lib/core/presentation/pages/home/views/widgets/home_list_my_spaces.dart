import 'package:app/core/application/space/list_spaces_bloc/list_spaces_bloc.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeListMySpaces extends StatelessWidget {
  const HomeListMySpaces({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return Padding(
      padding: EdgeInsets.only(top: Spacing.medium),
      child: BlocBuilder<ListSpacesBloc, ListSpacesState>(
        builder: (context, state) {
          return state.maybeWhen(
            success: (spaces) {
              if (spaces.isEmpty) return const SizedBox.shrink();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () =>
                        context.router.push(const SpacesListingRoute()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          t.space.myCommunityHubs.toUpperCase(),
                          style: Typo.small.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        ThemeSvgIcon(
                          color: colorScheme.onSecondary,
                          builder: (filter) => Assets.icons.icArrowRight.svg(
                            width: Sizing.mSmall,
                            height: Sizing.mSmall,
                            colorFilter: filter,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Spacing.xSmall),
                  SizedBox(
                    height: 72.w,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: spaces.length,
                      separatorBuilder: (_, __) =>
                          SizedBox(width: Spacing.xSmall),
                      itemBuilder: (context, index) {
                        return _SpaceCard(space: spaces[index]);
                      },
                    ),
                  ),
                ],
              );
            },
            loading: () => Center(child: Loading.defaultLoading(context)),
            failure: (_) => const EmptyList(),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

class _SpaceCard extends StatelessWidget {
  final Space space;

  const _SpaceCard({required this.space});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final imageAvatarUrl = space.imageAvatar?.url ?? '';

    return InkWell(
      onTap: () =>
          context.router.push(SpaceDetailRoute(spaceId: space.id ?? '')),
      child: Container(
        width: 72.w,
        height: 72.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            LemonRadius.small,
          ),
          border: Border.all(
            color: colorScheme.outline,
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Avatar or Workspace Icon
            if (imageAvatarUrl.isNotEmpty)
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageAvatarUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              Container(
                color: LemonColor.white06,
                child: Center(
                  child: ThemeSvgIcon(
                    color: LemonColor.white18,
                    builder: (filter) => Assets.icons.icWorkspace.svg(
                      width: Sizing.mSmall,
                      height: Sizing.mSmall,
                      colorFilter: filter,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
