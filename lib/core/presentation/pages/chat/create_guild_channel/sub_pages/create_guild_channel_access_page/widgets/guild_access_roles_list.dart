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
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GuildAccessRolesList extends StatelessWidget {
  const GuildAccessRolesList({
    super.key,
    this.guildDetail,
  });

  final Guild? guildDetail;

  @override
  Widget build(BuildContext context) {
    final guildRoles = guildDetail?.roles ?? [];
    return SliverList.separated(
      itemCount: guildRoles.length,
      itemBuilder: (context, index) {
        return _GuildAccessRoleItem(
          guildRole: guildRoles[index],
          isFirst: index == 0,
          isLast: index == guildRoles.length - 1,
        );
      },
      separatorBuilder: (context, index) {
        return Container(
          height: 1,
          color: LemonColor.white09,
        );
      },
    );
  }
}

class _GuildAccessRoleItem extends StatelessWidget {
  const _GuildAccessRoleItem({
    super.key,
    this.guildRole,
    this.isFirst = false,
    this.isLast = false,
  });

  final GuildRole? guildRole;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.small),
      decoration: BoxDecoration(
        border: Border(
          top: isFirst
              ? BorderSide(
                  color: LemonColor.white09,
                )
              : BorderSide.none,
          bottom: isLast
              ? BorderSide(
                  color: LemonColor.white09,
                )
              : BorderSide.none,
          left: BorderSide(
            color: LemonColor.white09,
          ),
          right: BorderSide(
            color: LemonColor.white09,
          ),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            isFirst ? LemonRadius.medium : 0,
          ),
          topRight: Radius.circular(
            isFirst ? LemonRadius.medium : 0,
          ),
          bottomLeft: Radius.circular(
            isLast ? LemonRadius.medium : 0,
          ),
          bottomRight: Radius.circular(
            isLast ? LemonRadius.medium : 0,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: Sizing.medium / 2,
            height: Sizing.medium / 2,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(),
            child: guildRole?.imageUrl != null
                ? guildRole!.imageUrl!.startsWith('https://')
                    ? Image.network(
                        guildRole?.imageUrl ?? '',
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
                          guildRole?.imageUrl ?? '',
                        ),
                        fit: BoxFit.contain,
                      )
                : const SizedBox.expand(),
          ),
          SizedBox(width: Spacing.xSmall),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  guildRole?.name ?? '',
                  style: Typo.mediumPlus.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          ThemeSvgIcon(
            color: colorScheme.onSurfaceVariant,
            builder: (filter) => Assets.icons.icChecked.svg(
              colorFilter: filter,
              width: Sizing.medium / 2,
              height: Sizing.medium / 2,
            ),
          ),
        ],
      ),
    );
  }
}
