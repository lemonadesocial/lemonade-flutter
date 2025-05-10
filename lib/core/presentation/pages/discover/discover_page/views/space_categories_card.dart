import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/discover/discover_page/widgets/category_card.dart';
import 'package:app/core/utils/device_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
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

  void onAuthenticatedTap({
    required bool isLoggedIn,
    required void Function() tapFunc,
  }) {
    if (isLoggedIn) {
      tapFunc();
    } else {
      AutoRouter.of(context).push(const LoginRoute());
    }
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
    User? user = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user,
        );
    final isLoggedIn = user != null;

    return BlocBuilder<ListSpaceCategoriesBloc, ListSpaceCategoriesState>(
      bloc: _listSpaceCategoriesBloc,
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          ),
          success: (categories) {
            return SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 9.w,
                mainAxisSpacing: 9.w,
                childAspectRatio: 1.2,
              ),
              delegate: SliverChildListDelegate([
                ...categories.asMap().entries.map((entry) {
                  final category = entry.value;
                  return CategoryCard(
                    title: category.title,
                    subTitle: category.description ?? '',
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
                                  .replaceAll(' ', '') // Remove spaces
                                  .replaceAll('-', '') // Remove hyphens
                                  .replaceAll('_', '') // Remove underscores
                                  .replaceAll(
                                      '/', ''), // Remove forward slashes
                          orElse: () => CategoryCardGradient.longevity,
                        )
                        .colors,
                    onTap: () {
                      onAuthenticatedTap(
                        isLoggedIn: isLoggedIn,
                        tapFunc: () {
                          router.push(
                            SpaceDetailRoute(spaceId: category.space),
                          );
                        },
                      );
                    },
                  );
                }),
              ]),
            );
          },
          orElse: () => const SliverToBoxAdapter(child: SizedBox()),
        );
      },
    );
  }
}
