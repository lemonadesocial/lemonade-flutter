import 'package:app/core/domain/poap/entities/poap_entities.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PoapPolicyEmailNodeWidget extends StatelessWidget {
  const PoapPolicyEmailNodeWidget({
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.nft.poapPolicy.emailPolicy.title,
              style: Typo.small.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.w),
            Text(
              result
                  ? t.nft.poapPolicy.emailPolicy.qualified
                  : t.nft.poapPolicy.emailPolicy.nonQualified,
              style: Typo.small.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
          ],
        ),
        if (result) ...[
          const Spacer(),
          Assets.icons.icInvitedFilled.svg(),
        ],
      ],
    );
  }
}
