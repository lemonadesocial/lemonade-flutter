import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/sub_pages/event_join_request_application_page/widgets/event_join_request_application_form.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/sub_pages/event_join_request_application_page/widgets/event_join_request_application_user_card.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/applicant/query/get_applicants_info.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:app/app_theme/app_theme.dart';

class EventJoinRequestApplicationPage extends StatelessWidget {
  final EventJoinRequest eventJoinRequest;
  final Event? event;
  final Function()? onPressApprove;
  final Function()? onPressDecline;

  const EventJoinRequestApplicationPage({
    super.key,
    required this.eventJoinRequest,
    this.event,
    this.onPressApprove,
    this.onPressDecline,
  });

  bool get isPending => eventJoinRequest.isPending;

  bool get _isNonLoginUser => eventJoinRequest.user == null;

  Future<User?> _getUserInfo() async {
    final data = await getIt<AppGQL>().client.query$GetApplicantsInfo(
          Options$Query$GetApplicantsInfo(
            variables: Variables$Query$GetApplicantsInfo(
              emails: _isNonLoginUser
                  ? [eventJoinRequest.nonLoginUser?.email ?? '']
                  : null,
              users: _isNonLoginUser
                  ? null
                  : [eventJoinRequest.userExpanded?.userId ?? ''],
              event: event?.id ?? '',
            ),
          ),
        );
    final userInfo = data.parsedData?.getApplicantsInfo.firstOrNull?.toJson();
    return userInfo != null ? User.fromDto(UserDto.fromJson(userInfo)) : null;
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appColors = context.theme.appColors;
    return Scaffold(
      backgroundColor: appColors.pageBg,
      appBar: LemonAppBar(
        backgroundColor: appColors.pageBg,
        title: t.event.eventApproval.application,
      ),
      body: FutureBuilder(
        future: _getUserInfo(),
        builder: (context, snapshot) {
          final userInfo = snapshot.data;
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: EventJoinRequestApplicationUserCard(
                        eventJoinRequest: eventJoinRequest,
                        userInfo: userInfo,
                        event: event,
                      ),
                    ),
                    EventJoinRequestApplicationForm(
                      eventJoinRequest: eventJoinRequest,
                      userInfo: userInfo,
                      event: event,
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: Spacing.xLarge * 4,
                      ),
                    ),
                  ],
                ),
              ),
              if (isPending)
                _ActionsBar(
                  onPressDecline: () async {
                    await onPressDecline?.call();
                  },
                  onPressApprove: () async {
                    await onPressApprove?.call();
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}

class _ActionsBar extends StatelessWidget {
  const _ActionsBar({
    required this.onPressDecline,
    required this.onPressApprove,
  });

  final Function()? onPressDecline;
  final Function()? onPressApprove;

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          color: LemonColor.atomicBlack,
          border: Border(
            top: BorderSide(
              color: appColors.pageDivider,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: Spacing.smMedium,
          horizontal: Spacing.xSmall,
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: LinearGradientButton.secondaryButton(
                  onTap: () => onPressDecline?.call(),
                  label: t.common.actions.decline,
                  leading: ThemeSvgIcon(
                    color: appColors.textError,
                    builder: (filter) => Assets.icons.icClose.svg(
                      colorFilter: filter,
                      width: Sizing.xSmall,
                      height: Sizing.xSmall,
                    ),
                  ),
                ),
              ),
              SizedBox(width: Spacing.xSmall),
              Expanded(
                child: LinearGradientButton.primaryButton(
                  onTap: () => onPressApprove?.call(),
                  label: t.common.actions.accept,
                  leading: ThemeSvgIcon(
                    color: appColors.textPrimary,
                    builder: (filter) => Assets.icons.icDone.svg(
                      colorFilter: filter,
                      width: Sizing.xSmall,
                      height: Sizing.xSmall,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
