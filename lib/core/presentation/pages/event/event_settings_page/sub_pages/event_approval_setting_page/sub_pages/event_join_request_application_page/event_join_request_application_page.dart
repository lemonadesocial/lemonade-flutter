import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/onboarding/onboarding_inputs.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/pages/event/event_settings_page/sub_pages/event_approval_setting_page/sub_pages/event_join_request_application_page/widgets/event_join_request_application_form.dart';
import 'package:app/core/presentation/pages/event/event_settings_page/sub_pages/event_approval_setting_page/sub_pages/event_join_request_application_page/widgets/event_join_request_application_user_card.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/graphql/backend/user/query/get_user_from_user_migration.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

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
    if (_isNonLoginUser) {
      final data = await getIt<AppGQL>().client.query$getUserFromUserMigration(
            Options$Query$getUserFromUserMigration(
              variables: Variables$Query$getUserFromUserMigration(
                email: eventJoinRequest.nonLoginUser?.email ?? '',
              ),
            ),
          );
      final userInfo = data.parsedData?.getUserFromUserMigration?.toJson();
      return userInfo != null ? User.fromDto(UserDto.fromJson(userInfo)) : null;
    }
    final response = await getIt<UserRepository>().getUserProfile(
      GetProfileInput(
        id: eventJoinRequest.userExpanded?.userId ?? '',
      ),
    );
    return response.fold(
      (l) => null,
      (r) => r,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: LemonColor.atomicBlack,
      appBar: LemonAppBar(
        backgroundColor: LemonColor.atomicBlack,
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
                  colorScheme: colorScheme,
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
    required this.colorScheme,
    required this.onPressDecline,
    required this.onPressApprove,
  });

  final ColorScheme colorScheme;
  final Function()? onPressDecline;
  final Function()? onPressApprove;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          color: LemonColor.atomicBlack,
          border: Border(
            top: BorderSide(
              color: colorScheme.outline,
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
                child: LinearGradientButton(
                  onTap: () => onPressDecline?.call(),
                  radius: BorderRadius.circular(LemonRadius.small * 2),
                  height: Sizing.large,
                  label: t.common.actions.decline,
                  textStyle: Typo.medium.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                    fontFamily: FontFamily.nohemiVariable,
                  ),
                  leading: ThemeSvgIcon(
                    color: LemonColor.errorRedBg,
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
                child: LinearGradientButton(
                  onTap: () => onPressApprove?.call(),
                  radius: BorderRadius.circular(LemonRadius.small * 2),
                  height: Sizing.large,
                  label: t.common.actions.accept,
                  textStyle: Typo.medium.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                    fontFamily: FontFamily.nohemiVariable,
                  ),
                  leading: ThemeSvgIcon(
                    color: LemonColor.paleViolet,
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
