import 'package:app/core/domain/lens/entities/lens_account.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/graphql/lens/graph/lens_get_graph_follow_stats.graphql.dart';
import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app/app_theme/app_theme.dart';

class LensAccountProfileHeader extends StatelessWidget {
  final LensAccount lensAccount;
  const LensAccountProfileHeader({
    super.key,
    required this.lensAccount,
  });

  @override
  Widget build(BuildContext context) {
    final appText = context.theme.appTextTheme;
    final appColors = context.theme.appColors;
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
                placeholder: ImagePlaceholder.avatarPlaceholder(),
                border: Border.all(
                  color: appColors.pageDivider,
                ),
                imageUrl: lensAccount.metadata?.picture ?? '',
              ),
              SizedBox(width: Spacing.small),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lensAccount.metadata?.name ?? '',
                      style: appText.md,
                    ),
                    SizedBox(
                      height: Spacing.superExtraSmall,
                    ),
                    Text(
                      '@${lensAccount.username?.localName}',
                      style: appText.sm.copyWith(
                        color: appColors.textTertiary,
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
          if (lensAccount.metadata?.bio?.isNotEmpty == true) ...[
            Linkify(
              text: lensAccount.metadata?.bio ?? '',
              linkifiers: const [
                EmailLinkifier(),
                UrlLinkifier(),
              ],
              linkStyle: appText.md.copyWith(
                color: appColors.textAccent,
                decoration: TextDecoration.none,
              ),
              style: appText.md,
              onOpen: (link) async {
                launchUrl(Uri.parse(link.url));
              },
            ),
            SizedBox(
              height: Spacing.xSmall,
            ),
          ],
          Query$LensGetGraphFollowStats$Widget(
            options: Options$Query$LensGetGraphFollowStats(
              variables: Variables$Query$LensGetGraphFollowStats(
                request: Input$AccountStatsRequest(
                  account: lensAccount.address,
                ),
              ),
            ),
            builder: (
              result, {
              refetch,
              fetchMore,
            }) {
              final graphStats =
                  result.parsedData?.accountStats.graphFollowStats;
              final followingCount = graphStats?.following;
              final followersCount = graphStats?.followers;
              return Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${numberFormat.format(followingCount ?? 0)} ',
                      style: appText.md,
                      children: [
                        TextSpan(
                          text: t.common.following,
                          style: appText.sm.copyWith(
                            color: appColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                    TextSpan(
                      text: ' ${numberFormat.format(followersCount ?? 0)} ',
                      style: appText.md,
                      children: [
                        TextSpan(
                          text: t.common.follower(n: followersCount ?? 0),
                          style: appText.sm.copyWith(
                            color: appColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(
            height: Spacing.xSmall,
          ),
        ],
      ),
    );
  }
}
