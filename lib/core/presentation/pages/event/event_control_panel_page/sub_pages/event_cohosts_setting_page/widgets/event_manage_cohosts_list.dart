import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event/manage_event_cohost_requests_bloc/manage_event_cohost_requests_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_cohost_request.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/dpos/common/dropdown_item_dpo.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_cohosts_setting_page/widgets/event_cohost_setting_item.dart';
import 'package:app/core/presentation/widgets/floating_frosted_glass_dropdown_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/event/mutation/update_event.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:sliver_tools/sliver_tools.dart';

enum EventCohostSettingAction {
  show,
  hide,
  remove,
}

class EventManageCohostsList extends StatelessWidget {
  const EventManageCohostsList({
    super.key,
    required this.eventCohostsRequests,
    required this.event,
  });

  final List<EventCohostRequest> eventCohostsRequests;
  final Event? event;

  void _onTapRevoke(
    BuildContext context, {
    User? cohost,
  }) {
    Vibrate.feedback(FeedbackType.light);
    context.read<ManageEventCohostRequestsBloc>().add(
          ManageEventCohostRequestsEvent.saveChanged(
            eventId: event?.id ?? '',
            users: [
              cohost?.userId ?? '',
            ],
            decision: false,
          ),
        );
  }

  Future<void> _onTapShowHideCohosts(
    BuildContext context, {
    User? cohost,
    required bool hide,
  }) async {
    Vibrate.feedback(FeedbackType.light);
    await showFutureLoadingDialog(
      context: context,
      future: () async {
        final newVisibleList = hide
            ? (event?.visibleCohosts ?? [])
                .where((element) => element != cohost?.userId)
                .toList()
            : [...(event?.visibleCohosts ?? []), cohost?.userId ?? '']
                .cast<String>()
                .toList();
        await getIt<AppGQL>().client.mutate$UpdateEvent(
              Options$Mutation$UpdateEvent(
                variables: Variables$Mutation$UpdateEvent(
                  id: event?.id ?? '',
                  input: Input$EventInput(
                    visible_cohosts: newVisibleList,
                  ),
                ),
              ),
            );
        context.read<GetEventDetailBloc>().add(
              GetEventDetailEvent.fetch(
                eventId: event?.id ?? '',
              ),
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final t = Translations.of(context);
    final pendingRequests = eventCohostsRequests
        .where(
          (element) => element.state == EventCohostRequestState.pending,
        )
        .toList();
    final declinedRequests = eventCohostsRequests
        .where(
          (element) => element.state == EventCohostRequestState.declined,
        )
        .toList();

    final acceptedRequests = eventCohostsRequests
        .where(
          (element) => element.state == EventCohostRequestState.accepted,
        )
        .toList();

    return CustomScrollView(
      slivers: [
        _AcceptedCohostsList(
          acceptedRequests: acceptedRequests,
          event: event,
          onTapRevoke: (cohost) => _onTapRevoke(
            context,
            cohost: cohost,
          ),
          onTapShowHide: (cohost, hide) => _onTapShowHideCohosts(
            context,
            cohost: cohost,
            hide: hide,
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: Spacing.small,
          ),
        ),
        if (pendingRequests.isNotEmpty) ...[
          if (acceptedRequests.isNotEmpty)
            SliverToBoxAdapter(
              child: Divider(
                height: 2 * Spacing.small,
                thickness: 1.w,
                color: appColors.pageDivider,
              ),
            ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ThemeSvgIcon(
                  color: appColors.textTertiary,
                  builder: (filter) => Assets.icons.icInfo.svg(
                    colorFilter: filter,
                  ),
                ),
                SizedBox(width: Spacing.small),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.event.eventCohost.pendingCohostsTitle,
                      style: Typo.medium.copyWith(
                        color: appColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2.w),
                    Text(
                      t.event.eventCohost.pendingCohostsDescription,
                      style: Typo.small.copyWith(
                        color: appColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: Spacing.small),
          ),
          SliverList.separated(
            itemBuilder: (context, index) {
              final request = pendingRequests[index];
              return EventCohostSettingItem(
                user: request.toExpanded,
                trailing: _ActionButton(
                  event: event,
                  user: request.toExpanded,
                  canShowHide: false,
                  visible: false,
                  onTapRevoke: () =>
                      _onTapRevoke(context, cohost: request.toExpanded),
                  onTapShowHide: (hide) {},
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              height: Spacing.small,
            ),
            itemCount: pendingRequests.length,
          ),
        ],
        if (declinedRequests.isNotEmpty) ...[
          if (acceptedRequests.isNotEmpty || pendingRequests.isNotEmpty)
            SliverToBoxAdapter(
              child: SizedBox(height: Spacing.smMedium),
            ),
          SliverToBoxAdapter(
            child: Text(
              t.common.status.declined,
              style: Typo.mediumPlus.copyWith(
                color: appColors.textPrimary,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: Spacing.smMedium),
          ),
          SliverList.separated(
            itemBuilder: (context, index) {
              final request = declinedRequests[index];
              return EventCohostSettingItem(
                user: request.toExpanded,
                trailing: _ActionButton(
                  event: event,
                  user: request.toExpanded,
                  canShowHide: false,
                  visible: false,
                  onTapRevoke: () =>
                      _onTapRevoke(context, cohost: request.toExpanded),
                  onTapShowHide: (hide) {},
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              height: Spacing.small,
            ),
            itemCount: declinedRequests.length,
          ),
        ],
      ],
    );
  }
}

class _AcceptedCohostsList extends StatelessWidget {
  final List<EventCohostRequest> acceptedRequests;
  final Event? event;
  final Function(User?) onTapRevoke;
  final Function(User?, bool) onTapShowHide;

  const _AcceptedCohostsList({
    required this.acceptedRequests,
    required this.event,
    required this.onTapRevoke,
    required this.onTapShowHide,
  });

  List<User> get allHosts => [
        event?.hostExpanded,
        ...(event?.cohostsExpanded ?? []),
      ].whereType<User>().toList();

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final t = Translations.of(context);
    final listedAcceptedRequests = event?.visibleCohostsExpanded ?? [];
    final unlistedAcceptedRequests = allHosts
        .where(
          (element) => !(event?.visibleCohosts ?? []).contains(element.userId),
        )
        .toList();

    return MultiSliver(
      children: [
        if (listedAcceptedRequests.isNotEmpty == true)
          SliverList.separated(
            itemBuilder: (context, index) {
              final cohost = listedAcceptedRequests[index];
              return EventCohostSettingItem(
                user: cohost,
                trailing: _ActionButton(
                  event: event,
                  user: cohost,
                  canShowHide: true,
                  visible: true,
                  onTapShowHide: (hide) => onTapShowHide(cohost, hide),
                  onTapRevoke: () => onTapRevoke(cohost),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              height: Spacing.small,
            ),
            itemCount: listedAcceptedRequests.length,
          ),
        if (unlistedAcceptedRequests.isNotEmpty) ...[
          if (listedAcceptedRequests.isNotEmpty)
            SliverToBoxAdapter(
              child: Divider(
                height: 2 * Spacing.small,
                thickness: 1.w,
                color: appColors.pageDivider,
              ),
            ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ThemeSvgIcon(
                  color: appColors.textTertiary,
                  builder: (filter) => Assets.icons.icPrivate.svg(
                    colorFilter: filter,
                  ),
                ),
                SizedBox(width: Spacing.small),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.event.eventCohost.unlistedCohostsTitle,
                      style: Typo.medium.copyWith(
                        color: appColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2.w),
                    Text(
                      t.event.eventCohost.unlistedCohostsDescription,
                      style: Typo.small.copyWith(
                        color: appColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: Spacing.small),
          ),
          SliverList.separated(
            itemBuilder: (context, index) {
              final cohost = unlistedAcceptedRequests[index];
              return EventCohostSettingItem(
                user: cohost,
                trailing: _ActionButton(
                  event: event,
                  user: cohost,
                  canShowHide: true,
                  visible: false,
                  onTapShowHide: (hide) => onTapShowHide(cohost, hide),
                  onTapRevoke: () => onTapRevoke(cohost),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              height: Spacing.small,
            ),
            itemCount: unlistedAcceptedRequests.length,
          ),
        ],
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.user,
    required this.event,
    required this.canShowHide,
    required this.visible,
    required this.onTapShowHide,
    required this.onTapRevoke,
  });

  final User? user;
  final Event? event;
  final bool canShowHide;
  final bool visible;
  final Function(bool) onTapShowHide;
  final Function() onTapRevoke;

  bool get isCreator => event?.host == user?.userId;

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isCreator) ...[
          Container(
            padding: EdgeInsets.symmetric(
              vertical: Spacing.extraSmall / 2,
              horizontal: Spacing.extraSmall,
            ),
            decoration: BoxDecoration(
              color: appColors.cardBg,
              borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
            ),
            child: Center(
              child: Text(
                t.event.eventCohost.creator,
                style: Typo.small.copyWith(
                  color: appColors.textTertiary,
                ),
              ),
            ),
          ),
          SizedBox(width: Spacing.small),
        ],
        FloatingFrostedGlassDropdown(
          offset: Offset(Spacing.small, -Spacing.small),
          containerWidth: 210.w,
          items: [
            if (!visible && canShowHide)
              DropdownItemDpo(
                label: t.event.eventCohost.showCohost,
                value: EventCohostSettingAction.show,
                leadingIcon: Icon(
                  Icons.visibility_outlined,
                  color: appColors.textPrimary,
                ),
                textStyle: Typo.medium.copyWith(
                  color: appColors.textPrimary,
                ),
              ),
            if (visible && canShowHide)
              DropdownItemDpo(
                label: t.event.eventCohost.hideCohost,
                value: EventCohostSettingAction.hide,
                leadingIcon: Icon(
                  Icons.visibility_off_outlined,
                  color: appColors.textPrimary,
                ),
                textStyle: Typo.medium.copyWith(
                  color: appColors.textPrimary,
                ),
              ),
            if (!isCreator)
              DropdownItemDpo(
                label: t.event.eventCohost.removeCohost,
                value: EventCohostSettingAction.remove,
                leadingIcon: Icon(
                  Icons.delete_outline,
                  color: appColors.textError,
                ),
                textStyle: Typo.medium.copyWith(
                  color: appColors.textError,
                ),
              ),
          ],
          onItemPressed: (item) {
            if (item?.value == EventCohostSettingAction.remove) {
              onTapRevoke();
            }
            if (item?.value == EventCohostSettingAction.hide) {
              onTapShowHide(true);
            }
            if (item?.value == EventCohostSettingAction.show) {
              onTapShowHide(false);
            }
          },
          child: ThemeSvgIcon(
            color: appColors.textTertiary,
            builder: (filter) => Assets.icons.icMoreHoriz.svg(
              colorFilter: filter,
            ),
          ),
        ),
      ],
    );
  }
}
