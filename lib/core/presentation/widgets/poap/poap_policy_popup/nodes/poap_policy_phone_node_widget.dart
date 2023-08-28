import 'package:app/core/domain/poap/entities/poap_entities.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class PoapPolicyPhoneNodeWidget extends StatelessWidget {
  const PoapPolicyPhoneNodeWidget({
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.nft.poapPolicy.phonePolicy.title,
        ),
        Text(
          result ? t.nft.poapPolicy.phonePolicy.qualified : t.nft.poapPolicy.phonePolicy.nonQualified,
          style: Typo.small.copyWith(
            color: colorScheme.onSecondary,
          ),
        ),
      ],
    );
  }
}
