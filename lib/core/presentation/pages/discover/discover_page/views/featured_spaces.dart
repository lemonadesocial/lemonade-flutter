import 'package:app/core/application/space/list_spaces_bloc/list_spaces_bloc.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/presentation/pages/discover/discover_page/widgets/discover_space_list_item.dart';

class FeaturedSpaces extends StatelessWidget {
  const FeaturedSpaces({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<ListSpacesBloc, ListSpacesState>(
      builder: (context, state) {
        return SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.small),
              child: Text(
                t.discover.featuredCommunities,
                style: Typo.small.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
            SizedBox(height: Spacing.small),
            state.maybeWhen(
              orElse: () => const SizedBox.shrink(),
              loading: () => const Center(child: CircularProgressIndicator()),
              success: (spaces) => Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.small),
                child: Column(
                  children: [
                    for (var i = 0; i < spaces.length; i++) ...[
                      if (i > 0) SizedBox(height: Spacing.xSmall),
                      DiscoverSpaceListItem(
                        space: spaces[i],
                        onTap: () => context.router.navigate(
                          SpaceDetailRoute(spaceId: spaces[i].id!),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ]),
        );
      },
    );
  }
}
