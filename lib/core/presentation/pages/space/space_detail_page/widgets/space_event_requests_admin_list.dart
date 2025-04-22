import 'package:app/core/application/space/get_space_event_requests_bloc/get_space_event_requests_bloc.dart';
import 'package:app/core/domain/space/entities/space_event_request.dart';
import 'package:app/core/domain/space/space_repository.dart';
import 'package:app/core/presentation/pages/space/space_event_requests_management_page/widgets/space_event_request_item.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/graphql/backend/space/mutation/decide_space_event_requests.graphql.dart';
import 'package:app/graphql/backend/space/query/get_space_event_requests.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpaceEventRequestsAdminList extends StatelessWidget {
  final String spaceId;
  final List<SpaceEventRequest> requests;

  const SpaceEventRequestsAdminList({
    super.key,
    required this.requests,
    required this.spaceId,
  });

  void _refreshRequests(BuildContext context) async {
    context.read<GetSpaceEventRequestsBloc>().add(
          GetSpaceEventRequestsEvent.refresh(
            input: Variables$Query$GetSpaceEventRequests(
              space: spaceId,
              limit: 20,
              skip: 0,
              state: Enum$EventJoinRequestState.pending,
            ),
            refresh: true,
          ),
        );
  }

  Future<void> _viewManagePage(BuildContext context) async {
    await AutoRouter.of(context).push(
      SpaceEventRequestsManagementRoute(
        spaceId: spaceId,
      ),
    );
    _refreshRequests(context);
  }

  Future<void> _decide(
    BuildContext context, {
    required SpaceEventRequest request,
    required Enum$SpaceEventRequestState decision,
  }) async {
    await showFutureLoadingDialog(
      context: context,
      future: () => getIt<SpaceRepository>().decideSpaceEventRequests(
        input: Variables$Mutation$DecideSpaceEventRequests(
          input: Input$DecideSpaceEventRequestsInput(
            space: request.space!,
            requests: [request.id!],
            decision: decision,
          ),
        ),
      ),
    );
    _refreshRequests(context);
  }

  @override
  Widget build(BuildContext context) {
    final firstPendingRequest = requests.firstWhereOrNull(
      (request) => request.state == Enum$SpaceEventRequestState.pending,
    );
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    if (firstPendingRequest == null) {
      return InkWell(
        onTap: () => _viewManagePage(context),
        child: Container(
          padding: EdgeInsets.all(Spacing.small),
          decoration: BoxDecoration(
            color: LemonColor.atomicBlack,
            borderRadius: BorderRadius.circular(LemonRadius.medium),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(Spacing.superExtraSmall),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
                  border: Border.all(color: colorScheme.outlineVariant),
                ),
                child: Center(
                  child: Assets.icons.icCalendarDoneGradient.svg(),
                ),
              ),
              SizedBox(width: Spacing.small),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.space.submittedEvents,
                      style: Typo.medium.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2.w),
                    Text(
                      t.space.accessAllCommunityEventListings,
                      style: Typo.small.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: Spacing.extraSmall),
              ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => Assets.icons.icArrowRight.svg(
                  colorFilter: filter,
                  width: 18.w,
                  height: 18.w,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.space.pendingApprovalEvent,
          style: Typo.medium.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          t.space.eventsAreVisibleOnThePageAfterApproval,
          style: Typo.medium.copyWith(
            color: colorScheme.onSecondary,
          ),
        ),
        SizedBox(height: Spacing.small),
        SpaceEventRequestItem(
          request: firstPendingRequest,
          onApprove: (request) async {
            await _decide(
              context,
              request: request,
              decision: Enum$SpaceEventRequestState.approved,
            );
          },
          onDecline: (request) async {
            await _decide(
              context,
              request: request,
              decision: Enum$SpaceEventRequestState.declined,
            );
          },
        ),
        SizedBox(height: Spacing.extraSmall),
        InkWell(
          onTap: () => _viewManagePage(context),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.small,
              vertical: Spacing.xSmall,
            ),
            decoration: BoxDecoration(
              color: LemonColor.atomicBlack,
              borderRadius: BorderRadius.circular(LemonRadius.small),
              border: Border.all(
                color: colorScheme.outlineVariant,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  t.common.actions.viewAll,
                  style: Typo.medium.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      requests.length.toString(),
                      style: Typo.medium.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                    SizedBox(width: Spacing.extraSmall),
                    ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (filter) => Assets.icons.icArrowRight.svg(
                        colorFilter: filter,
                        width: 18.w,
                        height: 18.w,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
