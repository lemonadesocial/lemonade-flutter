import 'package:app/core/domain/chat/entities/guild.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuildRequirementItem extends StatelessWidget {
  final GuildRequirement guildRequirement;
  const GuildRequirementItem({super.key, required this.guildRequirement});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(15.w),
      child: Row(
        children: [
          Container(
            width: Sizing.medium,
            height: Sizing.medium,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: LemonColor.white09,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(LemonRadius.normal),
              ),
            ),
            child: const SizedBox(),
          ),
          SizedBox(
            width: Spacing.xSmall,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                guildRequirement.type ?? '',
                style: Typo.small.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onPrimary,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                'Incomplete',
                style: Typo.small.copyWith(color: colorScheme.onSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
