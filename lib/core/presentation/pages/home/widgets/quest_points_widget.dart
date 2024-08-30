import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/router/app_router.gr.dart';
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
        context.read<AuthBloc>().add(
              const AuthEvent.refreshData(),
            );
        AutoRouter.of(context).navigate(const QuestRoute());
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.xSmall,
          vertical: Spacing.superExtraSmall,
        ),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: colorScheme.outline,
            ),
            borderRadius: BorderRadius.circular(LemonRadius.normal),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Assets.icons.icQuestLemonadeGradient.svg(
                width: 20.w,
                height: 20.w,
              ),
            ),
            SizedBox(width: Spacing.superExtraSmall),
            Text(
              (questPoints ?? 0).toString(),
              textAlign: TextAlign.center,
              style: Typo.medium.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
