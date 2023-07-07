import 'dart:ui';

import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
            height: 80,
            decoration:
                BoxDecoration(color: LemonColor.black50, border: Border(top: BorderSide(color: themeColor.secondary))),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildItem(context,
                        icon: ThemeSvgIcon(builder: (filter) => Assets.icons.icHouse.svg(colorFilter: filter)),
                        path: '/'),
                    _buildItem(context,
                        icon: ThemeSvgIcon(
                          builder: (filter) => Assets.icons.icHouseParty.svg(colorFilter: filter),
                        ),
                        path: '/events'),
                    _buildItem(context,
                        icon: ThemeSvgIcon(
                          builder: (filter) => Assets.icons.icInbox.svg(colorFilter: filter),
                        ),
                        path: '/notification'),
                    _buildItem(context,
                        icon: ThemeSvgIcon(
                          builder: (filter) => Assets.icons.icWallet.svg(colorFilter: filter),
                        ),
                        path: '/wallet'),
                    _ProfileAuthGuardItem(
                      authenticatedChild: _buildItem(context,
                          icon: BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, authState) => LemonCircleAvatar(
                              size: 24,
                              url: authState.maybeWhen(
                                  authenticated: (authSession) => authSession.userAvatar ?? '', orElse: () => ''),
                            ),
                          ),
                          path: '/me'),
                      unauthenticatedChild: Container(
                        padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall, vertical: Spacing.xSmall),
                        child: Icon(Icons.person, color: themeColor.onPrimary, size: 24),
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }

  Widget _buildItem(BuildContext context, {required Widget icon, required String path}) {
    return GestureDetector(
      onTap: () => AutoRouter.of(context).navigateNamed(path, includePrefixMatches: true),
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall, vertical: Spacing.xSmall),
        child: icon,
      ),
    );
  }
}

class _ProfileAuthGuardItem extends StatelessWidget {
  final Widget authenticatedChild;
  final Widget unauthenticatedChild;
  const _ProfileAuthGuardItem({
    required this.authenticatedChild,
    required this.unauthenticatedChild,
  });

  _buildNotLoggedIn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AutoRouter.of(context).navigateNamed('/login', includePrefixMatches: true);
      },
      child: unauthenticatedChild,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return authState.when(
          authenticated: (_) {
            return authenticatedChild;
          },
          unauthenticated: (_) => _buildNotLoggedIn(context),
          unknown: () => _buildNotLoggedIn(context),
        );
      },
    );
  }
}
