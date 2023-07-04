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
                    _AuthGuardItem(
                      authenticatedChild: _buildItem(context,
                          icon: LemonCircleAvatar(
                            size: 24,
                            url:
                                'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8YXZhdGFyfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
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

class _AuthGuardItem extends StatelessWidget {
  final Widget authenticatedChild;
  final Widget unauthenticatedChild;
  const _AuthGuardItem({
    required this.authenticatedChild,
    required this.unauthenticatedChild,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return authState.maybeWhen(
            authenticated: (_) {
              return authenticatedChild;
            },
            unauthenticated: (_) {
              return GestureDetector(
                onTap: () {
                  AutoRouter.of(context).navigateNamed('/login', includePrefixMatches: true);
                },
                child: unauthenticatedChild,
              );
            },
            orElse: () => SizedBox.shrink());
      },
    );
  }
}
