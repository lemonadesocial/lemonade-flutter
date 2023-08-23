import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/widgets/bottom_bar/app_tabs.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  AppTab _selectedTab = AppTab.home;

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
            children: tabs.map((tabData) {
              return _buildTabItem(context, tabData);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(BuildContext context, TabData tabData) {
    final isSelected = _selectedTab == tabData.tab;
    return _buildItem(context, tabData, isSelected);
  }

  Widget _buildItem(BuildContext context, TabData tabData, bool isSelected) {
    final colorScheme = Theme.of(context).colorScheme;
    Widget icon;

    if (tabData.tab == AppTab.profile) {
      icon = BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          if (authState is AuthStateAuthenticated) {
            return Center(
              child: LemonCircleAvatar(
                size: 24.w,
                url: authState.authSession.userAvatar ?? '',
              ),
            );
          } else if (authState is AuthStateProcessing) {
            return Loading.defaultLoading(context);
          } else {
            return Icon(Icons.person, color: colorScheme.onPrimary, size: 24);
          }
        },
      );
    } else {
      icon = tabData.icon;
    }
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            _selectedTab = tabData.tab;
          });
          AutoRouter.of(context)
              .navigateNamed(tabData.route, includePrefixMatches: true);
        },
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(
            horizontal: Spacing.xSmall,
            vertical: Spacing.xSmall,
          ),
          child: Container(
            width: 54.6,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: isSelected ? LemonColor.white09 : Colors.transparent,
            ),
            padding: EdgeInsets.symmetric(vertical: Spacing.superExtraSmall),
            child: icon,
          ),
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
