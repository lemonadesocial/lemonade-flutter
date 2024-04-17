import 'package:app/core/domain/chat/entities/guild.dart';
import 'package:app/core/utils/guild_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class GuildDetailItem extends StatelessWidget {
  final Guild? guild;
  final Function() onTap;
  final String? actionLabel;
  const GuildDetailItem({
    super.key,
    this.guild,
    required this.onTap,
    this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: ShapeDecoration(
          color: LemonColor.white06,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(LemonRadius.medium),
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(15.w),
          child: Row(
            children: [
              guild?.imageUrl != null
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
                          guild!.imageUrl!.startsWith('https://')
                              ? Image.network(guild?.imageUrl ?? '')
                              : SvgPicture.network(
                                  GuildUtils.getFullImageUrl(
                                    guild?.imageUrl ?? '',
                                  ),
                                  fit: BoxFit.contain,
                                  width: Sizing.xSmall,
                                  height: Sizing.xSmall,
                                ),
                        ],
                      ),
                    )
                  : const SizedBox.expand(),
              SizedBox(
                width: Spacing.xSmall,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.chat.guild.joinGuildRoom(guildName: guild?.name ?? ''),
                      style: Typo.small.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onPrimary,
                        height: 0,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 2.w,
                          height: 8.w,
                          decoration: ShapeDecoration(
                            color: LemonColor.paleViolet,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(LemonRadius.extraSmall),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Spacing.superExtraSmall,
                        ),
                        Text(
                          t.chat.guild.complete,
                          style: Typo.small.copyWith(
                            color: colorScheme.onSecondary,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: Spacing.superExtraSmall),
                child: Text(
                  actionLabel ?? '',
                  style: Typo.small.copyWith(color: colorScheme.onSecondary),
                ),
              ),
              Assets.icons.icArrowBack.svg(
                width: 18.w,
                height: 18.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
