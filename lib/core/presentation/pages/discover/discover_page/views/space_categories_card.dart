import 'package:app/core/presentation/pages/discover/discover_page/widgets/category_card.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/application/space/list_space_categories_bloc/list_space_categories_bloc.dart';
import 'package:app/core/domain/space/space_repository.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SpaceCategoriesCard extends StatefulWidget {
  const SpaceCategoriesCard({super.key});

  @override
  State<SpaceCategoriesCard> createState() => _SpaceCategoriesCardState();
}

class _SpaceCategoriesCardState extends State<SpaceCategoriesCard> {
  late final ListSpaceCategoriesBloc _listSpaceCategoriesBloc;

  @override
  void initState() {
    super.initState();
    _listSpaceCategoriesBloc = ListSpaceCategoriesBloc(
      spaceRepository: getIt<SpaceRepository>(),
    )..add(const ListSpaceCategoriesEvent.fetch());
  }

  @override
  void dispose() {
    _listSpaceCategoriesBloc.close();
    super.dispose();
  }

  void alertComingSoon(BuildContext context) {
    SnackBarUtils.showComingSoon();
  }

  void showCollaboratorAgeValidationPopup() {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(t.collaborator.ageVerificationRequired),
        content: Text(t.collaborator.ageVerificationRequiredDescription),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              t.common.actions.cancel,
              style: Typo.medium.copyWith(color: colorScheme.onPrimary),
            ),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
              AutoRouter.of(context).navigate(const EditProfileRoute());
            },
            child: Text(
              t.common.confirm,
              style: Typo.medium.copyWith(color: colorScheme.onPrimary),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    final t = Translations.of(context);
    return BlocBuilder<ListSpaceCategoriesBloc, ListSpaceCategoriesState>(
      bloc: _listSpaceCategoriesBloc,
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const SliverToBoxAdapter(child: SizedBox()),
          loading: () => const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          ),
          success: (categories) {
            return SliverMainAxisGroup(
              slivers: [
                // Title section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: Spacing.small,
                      bottom: Spacing.xSmall,
                    ),
                    child: Text(
                      t.discover.browseByCategory,
                      style: Typo.small.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
                // Grid section
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 9.w,
                    mainAxisSpacing: 9.w,
                    childAspectRatio: 1.2,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final category = categories[index];
                      return CategoryCard(
                        title: category.title,
                        icon: SvgPicture.network(
                          category.imageUrl ?? '',
                          width: 32.w,
                          height: 32.w,
                        ),
                        colors: CategoryCardGradient.values
                            .firstWhere(
                              (gradient) =>
                                  gradient.name.toLowerCase() ==
                                  category.title
                                      .toLowerCase()
                                      .replaceAll(' ', '')
                                      .replaceAll('-', '')
                                      .replaceAll('_', '')
                                      .replaceAll('/', ''),
                              orElse: () => CategoryCardGradient.longevity,
                            )
                            .colors,
                        onTap: () {
                          router.push(
                            SpaceDetailRoute(spaceId: category.space),
                          );
                        },
                      );
                    },
                    childCount: categories.length,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
