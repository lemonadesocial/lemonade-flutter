import 'package:app/core/domain/poap/entities/poap_entities.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class PoapPolicyUserNodeWidget extends StatelessWidget {
  const PoapPolicyUserNodeWidget({
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
    final userId = node.children?[0].value ?? '';
    return FutureBuilder(
      future: getIt<UserRepository>().getUserProfile(userId: userId),
      builder: (context, snapshot) {
        final user = snapshot.data?.fold((l) => null, (user) => user);
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.nft.poapPolicy.userPolicy.title(username: user?.username ?? '...'),
            ),
            Text(
              result ? t.nft.poapPolicy.userPolicy.qualified : t.nft.poapPolicy.userPolicy.nonQualified,
              style: Typo.small.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
          ],
        );
      },
    );
  }
}
