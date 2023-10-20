import 'package:app/core/domain/onboarding/onboarding_inputs.dart';
import 'package:app/core/domain/poap/entities/poap_entities.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      future:
          getIt<UserRepository>().getUserProfile(GetProfileInput(id: userId)),
      builder: (context, snapshot) {
        final user = snapshot.data?.fold((l) => null, (user) => user);
        return InkWell(
          onTap: () {
            AutoRouter.of(context).navigate(ProfileRoute(userId: userId));
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Assets.images.lemonCircleLogo.image(
                width: Sizing.medium,
                height: Sizing.medium,
              ),
              SizedBox(width: Spacing.xSmall),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.nft.poapPolicy.userPolicy
                        .title(username: user?.username ?? '...'),
                    style: Typo.small.copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 2.w),
                  Text(
                    result
                        ? t.nft.poapPolicy.userPolicy.qualified
                        : t.nft.poapPolicy.userPolicy.nonQualified,
                    style: Typo.small.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                  if (result) ...[
                    const Spacer(),
                    Assets.icons.icInvitedFilled.svg(),
                  ]
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
