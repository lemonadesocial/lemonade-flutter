import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/post/toggle_post_reaction_bloc/toggle_post_reaction_bloc.dart';
import 'package:app/core/domain/post/entities/post_entities.dart';
import 'package:app/core/domain/post/input/post_reaction_input.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostCardActions extends StatelessWidget {
  final Post post;
  const PostCardActions({
    super.key,
    required this.post,
  });

  int? get comments => post.comments;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isLoggedIn = context
        .watch<AuthBloc>()
        .state
        .maybeWhen(authenticated: (_) => true, orElse: () => false);
    return Padding(
      padding: EdgeInsets.only(top: Spacing.xSmall),
      child: Row(
        children: [
          BlocBuilder<TogglePostReactionBloc, TogglePostReactionState>(
            builder: (context, state) {
              final svgIcon = state.hasReaction
                  ? Assets.icons.icHeartFillled
                  : Assets.icons.icHeart;
              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  if (!isLoggedIn) {
                    AutoRouter.of(context).navigate(const LoginRoute());
                    return;
                  }
                  context.read<TogglePostReactionBloc>().add(
                        TogglePostReactionEvent.toggle(
                          input: PostReactionInput(
                            active: !state.hasReaction,
                            post: post.id,
                          ),
                        ),
                      );
                },
                child: Row(
                  children: [
                    ThemeSvgIcon(
                      builder: (filter) => svgIcon.svg(
                        width: 18.w,
                        height: 18.w,
                      ),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '${state.reactions}',
                      style: Typo.small.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(width: Spacing.xSmall),
          // onPressed have applied on parent widget,
          // so there no nee to implement here
          Row(
            children: [
              ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => Assets.icons.icMessage.svg(
                  colorFilter: filter,
                  width: 18.w,
                  height: 18.w,
                ),
              ),
              const SizedBox(width: 3),
              Text(
                comments != null ? '$comments' : '',
                style: Typo.small.copyWith(color: colorScheme.onSecondary),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              SnackBarUtils.showComingSoon(context: context);
            },
            child: ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icShare.svg(
                colorFilter: filter,
                width: 18.w,
                height: 18.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
