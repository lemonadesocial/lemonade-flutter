import 'dart:io';

import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/widgets/bottom_bar/app_tabs.dart';
import 'package:app/core/presentation/widgets/home/bottom_bar_create_button.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/avatar_utils.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

import 'package:app/core/application/newsfeed/newsfeed_listing_bloc/newsfeed_listing_bloc.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  static double get bottomBarHeight => Platform.isIOS ? 48.w : 72.w;

  @override
  BottomBarState createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar>
    with SingleTickerProviderStateMixin {
  AppTab _selectedTab = AppTab.home;
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isTabChanged = false; // for initial render didn't change any tab yet
  var _isHomeScreenFocused = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BottomAppBar(
      padding: EdgeInsets.zero,
      elevation: 0.0,
      height: BottomBar.bottomBarHeight,
      color: colorScheme.surfaceVariant,
      child: ClipRect(
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border(
              top: BorderSide(color: LemonColor.white09),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTabItem(context, 0),
              _buildTabItem(context, 1),
              const Expanded(
                child: Center(
                  child: BottomBarCreateButton(),
                ),
              ),
              _buildTabItem(context, 2),
              _buildTabItem(context, 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem(BuildContext context, int index) {
    final tabData = tabs[index];
    final isSelected = _selectedTab == tabData.tab;
    final icon = _buildIcon(context, tabData, isSelected);
    final marginLeft = index == 0 ? Spacing.smMedium : 0.0;
    final marginRight = index == 3 ? Spacing.smMedium : 0.0;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _handleTabTap(context, tabData);
        },
        child: Container(
          height: BottomBar.bottomBarHeight,
          color: Colors.transparent,
          margin: EdgeInsets.only(right: marginRight, left: marginLeft),
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildAnimatedContainer(isSelected),
              icon,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context, TabData tabData, bool isSelected) {
    final icon = tabData.icon;
    final selectedIcon = tabData.selectedIcon;
    // Handle display user avatar for tab profile
    if (tabData.tab == AppTab.profile) {
      return BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          if (authState is AuthStateAuthenticated) {
            return Center(
              child: LemonCircleAvatar(
                size: 24.w,
                url: AvatarUtils.getProfileAvatar(
                  userAvatar: authState.authSession.imageAvatar,
                  userId: authState.authSession.userId,
                ),
              ),
            );
          } else if (authState is AuthStateProcessing) {
            return Loading.defaultLoading(context);
          } else {
            return isSelected ? selectedIcon : icon;
          }
        },
      );
    } else {
      return isSelected ? selectedIcon : icon;
    }
  }

  void _handleTabTap(BuildContext context, TabData tabData) {
    Vibrate.feedback(FeedbackType.light);

    /// Handle scroll to top on Home Screen
    if (_isHomeScreenFocused && tabData.tab == AppTab.home) {
      context
          .read<NewsfeedListingBloc>()
          .add(NewsfeedListingEvent.scrollToTop(scrollToTopEvent: true));
    }
    _isHomeScreenFocused = tabData.tab == AppTab.home;

    /// Handle navigation
    final authState = BlocProvider.of<AuthBloc>(context).state;
    if (tabData.tab == AppTab.profile ||
        tabData.tab == AppTab.notification ||
        // tabData.tab == AppTab.wallet ||
        tabData.tab == AppTab.discover) {
      if (authState is AuthStateAuthenticated) {
        _triggerAnimation(tabData);
        AutoRouter.of(context)
            .navigateNamed(tabData.route, includePrefixMatches: true);
      } else {
        context.router.navigate(const LoginRoute());
      }
    } else {
      _triggerAnimation(tabData);
      AutoRouter.of(context)
          .navigateNamed(tabData.route, includePrefixMatches: true);
    }
  }

  void _triggerAnimation(TabData tabData) {
    setState(() {
      _isTabChanged = true;
      _selectedTab = tabData.tab;
    });
    _animationController.reset();
    _animationController.forward();
  }

  Widget _buildAnimatedContainer(bool isSelected) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        if (_isTabChanged) {
          return Transform.scale(
            scale: _animation.value,
            child: Container(
              width: 54.6.w,
              height: 36.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: isSelected ? LemonColor.white09 : Colors.transparent,
              ),
            ),
          );
        }
        // This is for initial render, when first time render
        // It's must render container style around selected tab instead of animation
        return Container(
          width: 54.6.w,
          height: 36.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: isSelected ? LemonColor.white09 : Colors.transparent,
          ),
        );
      },
    );
  }
}
