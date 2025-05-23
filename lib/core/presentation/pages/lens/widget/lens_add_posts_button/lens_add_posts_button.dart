import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/lens/enums.dart';
import 'package:app/core/application/lens/lens_auth_bloc/lens_auth_bloc.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/presentation/pages/lens/widget/lens_onboarding_bottom_sheet.dart';
import 'package:app/core/presentation/widgets/glasskit/glass_container.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class LensAddPostsButton extends StatelessWidget {
  const LensAddPostsButton({super.key, required this.space});

  final Space space;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final paddingBottom = MediaQuery.of(context).padding.bottom;
    final loggedInUser = context.read<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user,
        );

    return BlocBuilder<LensAuthBloc, LensAuthState>(
      builder: (context, state) {
        return GlassContainer(
          width: double.infinity,
          height: Sizing.s12 + paddingBottom * 1.5,
          color: appColors.pageBg.withOpacity(0.9),
          borderColor: Colors.transparent,
          blur: 5,
          borderWidth: 0,
          isFrostedGlass: false,
          padding: EdgeInsets.symmetric(horizontal: Spacing.s4),
          child: InkWell(
            onTap: () async {
              if (!state.loggedIn ||
                  !state.connected ||
                  state.accountStatus != LensAccountStatus.accountOwner) {
                final isAuthorized = await showCupertinoModalBottomSheet(
                  backgroundColor: LemonColor.atomicBlack,
                  context: context,
                  useRootNavigator: true,
                  barrierColor: Colors.black.withOpacity(0.5),
                  builder: (newContext) {
                    return const LensOnboardingBottomSheet();
                  },
                );
                if (!isAuthorized) return;
              }
              AutoRouter.of(context).push(
                CreateLensPostRoute(space: space),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(Spacing.s3),
                  decoration: BoxDecoration(
                    color: appColors.pageOverlayPrimary,
                    borderRadius: BorderRadius.circular(LemonRadius.full),
                    border: Border.all(
                      color: appColors.inputBorder,
                    ),
                  ),
                  width: double.infinity,
                  child: Row(
                    children: [
                      LemonNetworkImage(
                        imageUrl: loggedInUser?.imageAvatar ?? "",
                        placeholder: ImagePlaceholder.avatarPlaceholder(),
                        width: Sizing.s6,
                        height: Sizing.s6,
                        borderRadius: BorderRadius.circular(LemonRadius.full),
                      ),
                      SizedBox(width: Spacing.s2),
                      Text(
                        t.home.whatOnYourMind,
                        style: appText.md.copyWith(
                          color: appColors.textQuaternary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
