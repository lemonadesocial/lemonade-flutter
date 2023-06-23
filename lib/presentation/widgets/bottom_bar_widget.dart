import 'dart:ui';

import 'package:app/gen/assets.gen.dart';
import 'package:app/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

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
                    _buildItem(context,
                        icon: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: themeColor.onPrimary,
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        path: '/profile')
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
