import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/space/follow_space_bloc/follow_space_bloc.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpaceFollowButton extends StatelessWidget {
  const SpaceFollowButton({
    super.key,
    required this.space,
  });
  final Space space;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(LemonRadius.button);
    final backgroundColor = LemonColor.atomicBlack;
    final textStyle = Typo.medium.copyWith(
      color: colorScheme.onPrimary,
      fontWeight: FontWeight.w600,
    );
    final userId = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user.userId,
        );
    return BlocBuilder<FollowSpaceBloc, FollowSpaceState>(
      builder: (context, state) {
        if (state is FollowSpaceStateLoading) {
          return SizedBox(
            height: Sizing.medium,
            child: Loading.defaultLoading(context),
          );
        }
        if (state is FollowSpaceStateFollowed) {
          return LemonOutlineButton(
            height: Sizing.medium,
            label: t.common.subscribed,
            backgroundColor: backgroundColor,
            textStyle: textStyle,
            radius: radius,
            onTap: () {
              if (userId == null || userId.isEmpty == true) {
                context.router.push(LoginRoute());
                return;
              }
              context.read<FollowSpaceBloc>().add(
                    FollowSpaceEvent.unfollow(spaceId: space.id ?? ''),
                  );
            },
          );
        } else {
          return LinearGradientButton.primaryButton(
            height: Sizing.medium,
            label: t.common.actions.subscribe,
            textStyle: textStyle,
            radius: radius,
            onTap: () {
              if (userId == null || userId.isEmpty == true) {
                context.router.push(LoginRoute());
                return;
              }
              context.read<FollowSpaceBloc>().add(
                    FollowSpaceEvent.follow(spaceId: space.id ?? ''),
                  );
            },
          );
        }
      },
    );
  }
}
