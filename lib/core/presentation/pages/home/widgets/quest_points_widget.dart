import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestPointsWidget extends StatelessWidget {
  const QuestPointsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final loggedInUser = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user,
        );
    final questPoints = loggedInUser?.questPoints;
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        AutoRouter.of(context).navigate(const QuestRoute());
      },
      child: Stack(
        children: [
          ThemeSvgIcon(
            builder: (filter) => Assets.icons.icTargetLine.svg(
              colorFilter: filter,
              width: Sizing.small,
              height: Sizing.small,
            ),
          ),
          Positioned(
            bottom: 0.w,
            right: 0.w,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 2.w,
                vertical: 1.w,
              ),
              decoration: ShapeDecoration(
                color: colorScheme.secondaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    LemonRadius.extraSmall / 2,
                  ),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    (questPoints ?? 0).toString(),
                    textAlign: TextAlign.center,
                    style: Typo.xSmall.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w900,
                      height: 0,
                      fontFamily: FontFamily.spaceGrotesk,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
