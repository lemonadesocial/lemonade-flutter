import 'package:app/core/application/lens/create_lens_post_bloc/create_lens_post_bloc.dart';
import 'package:app/core/application/lens/lens_auth_bloc/lens_auth_bloc.dart';
import 'package:app/core/presentation/pages/lens/widget/lens_onboarding_bottom_sheet.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class LensAddPostsButton extends StatelessWidget {
  const LensAddPostsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LensAuthBloc, LensAuthState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            if (!state.loggedIn || !state.connected) {
              showCupertinoModalBottomSheet(
                backgroundColor: LemonColor.atomicBlack,
                context: context,
                useRootNavigator: true,
                barrierColor: Colors.black.withOpacity(0.5),
                builder: (newContext) {
                  return const LensOnboardingBottomSheet();
                },
              );
            } else {
              context.read<CreateLensPostBloc>().add(
                    const CreateLensPostEvent.createPost(),
                  );
            }
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
      },
    );
  }
}
