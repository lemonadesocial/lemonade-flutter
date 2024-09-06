import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/widgets/home/home_quick_create_bottom_sheet.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class BottomBarCreateButton extends StatelessWidget {
  const BottomBarCreateButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    return InkWell(
      onTap: () {
        authState.maybeWhen(
          authenticated: (session) {
            showCupertinoModalBottomSheet(
              context: context,
              useRootNavigator: true,
              topRadius: Radius.circular(LemonRadius.button),
              barrierColor: Colors.black.withOpacity(0.5),
              backgroundColor: LemonColor.atomicBlack,
              builder: (mContext) {
                return const HomeQuickCreateBottomSheet();
              },
            );
          },
          orElse: () => context.router.navigate(const LoginRoute()),
        );
      },
      child: Container(
        width: 48.h,
        height: 48.h,
        padding: EdgeInsets.all(12.w),
        decoration: ShapeDecoration(
          color: const Color(0x2DC69DF7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(27),
          ),
        ),
        child: Assets.icons.icCreate.svg(),
      ),
    );
  }
}
