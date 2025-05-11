import 'package:app/core/application/lens/enums.dart';
import 'package:app/core/application/lens/lens_auth_bloc/lens_auth_bloc.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/presentation/pages/lens/widget/lens_onboarding_bottom_sheet.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LensAddPostsButton extends StatelessWidget {
  const LensAddPostsButton({super.key, required this.space});

  final Space space;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LensAuthBloc, LensAuthState>(
      builder: (context, state) {
        if (space.lensFeedId == null) {
          return const SizedBox.shrink();
        }
        if (state.loggedIn &&
            state.connected &&
            state.accountStatus == LensAccountStatus.accountOwner) {
          return InkWell(
            onTap: () {
              AutoRouter.of(context).push(CreateLensPostRoute(space: space));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizing.xLarge),
                color: LemonColor.lavender,
              ),
              width: Sizing.xLarge,
              height: Sizing.xLarge,
              child: Center(
                child: Assets.icons.icAdd.svg(
                  height: Sizing.small,
                  width: Sizing.small,
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
