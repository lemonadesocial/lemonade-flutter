import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/space/query/list_space_categories.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:app/core/presentation/widgets/shimmer/shimmer.dart';

enum CategoryCardGradient {
  longevity(
    colors: [
      Color.fromRGBO(43, 58, 58, 0.8), // Bluish background
      Color.fromRGBO(25, 34, 34, 0.8),
      Color.fromRGBO(18, 18, 18, 0.8),
    ],
  ),
  dacc(
    colors: [
      Color(0xFF36241E),
      // Color.fromRGBO(64, 52, 40, 0.8), // Orange-ish background
      Color.fromRGBO(45, 35, 28, 0.8),
      Color.fromRGBO(18, 18, 18, 0.8),
    ],
  ),
  ai(
    colors: [
      Color.fromRGBO(62, 42, 56, 0.8), // Pink-ish background
      Color.fromRGBO(47, 32, 42, 0.8),
      Color.fromRGBO(18, 18, 18, 0.8),
    ],
  ),
  ethereum(
    colors: [
      Color.fromRGBO(61, 48, 71, 0.8), // Purple background
      Color.fromRGBO(45, 34, 51, 0.8),
      Color.fromRGBO(18, 18, 18, 0.8),
    ],
  ),
  meetup(
    colors: [
      Color.fromRGBO(37, 56, 43, 0.8), // Green background
      Color.fromRGBO(30, 42, 27, 0.8),
      Color.fromRGBO(18, 18, 18, 0.8),
    ],
  ),
  popupVillage(
    colors: [
      Color(0xFF2C2E21),
      Color(0xFF26281F),
      Color.fromRGBO(18, 18, 18, 0.8),
    ],
  );

  const CategoryCardGradient({required this.colors});
  final List<Color> colors;
}

class DiscoverSpaceCategoriesView extends StatefulWidget {
  const DiscoverSpaceCategoriesView({
    super.key,
  });

  @override
  State<DiscoverSpaceCategoriesView> createState() =>
      _DiscoverSpaceCategoriesViewState();
}

class _DiscoverSpaceCategoriesViewState
    extends State<DiscoverSpaceCategoriesView> {
  Widget getImage(String imageUrl, double size) {
    final colorScheme = Theme.of(context).colorScheme;
    return LemonNetworkImage(
      imageUrl: imageUrl,
      width: size,
      height: size,
      placeholder: ThemeSvgIcon(
        color: colorScheme.onSecondary,
        builder: (colorFilter) => Assets.icons.icLemonadeLogo.svg(
          colorFilter: colorFilter,
          width: size,
          height: size,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return Query$ListSpaceCategories$Widget(
      options: Options$Query$ListSpaceCategories(),
      builder: (
        result, {
        refetch,
        fetchMore,
      }) {
        final spaceCategories = result.parsedData?.listSpaceCategories ?? [];

        return MultiSliver(
          children: [
            SliverToBoxAdapter(
              child: Text(
                t.discover.browseByCategory.toUpperCase(),
                style: Typo.small.copyWith(
                  color: colorScheme.onPrimary,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: Spacing.xSmall),
            ),
            if (spaceCategories.isEmpty)
              SliverGrid.count(
                childAspectRatio: (330 / 320),
                crossAxisCount: 3,
                mainAxisSpacing: Spacing.extraSmall,
                crossAxisSpacing: Spacing.extraSmall,
                children: List.generate(
                  6,
                  (index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: LemonColor.atomicBlack,
                        borderRadius: BorderRadius.circular(Spacing.small),
                        border: Border.all(
                          color: colorScheme.outline,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(Spacing.xSmall),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ThemeSvgIcon(
                              color: colorScheme.onSecondary,
                              builder: (colorFilter) =>
                                  Assets.icons.icLemonadeLogo.svg(
                                colorFilter: colorFilter,
                                width: 32.w,
                                height: 32.h,
                              ),
                            ),
                            SizedBox(height: Spacing.xSmall),
                            SizedBox(
                              height: Spacing.small,
                              child: Shimmer.fromColors(
                                baseColor: colorScheme.surfaceVariant,
                                highlightColor: colorScheme.surface,
                                child: Container(
                                  color: colorScheme.background,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            if (spaceCategories.isNotEmpty)
              SliverGrid.count(
                childAspectRatio: (330 / 320),
                crossAxisCount: 3,
                mainAxisSpacing: Spacing.extraSmall,
                crossAxisSpacing: Spacing.extraSmall,
                children: spaceCategories.map(
                  (e) {
                    return InkWell(
                      onTap: () {
                        if (e.space.isNotEmpty == true) {
                          AutoRouter.of(context).push(
                            SpaceDetailRoute(
                              spaceId: e.space,
                            ),
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          // color: LemonColor.atomicBlack,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: CategoryCardGradient.values
                                .firstWhere(
                                  (gradient) =>
                                      gradient.name.toLowerCase() ==
                                      e.title
                                          .toLowerCase()
                                          .replaceAll(' ', '')
                                          .replaceAll('-', '')
                                          .replaceAll('_', '')
                                          .replaceAll('/', ''),
                                  orElse: () => CategoryCardGradient.longevity,
                                )
                                .colors,
                          ),
                          borderRadius: BorderRadius.circular(Spacing.small),
                          border: Border.all(
                            color: colorScheme.outline,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(Spacing.xSmall),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              getImage(e.imageUrl ?? '', 32.w),
                              SizedBox(height: Spacing.xSmall),
                              Text(
                                e.title,
                                style: Typo.medium.copyWith(
                                  color: colorScheme.onPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
          ],
        );
      },
    );
  }
}
