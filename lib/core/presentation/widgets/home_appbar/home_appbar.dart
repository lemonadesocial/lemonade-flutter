import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/widgets/home_appbar/home_appbar_default_more_actions_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/avatar_utils.dart';
import 'package:app/core/utils/drawer_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/app_theme/app_theme.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  const HomeAppBar({
    super.key,
    required this.title,
    this.actions,
    this.backgroundColor,
  });

  @override
  Size get preferredSize => Size.fromHeight(60.w);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    return AppBar(
      leadingWidth: 210.w,
      backgroundColor: widget.backgroundColor ?? appColors.pageBg,
      leading: _Leading(title: widget.title),
      actions: widget.actions ??
          [
            // const HomeAppBarNotificationAction(),
            // SizedBox(width: Spacing.s5),
            Padding(
              padding: EdgeInsets.only(right: Spacing.s4),
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
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final loggedInUser = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (authSession) => authSession,
        );
    return InkWell(
      onTap: () {
        context.read<AuthBloc>().state.maybeWhen(
          orElse: () {
            AutoRouter.of(context).push(LoginRoute());
          },
          authenticated: (_) {
            context.read<AuthBloc>().add(
                  const AuthEvent.refreshData(),
                );
            DrawerUtils.openDrawer(context);
          },
        );
      },
      child: Padding(
        padding: EdgeInsets.only(left: Spacing.s4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LemonNetworkImage(
              imageUrl: AvatarUtils.getAvatarUrl(user: loggedInUser),
              placeholder: ImagePlaceholder.avatarPlaceholder(
                userId: loggedInUser?.userId,
              ),
              width: Sizing.s7,
              height: Sizing.s7,
              borderRadius: BorderRadius.circular(LemonRadius.full),
              border: Border.all(
                color: appColors.cardBorder,
                width: 1.w,
              ),
            ),
            SizedBox(width: Spacing.s3),
            Text(
              title,
              style: appText.lg,
            ),
          ],
        ),
      ),
    );
  }
}

class HomeAppBarNotificationAction extends StatelessWidget {
  const HomeAppBarNotificationAction({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AutoRouter.of(context).push(const NotificationRoute());
      },
      child: ThemeSvgIcon(
        color: context.theme.appColors.textTertiary,
        builder: (filter) => Assets.icons.icNotification.svg(
          colorFilter: filter,
          width: Sizing.s6,
          height: Sizing.s6,
        ),
      ),
    );
  }
}
