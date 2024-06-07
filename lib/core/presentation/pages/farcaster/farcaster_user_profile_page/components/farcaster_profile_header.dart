import 'package:app/core/domain/farcaster/entities/airstack_farcaster_cast.dart';
import 'package:app/core/presentation/pages/farcaster/farcaster_channel_newsfeed_page/widgets/mention_linkifier.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class FarcasterProfileHeader extends StatelessWidget {
  final AirstackFarcasterUser userDetail;
  const FarcasterProfileHeader({
    super.key,
    required this.userDetail,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final numberFormat = NumberFormat.compact();
    final t = Translations.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LemonNetworkImage(
                width: Sizing.large,
                height: Sizing.large,
                borderRadius: BorderRadius.circular(Sizing.large),
                placeholder: ImagePlaceholder.defaultPlaceholder(
                  radius: BorderRadius.circular(Sizing.large),
                ),
                border: Border.all(
                  color: colorScheme.outline,
                ),
                imageUrl: userDetail.profileImage ?? '',
              ),
              SizedBox(width: Spacing.small),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userDetail.profileDisplayName ?? '',
                      style: Typo.mediumPlus.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: Spacing.superExtraSmall,
                    ),
                    Text(
                      '@${userDetail.profileName}',
                      style: Typo.small.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: Spacing.xSmall,
          ),
          if (userDetail.profileBio?.isNotEmpty == true) ...[
            Linkify(
              text: userDetail.profileBio ?? '',
              linkifiers: const [
                EmailLinkifier(),
                UrlLinkifier(),
                FarcasterMentionLinkifier(),
              ],
              linkStyle: Typo.medium.copyWith(
                color: LemonColor.paleViolet,
                decoration: TextDecoration.none,
              ),
              style: Typo.medium.copyWith(
                color: colorScheme.onPrimary,
              ),
              onOpen: (link) async {
                if (link is MentionElement) {
                  AutoRouter.of(context).push(
                    FarcasterUserProfileRoute(
                      profileName: link.url,
                    ),
                  );
                  return;
                }
                launchUrl(Uri.parse(link.url));
              },
            ),
            SizedBox(
              height: Spacing.xSmall,
            ),
          ],
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text:
                      '${numberFormat.format(userDetail.followingCount ?? 0)} ',
                  style: Typo.medium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onPrimary,
                  ),
                  children: [
                    TextSpan(
                      text: t.common.following,
                      style: Typo.small.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
                TextSpan(
                  text:
                      '  ${numberFormat.format(userDetail.followerCount ?? 0)} ',
                  style: Typo.medium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onPrimary,
                  ),
                  children: [
                    TextSpan(
                      text: t.common.follower(n: userDetail.followerCount ?? 0),
                      style: Typo.small.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
                if (userDetail.location?.isNotEmpty == true) ...[
                  WidgetSpan(
                    child: Assets.icons.icLocationPin.svg(
                      width: 14.w,
                      height: 14.w,
                      color: colorScheme.onSecondary,
                    ),
                  ),
                  TextSpan(
                    text: ' ${userDetail.location}',
                    style: Typo.small.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(
            height: Spacing.xSmall,
          ),
        ],
      ),
    );
  }
}
