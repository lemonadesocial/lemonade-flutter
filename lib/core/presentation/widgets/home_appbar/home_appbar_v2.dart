import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/widgets/home_appbar/home_appbar_default_more_actions_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/utils/drawer_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  const HomeAppBar({
    super.key,
    required this.title,
    this.actions,
  });

  @override
  Size get preferredSize => Size.fromHeight(60.w);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AppBar(
      leadingWidth: 210.w,
      backgroundColor: colorScheme.background,
      leading: _Leading(title: widget.title),
      actions: widget.actions ??
          [
            Padding(
              padding: EdgeInsets.only(right: Spacing.xSmall),
              child: const HomeAppBarDefaultMoreActionsWidget(),
            ),
          ],
      title: const SizedBox.shrink(),
      elevation: 0,
      toolbarHeight: widget.preferredSize.height,
      // bottom: bottom,
    );
  }
}

class _Leading extends StatelessWidget {
  final String title;
  const _Leading({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final loggedInUser = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (authSession) => authSession,
        );
    return InkWell(
      onTap: () {
        context.read<AuthBloc>().state.maybeWhen(
          orElse: () {
            AutoRouter.of(context).push(const LoginRoute());
          },
          authenticated: (_) {
            DrawerUtils.openDrawer(context);
          },
        );
      },
      child: Padding(
        padding: EdgeInsets.only(left: Spacing.xSmall),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LemonNetworkImage(
              imageUrl: ImageUtils.generateUrl(
                file: loggedInUser?.newPhotosExpanded?.firstOrNull,
              ),
              placeholder: Assets.icons.icPerson.svg(
                width: 30.w,
                height: 30.w,
              ),
              width: 30.w,
              height: 30.w,
              borderRadius: BorderRadius.circular(30.w),
            ),
            SizedBox(width: Spacing.xSmall),
            Text(
              title,
              style: Typo.extraMedium.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
