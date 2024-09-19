import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class PostGuestEventDetailVirtualLink extends StatelessWidget {
  final Event event;
  const PostGuestEventDetailVirtualLink({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.event.virtualLink,
            style: Typo.extraMedium.copyWith(
              color: colorScheme.onPrimary,
            ),
          ),
          SizedBox(height: Spacing.smMedium),
          InkWell(
            onTap: () {
              if (event.virtualUrl != null && event.virtualUrl!.isNotEmpty) {
                launchUrl(
                  Uri.parse(event.virtualUrl!),
                  mode: LaunchMode.externalApplication,
                );
              }
            },
            child: Container(
              padding: EdgeInsets.all(Spacing.small),
              decoration: BoxDecoration(
                color: LemonColor.atomicBlack,
                borderRadius: BorderRadius.circular(LemonRadius.medium),
                border: Border.all(
                  color: colorScheme.outline,
                  width: 0.5.w,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: Sizing.medium,
                    height: Sizing.medium,
                    decoration: BoxDecoration(
                      color: LemonColor.chineseBlack,
                      border: Border.all(
                        color: colorScheme.outline,
                        width: 0.5.w,
                      ),
                      borderRadius: BorderRadius.circular(
                        LemonRadius.extraSmall,
                      ),
                    ),
                    child: Center(
                      child: ThemeSvgIcon(
                        color: colorScheme.onSecondary,
                        builder: (filter) => Assets.icons.icLive.svg(
                          colorFilter: filter,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Spacing.small),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.common.actions.joinNow,
                          style: Typo.medium.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 2.w),
                        Text(
                          event.virtualUrl ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Typo.small.copyWith(
                            color: LemonColor.paleViolet,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: Spacing.small),
                  Assets.icons.icExpand.svg(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
