import 'dart:io';

import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/widgets/bottom_bar/app_tabs.dart';
import 'package:app/core/presentation/widgets/glasskit/glass_container.dart';
import 'package:app/core/presentation/widgets/home/bottom_bar_create_button.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:app/core/application/newsfeed/newsfeed_listing_bloc/newsfeed_listing_bloc.dart';
import 'package:collection/collection.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  static double get bottomBarHeight => Platform.isIOS ? 48.w : 60.w;

  @override
  BottomBarState createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar>
    with SingleTickerProviderStateMixin {
  AppTab _selectedTab = AppTab.home;
  late AnimationController _animationController;
  // late Animation<double> _animation;
  // bool _isTabChanged = false; // for initial render didn't change any tab yet
  var _isHomeScreenFocused = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    // _animation = Tween<double>(begin: 0, end: 1).animate(
    //   CurvedAnimation(
    //     parent: _animationController,
    //     curve: Curves.easeInOut,
    //   ),
    // );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final paddingBottom = MediaQuery.of(context).padding.bottom;
    final appColors = Theme.of(context).appColors;
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: appColors.pageDivider),
          ),
        ),
        child: GlassContainer(
          width: double.infinity,
          height: BottomBar.bottomBarHeight + paddingBottom,
          color: appColors.pageOverlayBg,
          borderColor: Colors.transparent,
          padding: EdgeInsets.symmetric(
            horizontal: Spacing.s4,
            vertical: Spacing.s3,
          ),
          blur: 20,
          // decoration: BoxDecoration(
          //   // color: appColors.pageOverlayBg,
          //   shape: BoxShape.rectangle,
          //   border: Border(
          //     top: BorderSide(color: appColors.pageDivider),
          //   ),
          // ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTabItem(context, 0),
              _buildTabItem(context, 1),
              const Expanded(
                child: BottomBarCreateButton(),
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
    return Expanded(
      child: InkWell(
        onTap: () {
          _handleTabTap(context, tabData);
        },
        child: icon,
      ),
    );
  }

  Widget _buildIcon(BuildContext context, TabData tabData, bool isSelected) {
    final icon = tabData.icon;
    final selectedIcon = tabData.selectedIcon;
    final appColors = context.theme.appColors;
    return ThemeSvgIcon(
      color: isSelected ? appColors.textPrimary : appColors.textTertiary,
      builder: (filter) => isSelected
          ? selectedIcon.svg(
              colorFilter: filter,
              width: 24.w,
              height: 24.w,
            )
          : icon.svg(
              colorFilter: filter,
              width: 24.w,
              height: 24.w,
            ),
    );
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
    if (tabData.tab == AppTab.notification || tabData.tab == AppTab.spaces) {
      if (authState is AuthStateAuthenticated) {
        _triggerAnimation(tabData);
        AutoRouter.of(context)
            .navigateNamed(tabData.route, includePrefixMatches: true);
      } else {
        // If other route is not logged in, navigate to Home Screen
        _triggerAnimation(tabs[0]);
        context.router.navigate(const HomeRoute());
      }
    } else {
      _triggerAnimation(tabData);
      AutoRouter.of(context)
          .navigateNamed(tabData.route, includePrefixMatches: true);
    }
  }

  void _triggerAnimation(TabData tabData) {
    setState(() {
      // _isTabChanged = true;
      _selectedTab = tabData.tab;
    });
    _animationController.reset();
    _animationController.forward();
  }

  void tabNavigated(TabPageRoute tabRoute) {
    final tabData = tabs.firstWhereOrNull(
      (tab) => tab.route.contains(tabRoute.path),
    );

    if (tabData?.tab == AppTab.home) {
      _isHomeScreenFocused = true;
    }

    if (tabData != null) {
      // Wrap with addPostFrameCallback to avoid setState during build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          // Check if the state is still mounted before calling setState
          _triggerAnimation(tabData);
        }
      });
    }
  }

  // Widget _buildAnimatedContainer(bool isSelected) {
  //   return AnimatedBuilder(
  //     animation: _animation,
  //     builder: (context, child) {
  //       if (_isTabChanged) {
  //         return Transform.scale(
  //           scale: _animation.value,
  //           child: Container(
  //             width: 54.6.w,
  //             height: 36.h,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(18),
  //               color: isSelected ? LemonColor.white09 : Colors.transparent,
  //             ),
  //           ),
  //         );
  //       }
  //       // This is for initial render, when first time render
  //       // It's must render container style around selected tab instead of animation
  //       return Container(
  //         width: 54.6.w,
  //         height: 36.h,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(18),
  //           color: isSelected ? LemonColor.white09 : Colors.transparent,
  //         ),
  //       );
  //     },
  //   );
  // }
}
