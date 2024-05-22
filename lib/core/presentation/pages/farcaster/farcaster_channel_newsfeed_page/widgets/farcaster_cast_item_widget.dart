import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/farcaster_airstack/query/get_farcaster_casts.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;

class FarcasterCastItemWidget extends StatelessWidget {
  final Query$GetFarCasterCasts$FarcasterCasts$Cast cast;
  const FarcasterCastItemWidget({
    super.key,
    required this.cast,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final numberFormat = NumberFormat.compact();

    return Padding(
      padding: EdgeInsets.all(Spacing.xSmall),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LemonNetworkImage(
            width: Sizing.medium,
            height: Sizing.medium,
            borderRadius: BorderRadius.circular(Sizing.medium),
            imageUrl: cast.castedBy?.profileImage ?? '',
            placeholder: ImagePlaceholder.defaultPlaceholder(),
          ),
          SizedBox(width: Spacing.extraSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (cast.quotedCast?.isNotEmpty == true) ...[
                  _Recast(cast: cast),
                  SizedBox(height: 4.w),
                ],
                Row(
                  children: [
                    Text(
                      cast.castedBy?.profileName ?? '',
                      style: Typo.medium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onPrimary,
                      ),
                    ),
                    if (cast.castedAtTimestamp != null)
                      Text(
                        ' ${timeago.format(cast.castedAtTimestamp!.toLocal())}',
                        style: Typo.medium.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                  ],
                ),
                _CastBody(cast: cast),
                Flexible(
                  child: Row(
                    children: [
                      ThemeSvgIcon(
                        color: colorScheme.onSecondary,
                        builder: (filter) => Assets.icons.icChatBubble.svg(
                          colorFilter: filter,
                        ),
                      ),
                      Text(
                        ' ${numberFormat.format(cast.numberOfReplies)}',
                        style: Typo.medium.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                      SizedBox(width: Spacing.extraSmall),
                      ThemeSvgIcon(
                        color: colorScheme.onSecondary,
                        builder: (filter) => Assets.icons.icHeart.svg(
                          colorFilter: filter,
                        ),
                      ),
                      Text(
                        ' ${numberFormat.format(cast.numberOfLikes)}',
                        style: Typo.medium.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                    ],
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

class _CastBody extends StatelessWidget {
  final Query$GetFarCasterCasts$FarcasterCasts$Cast cast;

  const _CastBody({
    required this.cast,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (cast.text?.isNotEmpty == true) ...[
          SizedBox(height: 4.w),
          Linkify(
            text: cast.text ?? '',
            linkStyle: Typo.medium.copyWith(
              color: LemonColor.paleViolet,
              decoration: TextDecoration.none,
            ),
            style: Typo.medium.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
              decoration: TextDecoration.none,
            ),
            onOpen: (link) {
              launchUrl(Uri.parse(link.url));
            },
          ),
        ],
        if (cast.frame?.imageUrl?.isNotEmpty == true) ...[
          SizedBox(height: Spacing.xSmall),
          LemonNetworkImage(
            imageUrl: cast.frame?.imageUrl ?? '',
            borderRadius: BorderRadius.circular(
              LemonRadius.small,
            ),
          ),
        ],
        if (cast.frame?.frameUrl?.isNotEmpty == true) ...[
          SizedBox(height: Spacing.xSmall),
          ClipRRect(
            borderRadius: BorderRadius.circular(
              LemonRadius.small,
            ),
            child: SizedBox(
              height: 250.w, // adjust height as needed
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: Uri.parse(cast.frame?.frameUrl ?? ''),
                ), // replace with your actual URL
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    javaScriptEnabled: true,
                  ),
                ),
              ),
            ),
          ),
        ],
        SizedBox(height: 4.w),
      ],
    );
  }
}

class _Recast extends StatelessWidget {
  const _Recast({
    required this.cast,
  });

  final Query$GetFarCasterCasts$FarcasterCasts$Cast cast;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Row(
      children: [
        ThemeSvgIcon(
          color: colorScheme.onSecondary,
          builder: (filter) => Assets.icons.icRetry.svg(
            colorFilter: filter,
          ),
        ),
        SizedBox(width: 3.w),
        Text(
          '${cast.quotedCast?.first?.castedBy?.profileName ?? ''} ${t.farcaster.recasted}',
          style: Typo.small.copyWith(
            color: colorScheme.onSecondary,
          ),
        ),
      ],
    );
  }
}
