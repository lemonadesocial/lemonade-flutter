import 'package:app/core/config.dart';
import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/widgets/event_join_request_ticket_info.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/widgets/join_request_user_avatar.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class EventJoinRequestApplicationUserCard extends StatelessWidget {
  final EventJoinRequest eventJoinRequest;
  final User? user;
  const EventJoinRequestApplicationUserCard({
    super.key,
    required this.eventJoinRequest,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.smMedium),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary.withOpacity(0.03),
        borderRadius: BorderRadius.circular(LemonRadius.medium),
      ),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                JoinRequestUserAvatar(
                  direction: Axis.vertical,
                  user: eventJoinRequest.userExpanded,
                  avatarSize: Sizing.large,
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    EventJoinRequestTicketInfo(
                      padding: EdgeInsets.all(Spacing.extraSmall),
                      eventJoinRequest: eventJoinRequest,
                      showPrice: false,
                    ),
                    _Social(user: user),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Social extends StatelessWidget {
  final User? user;
  const _Social({
    this.user,
  });

  List<SvgGenImage> get _socialIconsSvg => [
        Assets.icons.icLinkedin,
        Assets.icons.icInstagram,
        Assets.icons.icXLine,
      ];

  List<String> get _socialUrls => [
        AppConfig.linkedinUrl,
        AppConfig.instagramUrl,
        AppConfig.twitterUrl,
      ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: Sizing.medium,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          user?.handleLinkedin,
          user?.handleInstagram,
          user?.handleTwitter,
        ].asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () async {
              AutoRouter.of(context).navigate(
                WebviewRoute(
                  uri: Uri.parse(
                    '${_socialUrls[entry.key]}/${entry.value ?? ''}}',
                  ),
                ),
              );
            },
            child: Container(
              width: Sizing.medium,
              height: Sizing.medium,
              margin: EdgeInsets.only(left: Spacing.xSmall),
              decoration: BoxDecoration(
                color: LemonColor.darkBackground,
                borderRadius: BorderRadius.circular(Sizing.medium),
              ),
              child: Center(
                child: ThemeSvgIcon(
                  color: colorScheme.onSecondary,
                  builder: (filter) => _socialIconsSvg[entry.key].svg(
                    colorFilter: filter,
                    width: Sizing.xSmall,
                    height: Sizing.xSmall,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
