// ignore_for_file: use_if_null_to_convert_nulls_to_bools

import 'package:app/core/domain/poap/entities/poap_entities.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PoapPolicyTwitterNodeWidget extends StatelessWidget {
  const PoapPolicyTwitterNodeWidget({
    super.key,
    required this.node,
    required this.result,
  });

  final PoapPolicyNode node;
  final bool result;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final errorNode =
        node.children?.firstWhere((nodeItem) => nodeItem.value == 'error');
    final error = errorNode?.children?.isNotEmpty == true
        ? errorNode?.children![0].value ?? ''
        : '';
    String? errorText;
    // TODO: var twitterNotConnected = false;
    if (error.contains('400')) {
      errorText = t.nft.poapPolicy.twitterPolicy.error;
      //TODO twitterNotConnected = true;
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: Sizing.medium,
          height: Sizing.medium,
          padding: EdgeInsets.all(Spacing.extraSmall),
          decoration: BoxDecoration(
            color: LemonColor.black,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Assets.icons.icTwitterXFill.svg(),
          ),
        ),
        SizedBox(width: Spacing.xSmall),
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.nft.poapPolicy.twitterPolicy
                    .title(twitter: node.children?[0].value ?? ''),
                style: Typo.small.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2.w),
              Text(
                result
                    ? t.nft.poapPolicy.twitterPolicy.qualified
                    : errorText ?? t.nft.poapPolicy.twitterPolicy.nonQualified,
                style: Typo.small.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        ),
        if (result) ...[
          const Spacer(),
          Assets.icons.icInvitedFilled.svg(),
        ]
      ],
    );
  }
}
