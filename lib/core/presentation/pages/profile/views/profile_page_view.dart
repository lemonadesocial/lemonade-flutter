import 'package:app/core/application/profile/block_user_bloc/block_user_bloc.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/dpos/common/dropdown_item_dpo.dart';
import 'package:app/core/presentation/pages/profile/views/tabs/profile_collectible_tab_view.dart';
import 'package:app/core/presentation/pages/profile/views/tabs/profile_event_tab_view.dart';
import 'package:app/core/presentation/pages/profile/views/tabs/profile_info_tab_view.dart';
import 'package:app/core/presentation/pages/profile/views/tabs/profile_photos_tab_view.dart';
import 'package:app/core/presentation/pages/profile/views/tabs/profile_posts_tab_view.dart';
import 'package:app/core/presentation/pages/profile/widgets/profile_page_header_widget.dart';
import 'package:app/core/presentation/pages/profile/widgets/profile_tabbar_delegate_widget.dart';
import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/profile_animated_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/dialog/report_user_dialog.dart';
import 'package:app/core/presentation/widgets/common/sliver/dynamic_sliver_appbar.dart';
import 'package:app/core/presentation/widgets/floating_frosted_glass_dropdown_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/dialog_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:app/app_theme/app_theme.dart';

class ProfilePageView extends StatefulWidget {
  const ProfilePageView({
    super.key,
    required this.userProfile,
  });

  final User userProfile;

  @override
  State<ProfilePageView> createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView>
    with SingleTickerProviderStateMixin {
  int get _tabCount => 5;

  late final TabController _tabCtrl = TabController(
    length: _tabCount,
    vsync: this,
    initialIndex: 0,
  );
  late final colorScheme = Theme.of(context).colorScheme;
  late final t = Translations.of(context);

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMe = AuthUtils.isMe(context, user: widget.userProfile);
    final appColors = context.theme.appColors;
    return BlocListener<BlockUserBloc, BlockUserState>(
      listener: (context, state) {
        if (state.status == BlockUserStatus.blockSuccess) {
          context.router.pop();
          SnackBarUtils.showSuccess(message: t.profile.blockSuccess);
          AuthUtils.getUser(context)!.blockedList!.add(widget.userProfile);
        }

        if (state.status == BlockUserStatus.error) {
          SnackBarUtils.showError();
        }
      },
      child: Scaffold(
        backgroundColor: colorScheme.primary,
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                  context,
                ),
                sliver: MultiSliver(
                  children: [
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: ProfileAnimatedAppBar(
                        title:
                            '@${widget.userProfile.username ?? t.common.anonymous}',
                        leading: const LemonBackButton(),
                        actions: [
                          if (!isMe)
                            Padding(
                              padding: EdgeInsets.only(right: Spacing.xSmall),
                              child: FloatingFrostedGlassDropdown(
                                items: <DropdownItemDpo<MenuOption>>[
                                  DropdownItemDpo<MenuOption>(
                                    label: t.common.actions.block,
                                    value: MenuOption.block,
                                    leadingIcon: Assets.icons.icBlock.svg(
                                      width: 15.w,
                                      height: 15.w,
                                    ),
                                  ),
                                  DropdownItemDpo<MenuOption>(
                                    label: t.profile.reportProfile,
                                    value: MenuOption.report,
                                    customColor: LemonColor.menuRed,
                                    leadingIcon: Assets.icons.icReport.svg(
                                      width: 15.w,
                                      height: 15.w,
                                    ),
                                  ),
                                ],
                                onItemPressed: (item) {
                                  switch (item?.value) {
                                    case MenuOption.block:
                                      DialogUtils.showConfirmDialog(
                                        context,
                                        message: t.profile.blockConfirm,
                                        onConfirm: () {
                                          context.router.pop();
                                          context
                                              .read<BlockUserBloc>()
                                              .blockUser(
                                                userId:
                                                    widget.userProfile.userId,
                                                isBlock: true,
                                              );
                                        },
                                      );
                                      break;
                                    case MenuOption.report:
                                      ReportUserDialog(
                                        user: widget.userProfile,
                                      ).showAsBottomSheet(
                                        context,
                                        heightFactor: 0.79,
                                      );
                                      break;
                                    default:
                                      break;
                                  }
                                },
                                child: ThemeSvgIcon(
                                  color: appColors.textTertiary,
                                  builder: (filter) => Assets.icons.icMoreHoriz
                                      .svg(colorFilter: filter),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    DynamicSliverAppBar(
                      maxHeight: 250.h,
                      floating: true,
                      forceElevated: innerBoxIsScrolled,
                      child: ProfilePageHeader(user: widget.userProfile),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: ProfileTabBarDelegate(controller: _tabCtrl),
                    ),
                  ],
                ),
              ),
            ],
            body: TabBarView(
              controller: _tabCtrl,
              children: [
                ProfilePostsTabView(user: widget.userProfile),
                ProfileCollectibleTabView(user: widget.userProfile),
                ProfileEventTabView(user: widget.userProfile),
                ProfilePhotosTabView(user: widget.userProfile),
                ProfileInfoTabView(user: widget.userProfile),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum MenuOption {
  block,
  share,
  report,
}
