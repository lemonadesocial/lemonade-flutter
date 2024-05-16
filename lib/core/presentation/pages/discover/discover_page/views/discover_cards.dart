import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/discover/discover_card.dart';
import 'package:app/core/utils/device_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscoverCards extends StatefulWidget {
  const DiscoverCards({super.key});

  @override
  State<DiscoverCards> createState() => _DiscoverCardsState();
}

class _DiscoverCardsState extends State<DiscoverCards> {
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
    return SliverGrid.count(
      crossAxisCount: 3,
      crossAxisSpacing: 9.w,
      childAspectRatio: (DeviceUtils.isIpad() ? 2 : 0.9),
      children: [
        DiscoverCard(
          title: t.discover.cardSections.events.title,
          subTitle: t.discover.cardSections.events.subTitle,
          icon: Assets.icons.icDiscoverEvents.svg(),
          colors: DiscoverCardGradient.events.colors,
          onTap: () {
            onAuthenticatedTap(
              isLoggedIn: isLoggedIn,
              tapFunc: () {
                router.navigateNamed('/events');
              },
            );
          },
        ),
        DiscoverCard(
          title: t.discover.cardSections.collaborators.title,
          subTitle: t.discover.cardSections.collaborators.subTitle,
          icon: Assets.icons.icDiscoverPeople.svg(),
          colors: DiscoverCardGradient.collaborators.colors,
          onTap: () {
            onAuthenticatedTap(
              isLoggedIn: isLoggedIn,
              tapFunc: () {
                // Check valid age
                if (user != null) {
                  if ((user.age ?? 0) < 18) {
                    return showCollaboratorAgeValidationPopup();
                  }
                }
                AutoRouter.of(context).navigate(CollaboratorRoute());
              },
            );
          },
        ),
        DiscoverCard(
          title: t.discover.cardSections.badges.title,
          subTitle: t.discover.cardSections.badges.subTitle,
          icon: Assets.icons.icDiscoverBadges.svg(),
          colors: DiscoverCardGradient.badges.colors,
          onTap: () {
            onAuthenticatedTap(
              isLoggedIn: isLoggedIn,
              tapFunc: () {
                router.navigateNamed('/poap');
              },
            );
          },
        ),
      ],
    );
  }
}
