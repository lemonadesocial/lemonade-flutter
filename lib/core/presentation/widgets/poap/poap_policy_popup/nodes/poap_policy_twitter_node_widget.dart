// ignore_for_file: use_if_null_to_convert_nulls_to_bools

import 'package:app/core/domain/poap/entities/poap_entities.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

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
    final errorNode = node.children?.firstWhere((nodeItem) => nodeItem.value == 'error');
    final error = errorNode?.children?.isNotEmpty == true ? errorNode?.children![0].value ?? '' : '';
    String? errorText;
    // TODO: var twitterNotConnected = false;
    if (error.contains('400')) {
      errorText = t.nft.poapPolicy.twitterPolicy.error;
      //TODO twitterNotConnected = true;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.nft.poapPolicy.twitterPolicy.title(twitter: node.children?[0].value ?? ''),
        ),
        Text(
          result ? t.nft.poapPolicy.twitterPolicy.qualified : errorText ?? t.nft.poapPolicy.twitterPolicy.nonQualified,
          style: Typo.small.copyWith(
            color: colorScheme.onSecondary,
          ),
        ),
      ],
    );
  }
}
