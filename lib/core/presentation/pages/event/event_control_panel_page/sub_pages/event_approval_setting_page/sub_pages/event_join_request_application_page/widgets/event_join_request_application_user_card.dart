import 'package:app/core/config.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/widgets/join_request_user_avatar.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:collection/collection.dart';

class EventJoinRequestApplicationUserCard extends StatelessWidget {
  final EventJoinRequest eventJoinRequest;
  final User? userInfo;
  final Event? event;
  const EventJoinRequestApplicationUserCard({
    super.key,
    required this.eventJoinRequest,
    this.userInfo,
    this.event,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final verifiedEthereumAddresses = userInfo?.walletsNew?['ethereum'];

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
                Flexible(
                  child: JoinRequestUserAvatar(
                    direction: Axis.vertical,
                    eventJoinRequest: eventJoinRequest,
                    avatarSize: Sizing.large,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _Social(
                      userInfo: userInfo,
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (event != null &&
              EventUtils.isWalletVerifiedRequired(
                event!,
                platform: Enum$BlockchainPlatform.ethereum,
              ) &&
              verifiedEthereumAddresses?.isNotEmpty == true) ...[
            SizedBox(height: Spacing.medium),
            _VerifiedWallet(
              label: t.event.rsvpWeb3Indetity.ethAddress,
              address: verifiedEthereumAddresses?.firstWhereOrNull(
                    (element) => element != userInfo?.walletCustodial,
                  ) ??
                  '',
            ),
          ],
        ],
      ),
    );
  }
}

class _VerifiedWallet extends StatelessWidget {
  final String label;
  final String address;
  const _VerifiedWallet({
    required this.label,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Container(
          width: Sizing.medium,
          height: Sizing.medium,
          decoration: BoxDecoration(
            color: LemonColor.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(Sizing.medium),
          ),
          child: Center(
            child: ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icWallet.svg(
                colorFilter: filter,
                width: Sizing.xSmall,
                height: Sizing.xSmall,
              ),
            ),
          ),
        ),
        SizedBox(width: Spacing.small),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Typo.small.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
            Text(
              Web3Utils.formatIdentifier(address),
              style: Typo.medium.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Social extends StatelessWidget {
  final User? userInfo;
  const _Social({
    this.userInfo,
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
          userInfo?.handleLinkedin,
          userInfo?.handleInstagram,
          userInfo?.handleTwitter,
        ].toList().asMap().entries.map((entry) {
          if (entry.value == null || entry.value?.isEmpty == true) {
            return const SizedBox.shrink();
          }
          return GestureDetector(
            onTap: () async {
              launchUrl(
                Uri.parse(
                  '${_socialUrls[entry.key]}/${entry.value ?? ''}',
                ),
                mode: LaunchMode.externalApplication,
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
