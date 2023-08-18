import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: 89.h,
      decoration: BoxDecoration(
        color: colorScheme.primary,
        border: Border(
          top: BorderSide(color: colorScheme.secondary),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildItem(
                context,
                icon: ThemeSvgIcon(
                  builder: (filter) => Assets.icons.icHouse.svg(
                    colorFilter: filter,
                    width: 24.w,
                    height: 24.w,
                  ),
                ),
                path: '/',
              ),
              _buildItem(
                context,
                icon: ThemeSvgIcon(
                  builder: (filter) => Assets.icons.icHouseParty.svg(
                    colorFilter: filter,
                    width: 24.w,
                    height: 24.w,
                  ),
                ),
                path: '/events',
              ),
              _buildItem(
                context,
                icon: ThemeSvgIcon(
                  builder: (filter) => Assets.icons.icInbox.svg(
                    colorFilter: filter,
                    width: 24.w,
                    height: 24.w,
                  ),
                ),
                path: '/notification',
              ),
              _buildItem(
                context,
                icon: ThemeSvgIcon(
                  builder: (filter) => Assets.icons.icWallet.svg(
                    colorFilter: filter,
                    width: 24.w,
                    height: 24.w,
                  ),
                ),
                path: '/wallet',
              ),
              _ProfileAuthGuardItem(
                authenticatedChild: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, authState) => _buildItem(
                    context,
                    path: '/me',
                    icon: Center(
                      child: LemonCircleAvatar(
                        size: 24.w,
                        url: authState.maybeWhen(
                          authenticated: (authSession) => authSession.userAvatar ?? '',
                          orElse: () => '',
                        ),
                      ),
                    ),
                  ),
                ),
                unauthenticatedChild: _buildItem(
                  context,
                  path: '/login',
                  icon: Icon(Icons.person, color: colorScheme.onPrimary, size: 24),
                ),
                processingChild: _buildItem(
                  context,
                  path: '',
                  icon: Loading.defaultLoading(context),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildItem(
    BuildContext context, {
    required Widget icon,
    required String path,
  }) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => AutoRouter.of(context).navigateNamed(path, includePrefixMatches: true),
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall, vertical: Spacing.xSmall),
          child: icon,
        ),
      ),
    );
  }
}

class _ProfileAuthGuardItem extends StatelessWidget {
  const _ProfileAuthGuardItem({
    required this.authenticatedChild,
    required this.unauthenticatedChild,
    required this.processingChild,
  });

  final Widget authenticatedChild;
  final Widget unauthenticatedChild;
  final Widget processingChild;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return authState.when(
          authenticated: (_) {
            return authenticatedChild;
          },
          unauthenticated: (_) => unauthenticatedChild,
          unknown: () => unauthenticatedChild,
          processing: () => processingChild,
        );
      },
    );
  }
}
