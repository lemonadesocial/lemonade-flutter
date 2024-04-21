import 'package:app/core/domain/chat/entities/guild.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/guild_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class GuildAccessInfoSection extends StatelessWidget {
  const GuildAccessInfoSection({super.key, this.guildDetail});

  final Guild? guildDetail;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(Spacing.small),
          decoration: BoxDecoration(
            color: LemonColor.white06,
            borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: Sizing.small,
                height: Sizing.small,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1,
                    color: LemonColor.white09,
                  ),
                ),
                child: ClipOval(
                  child: guildDetail?.imageUrl != null
                      ? Container(
                          width: Sizing.medium,
                          height: Sizing.medium,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: LemonColor.white09,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(LemonRadius.normal),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              guildDetail!.imageUrl!.startsWith('https://')
                                  ? Image.network(
                                      guildDetail?.imageUrl ?? '',
                                      errorBuilder: (
                                        BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace,
                                      ) {
                                        return LemonCircleAvatar(
                                          size: Sizing.medium,
                                        );
                                      },
                                    )
                                  : SvgPicture.network(
                                      GuildUtils.getFullImageUrl(
                                        guildDetail?.imageUrl ?? '',
                                      ),
                                      fit: BoxFit.contain,
                                    ),
                            ],
                          ),
                        )
                      : const SizedBox.expand(),
                ),
              ),
              SizedBox(width: Spacing.xSmall),
              Expanded(
                child: Text(
                  guildDetail?.name ?? '',
                  style: Typo.mediumPlus.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
              SizedBox(width: Spacing.xSmall),
              InkWell(
                onTap: () {
                  Vibrate.feedback(FeedbackType.light);
                  AutoRouter.of(context).pop();
                },
                child: ThemeSvgIcon(
                  builder: (colorFilter) => Assets.icons.icReload.svg(
                    colorFilter: colorFilter,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Spacing.small,
        ),
        Container(
          padding: EdgeInsets.all(Spacing.small),
          decoration: BoxDecoration(
            color: LemonColor.white06,
            borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: Sizing.small,
                height: Sizing.small,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2,
                    color: LemonColor.white09,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 6.w,
                      height: 6.w,
                      decoration: BoxDecoration(
                        color: LemonColor.paleViolet,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: Spacing.xSmall),
              Expanded(
                child: Text(
                  t.chat.guild.allowAccessTo,
                  style: Typo.mediumPlus.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
              SizedBox(width: Spacing.xSmall),
            ],
          ),
        ),
      ],
    );
  }
}
