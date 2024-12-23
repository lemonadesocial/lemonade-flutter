import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/data/event/dtos/event_join_request_dto/event_join_request_dto.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_approval_required_badge.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/event/query/get_my_event_join_request.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestEventDetailRSVPStatus extends StatelessWidget {
  final Event event;
  const GuestEventDetailRSVPStatus({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    final isLoggedIn = context
        .read<AuthBloc>()
        .state
        .maybeWhen(orElse: () => false, authenticated: (_) => true);

    if (!isLoggedIn) {
      return GuestEventDetailApprovalRequiredBadge(event: event);
    }
    if (event.registrationDisabled == true) {
      return _JoinRequestStatusCard(
        title: t.event.rsvpStatus.registrationClosed,
        subTitle: t.event.rsvpStatus.registrationClosedDescription,
        icon: ThemeSvgIcon(
          color: colorScheme.onSecondary,
          builder: (colorFilter) => Assets.icons.icDoNotDisturb.svg(
            colorFilter: colorFilter,
          ),
        ),
      );
    }

    return Query$GetMyEventJoinRequest$Widget(
      options: Options$Query$GetMyEventJoinRequest(
        variables: Variables$Query$GetMyEventJoinRequest(
          event: event.id ?? '',
        ),
      ),
      builder: (result, {refetch, fetchMore}) {
        if (result.isLoading) {
          return Loading.defaultLoading(context);
        }
        if (result.hasException || result.parsedData == null) {
          return EmptyList(
            emptyText: t.common.somethingWrong,
          );
        }
        final eventJoinRequest =
            result.parsedData?.getMyEventJoinRequest != null
                ? EventJoinRequest.fromDto(
                    EventJoinRequestDto.fromJson(
                      result.parsedData!.getMyEventJoinRequest!.toJson(),
                    ),
                  )
                : null;

        if (eventJoinRequest?.isPending == true) {
          return _JoinRequestStatusCard(
            title: t.event.rsvpStatus.pendingApproval,
            subTitle: t.event.rsvpStatus.pendingApprovalDescription,
            icon: SizedBox(
              width: 12.w,
              height: 12.w,
              child: CircularProgressIndicator(
                color: colorScheme.onSecondary,
                strokeWidth: 2.w,
              ),
            ),
            onPressCancel: () {},
          );
        }

        if (eventJoinRequest?.isApproved == true) {
          return _JoinRequestStatusCard(
            title: t.event.rsvpStatus.requestApproved,
            subTitle: t.event.rsvpStatus.requestApprovedDescription,
            icon: ThemeSvgIcon(
              color: LemonColor.paleViolet,
              builder: (colorFilter) => Assets.icons.icOutlineVerified.svg(
                width: 18.w,
                height: 18.w,
                colorFilter: colorFilter,
              ),
            ),
            onPressCancel: () {},
          );
        }

        if (eventJoinRequest?.isDeclined == true) {
          return _JoinRequestStatusCard(
            title: t.event.rsvpStatus.requestDeclined,
            // TODO: will handle escrow different escrow description
            subTitle: t.event.rsvpStatus.requestDeclinedDirectDescription,
            icon: Assets.icons.icCloseCircle.svg(
              width: 18.w,
              height: 18.w,
            ),
            onPressCancel: () {},
          );
        }

        return GuestEventDetailApprovalRequiredBadge(event: event);
      },
    );
  }
}

class _JoinRequestStatusCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget icon;
  final Function()? onPressCancel;

  const _JoinRequestStatusCard({
    required this.title,
    required this.subTitle,
    required this.icon,
    this.onPressCancel,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(
        Spacing.small,
      ),
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.circular(
          LemonRadius.medium,
        ),
        border: Border.all(
          color: colorScheme.outlineVariant,
          width: 1.w,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon,
          SizedBox(width: Spacing.small),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.w),
                Text(
                  subTitle,
                  style: Typo.small.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
