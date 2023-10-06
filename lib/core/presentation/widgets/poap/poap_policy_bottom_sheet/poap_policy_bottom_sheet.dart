import 'package:app/core/application/badge/badge_detail_bloc/badge_detail_bloc.dart';
import 'package:app/core/application/poap/claim_poap_bloc/claim_poap_bloc.dart';
import 'package:app/core/domain/poap/input/poap_input.dart';
import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/core/presentation/widgets/common/bottomsheet/lemon_snap_bottom_sheet_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/poap/poap_policy_bottom_sheet/poap_policy_node_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PoapPolicyBottomSheet extends StatelessWidget {
  const PoapPolicyBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final poapPolicy = context.watch<ClaimPoapBloc>().state.policy;

    return BlocBuilder<BadgeDetailBloc, BadgeDetailState>(
      builder: (context, badgeDetailState) {
        final badge = badgeDetailState.badge;
        return LemonSnapBottomSheet(
          defaultSnapSize: 0.9,
          maxSnapSize: 0.9,
          minSnapSize: 0.5,
          snapSizes: const [0.5, 0.9],
          backgroundColor: LemonColor.atomicBlack,
          builder: (_) => Container(
            height: 0.8.sh,
            padding: EdgeInsets.symmetric(horizontal: Spacing.small),
            color: LemonColor.atomicBlack,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Spacing.smMedium),
                  child: Row(
                    children: [
                      LemonBackButton(
                        color: colorScheme.onSecondary,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.w),
                Text(
                  t.nft.requirements,
                  style: Typo.extraLarge.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w700,
                    fontFamily: FontFamily.nohemiVariable,
                  ),
                ),
                SizedBox(height: Spacing.superExtraSmall),
                Text(
                  t.nft.requirementDescription,
                  style: Typo.mediumPlus.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
                SizedBox(height: Spacing.medium),
                if (poapPolicy != null && poapPolicy.result != null)
                  PoapPolicyNodeWidget(node: poapPolicy.result!.node),
                const Spacer(),
                if (badge.claimable != true && !badgeDetailState.isLoading)
                  SafeArea(
                    child: SizedBox(
                      height: Sizing.large,
                      child: LinearGradientButton(
                        onTap: () {
                          context
                              .read<BadgeDetailBloc>()
                              .add(const BadgeDetailEvent.fetch());
                          context.read<ClaimPoapBloc>().add(
                                const ClaimPoapEvent.checkHasClaimed(
                                  fromServer: true,
                                ),
                              );
                        },
                        label: t.common.actions.refresh,
                        radius: BorderRadius.circular(LemonRadius.small * 2),
                      ),
                    ),
                  ),
                if (badgeDetailState.isLoading)
                  SafeArea(
                    child: SizedBox(
                      height: Sizing.large,
                      child: Loading.defaultLoading(context),
                    ),
                  ),
                if (badge.claimable == true)
                  SafeArea(
                    child: SizedBox(
                      height: Sizing.large,
                      child: LinearGradientButton(
                        onTap: () {
                          Navigator.of(context).pop();
                          context.read<ClaimPoapBloc>().add(
                                ClaimPoapEvent.claim(
                                  input: ClaimInput(
                                    address:
                                        badge.contract?.toLowerCase() ?? '',
                                    network: badge.network ?? '',
                                  ),
                                ),
                              );
                        },
                        label: t.nft.claim,
                        radius: BorderRadius.circular(LemonRadius.small * 2),
                        mode: GradientButtonMode.lavenderMode,
                      ),
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
