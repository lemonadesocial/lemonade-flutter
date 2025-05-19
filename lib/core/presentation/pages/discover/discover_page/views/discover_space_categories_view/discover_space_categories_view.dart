import 'package:app/app_theme/app_theme.dart';
import 'package:app/app_theme/colors/app_colors_extension.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/space/query/list_space_categories.graphql.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

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
  Widget getImage(String imageUrl, double size, AppColorsExtension appColors) {
    return LemonNetworkImage(
      imageUrl: imageUrl,
      width: size,
      height: size,
      placeholder: ThemeSvgIcon(
        color: appColors.textSecondary,
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
    final appColors = Theme.of(context).appColors;
    final appTextTheme = Theme.of(context).appTextTheme;

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
            if (spaceCategories.isEmpty)
              const SliverToBoxAdapter(
                child: SizedBox(),
              )
            else if (spaceCategories.isNotEmpty)
              SliverGrid.count(
                childAspectRatio: (330 / 280),
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
                          color: appColors.cardBg,
                          borderRadius: BorderRadius.circular(LemonRadius.md),
                          border: Border.all(
                            color: appColors.cardBorder,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: Spacing.s4,
                            bottom: Spacing.s2_5,
                            left: Spacing.s1,
                            right: Spacing.s1,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              getImage(
                                e.imageUrl ?? '',
                                Spacing.s8,
                                appColors,
                              ),
                              SizedBox(height: Spacing.s2_5),
                              Text(
                                e.title,
                                style: appTextTheme.sm.copyWith(
                                  color: appColors.textPrimary,
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
