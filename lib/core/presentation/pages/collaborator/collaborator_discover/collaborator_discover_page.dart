import 'package:app/core/application/collaborator/discover_users_bloc/discover_user_bloc.dart';
import 'package:app/core/presentation/dpos/common/dropdown_item_dpo.dart';
import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_actions_bar.dart';
import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_declined_overlay.dart';
import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_view.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/widgets/collaborator_send_like_bottomsheet/collaborator_send_like_bottomsheet.dart';
import 'package:app/core/presentation/widgets/animation/circular_animation_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/floating_frosted_glass_dropdown_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

@RoutePage()
class CollaboratorDiscoverPage extends StatefulWidget {
  const CollaboratorDiscoverPage({super.key});

  @override
  State<CollaboratorDiscoverPage> createState() =>
      _CollaboratorDiscoverPageState();
}

class _CollaboratorDiscoverPageState extends State<CollaboratorDiscoverPage> {
  bool? isVisibleDeclinedOverlay = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<DiscoverUserBloc, DiscoverUserState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: colorScheme.primary,
          appBar: LemonAppBar(
            actions: [
              Padding(
                padding: EdgeInsets.only(right: Spacing.medium),
                child: InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.filter_alt_outlined,
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: Spacing.medium),
                child: InkWell(
                  onTap: () {
                    AutoRouter.of(context).push(const CollaboratorLikesRoute());
                  },
                  child: Icon(
                    Icons.favorite_border,
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: Spacing.smMedium),
                child: InkWell(
                  onTap: () {
                    AutoRouter.of(context).push(const CollaboratorChatRoute());
                  },
                  child: ThemeSvgIcon(
                    color: colorScheme.onPrimary,
                    builder: (filter) => Assets.icons.icChatBubble.svg(
                      colorFilter: filter,
                    ),
                  ),
                ),
              ),
              const _MoreAction(),
            ],
          ),
          body: Builder(
            builder: (context) {
              if (state.fetching) {
                return CircularAnimationWidget(
                  icon: ThemeSvgIcon(
                    color: colorScheme.onSecondary,
                    builder: (filter) => Assets.icons.icLocationPin.svg(
                      width: Sizing.xLarge,
                      height: Sizing.xLarge,
                      colorFilter: filter,
                    ),
                  ),
                );
              }

              if (state.users.isEmpty) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.medium),
                  child: Center(
                    child: Column(
                      children: [
                        EmptyList(
                          emptyText: t.collaborator.discover.emptyDescription,
                        ),
                        SizedBox(height: Spacing.medium),
                        LinearGradientButton.secondaryButton(
                          label: t.collaborator.discover.adjustFilter,
                        ),
                      ],
                    ),
                  ),
                );
              }

              final currentUser = state.users.firstOrNull;

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                child: Stack(
                  children: [
                    CustomScrollView(
                      slivers: [
                        CollaboratorDiscoverView(
                          key: ValueKey(currentUser?.userId ?? ''),
                          user: currentUser,
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: Sizing.large * 2,
                          ),
                        ),
                      ],
                    ),
                    CollaboratorDiscoverActionsBar(
                      onDecline: () async {
                        setState(() {
                          isVisibleDeclinedOverlay = true;
                        });
                        context.read<DiscoverUserBloc>().add(
                              DiscoverUserEvent.onUserSwiped(
                                userId: currentUser?.userId ?? '',
                              ),
                            );
                        await Future.delayed(
                          const Duration(milliseconds: 500),
                        );
                        setState(() {
                          isVisibleDeclinedOverlay = false;
                        });
                      },
                      onLike: () {
                        showCupertinoModalBottomSheet(
                          context: context,
                          backgroundColor: colorScheme.surface,
                          topRadius: Radius.circular(30.r),
                          builder: (mContext) {
                            return const CollaboratorSendLikeBottomSheet();
                          },
                        );
                      },
                    ),
                    if (isVisibleDeclinedOverlay == true)
                      const CollaboratorDiscoverDeclinedOverlay(),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _MoreAction extends StatelessWidget {
  const _MoreAction();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return FloatingFrostedGlassDropdown(
      items: [
        // TODO: will handle these action later
        // DropdownItemDpo(
        //   value: "share",
        //   label: t.common.actions.shareUser,
        //   leadingIcon: Assets.icons.icShare.svg(
        //     width: Sizing.xSmall,
        //     height: Sizing.xSmall,
        //   ),
        //   customColor: colorScheme.onPrimary,
        // ),
        // DropdownItemDpo(
        //   value: "report",
        //   label: t.common.actions.shareUser,
        //   leadingIcon: Assets.icons.icReport.svg(
        //     width: Sizing.xSmall,
        //     height: Sizing.xSmall,
        //   ),
        //   customColor: LemonColor.coralReef,
        // ),
        DropdownItemDpo(
          value: "edit",
          label: t.common.actions.editMyProfile,
          leadingIcon: ThemeSvgIcon(
            builder: (filter) => Assets.icons.icEdit.svg(
              colorFilter: filter,
              width: Sizing.xSmall,
              height: Sizing.xSmall,
            ),
          ),
          customColor: colorScheme.onPrimary,
        ),
      ],
      onItemPressed: (item) {
        if (item?.value == 'edit') {
          AutoRouter.of(context).push(
            const CollaboratorEditProfileRoute(),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.only(right: Spacing.xSmall),
        child: Icon(
          Icons.more_vert,
          color: colorScheme.onPrimary,
        ),
      ),
    );
  }
}
