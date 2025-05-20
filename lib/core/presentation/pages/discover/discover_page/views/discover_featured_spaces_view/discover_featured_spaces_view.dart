import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/data/space/dtos/space_dto.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/presentation/widgets/space/featured_space_item.dart';
import 'package:app/graphql/backend/space/space.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class DiscoverFeaturedSpacesView extends StatelessWidget {
  const DiscoverFeaturedSpacesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).appTextTheme;
    final t = Translations.of(context);

    return Query$ListSpaces$Widget(
      options: Options$Query$ListSpaces(
        variables: Variables$Query$ListSpaces(
          featured: true,
        ),
      ),
      builder: (
        result, {
        refetch,
        fetchMore,
      }) {
        final spaces = (result.parsedData?.listSpaces ?? [])
            .map(
              (e) => Space.fromDto(
                SpaceDto.fromJson(
                  e.toJson(),
                ),
              ),
            )
            .toList();

        return MultiSliver(
          children: [
            SliverToBoxAdapter(
              child: Text(
                t.discover.featuredCommunities,
                style: appTextTheme.lg,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: Spacing.s4),
            ),
            if (spaces.isEmpty)
              const SliverToBoxAdapter(
                child: SizedBox(),
              )
            else if (spaces.isNotEmpty)
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: Spacing.s3,
                  crossAxisSpacing: Spacing.s3,
                  childAspectRatio: 1,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final space = spaces[index];
                    return FeaturedSpaceItem(space: space);
                  },
                  childCount: spaces.length,
                ),
              ),
          ],
        );
      },
    );
  }
}
