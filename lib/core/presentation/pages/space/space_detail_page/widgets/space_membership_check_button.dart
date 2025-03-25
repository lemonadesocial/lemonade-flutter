import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/space/get_space_detail_bloc/get_space_detail_bloc.dart';
import 'package:app/core/application/token-gating/list_space_token_gates_bloc/list_space_token_gates_bloc.dart';
import 'package:app/core/domain/token-gating/token_gating_repository.dart';
import 'package:app/core/presentation/pages/space/space_detail_page/widgets/space_ambassador_unlocked_bottomsheet.dart';
import 'package:app/core/presentation/pages/token_gating/token_gating_failed_page/token_gating_failed_page.dart';
import 'package:app/core/presentation/pages/token_gating/token_gating_wallet_verification_page/token_gating_wallet_verification_page.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SpaceMembershipCheckButton extends StatelessWidget {
  const SpaceMembershipCheckButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final space = context.watch<GetSpaceDetailBloc>().state.maybeWhen(
          orElse: () => null,
          success: (spaceDetail) => spaceDetail,
        );
    final spaceId = space?.id;
    final userId = context.read<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user.userId,
        );

    if (userId == null || userId.isEmpty) {
      return const SizedBox.shrink();
    }

    if (space?.isAmbassador == true ||
        space?.isCreator(userId: userId) == true ||
        space?.isAdmin(userId: userId) == true) {
      return const SizedBox.shrink();
    }

    if (spaceId == null || spaceId.isEmpty) {
      return const SizedBox.shrink();
    }

    return BlocProvider(
      create: (context) => ListSpaceTokenGatesBloc(
        getIt<TokenGatingRepository>(),
      )..add(
          ListSpaceTokenGatesEvent.fetch(
            spaceId: spaceId,
          ),
        ),
      child: _View(spaceId: spaceId),
    );
  }
}

class _View extends StatelessWidget {
  final String spaceId;
  const _View({
    required this.spaceId,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return BlocBuilder<ListSpaceTokenGatesBloc, ListSpaceTokenGatesState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          fetched: (tokenGates) {
            if (tokenGates.isEmpty) {
              return const SizedBox.shrink();
            }

            return SafeArea(
              child: Container(
                margin: EdgeInsets.only(top: Spacing.medium),
                padding: EdgeInsets.all(Spacing.small),
                decoration: BoxDecoration(
                  color: LemonColor.fluorescentBlue.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(LemonRadius.medium),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        t.space.mayHaveMembershipCheck,
                        style: Typo.medium.copyWith(
                          color: LemonColor.fluorescentBlue,
                        ),
                      ),
                    ),
                    SizedBox(width: Spacing.small),
                    LemonOutlineButton(
                      onTap: () async {
                        final isVerified =
                            await showCupertinoModalBottomSheet<bool>(
                          context: context,
                          expand: false,
                          barrierColor: Colors.black.withOpacity(0.5),
                          backgroundColor: LemonColor.atomicBlack,
                          builder: (context) =>
                              const TokenGatingWalletVerificationPage(),
                        );
                        if (isVerified == true) {
                          final response = await showFutureLoadingDialog(
                            context: context,
                            future: () => getIt<TokenGatingRepository>()
                                .syncSpaceTokenGateAccess(
                              spaceId: spaceId,
                            ),
                          );
                          response.result?.fold(
                            (failure) {
                              SnackBarUtils.showError(message: failure.message);
                            },
                            (data) async {
                              if (data.roles
                                      .contains(Enum$SpaceRole.ambassador) ||
                                  data.roles.contains(Enum$SpaceRole.admin)) {
                                await showCupertinoModalBottomSheet(
                                  context: context,
                                  backgroundColor: LemonColor.atomicBlack,
                                  expand: false,
                                  barrierColor: Colors.black.withOpacity(0.5),
                                  builder: (context) =>
                                      const SpaceAmbassadorUnlockedBottomsheet(),
                                );
                              } else {
                                await showCupertinoModalBottomSheet(
                                  context: context,
                                  backgroundColor: LemonColor.atomicBlack,
                                  expand: false,
                                  barrierColor: Colors.black.withOpacity(0.5),
                                  builder: (context) => TokenGatingFailedPage(
                                    tokenGates: tokenGates,
                                  ),
                                );
                              }
                              context.read<GetSpaceDetailBloc>().add(
                                    GetSpaceDetailEvent.refresh(
                                      spaceId: spaceId,
                                      refresh: true,
                                    ),
                                  );
                            },
                          );
                        }
                      },
                      label: t.common.actions.check,
                      backgroundColor: LemonColor.darkCyan,
                      radius: BorderRadius.circular(LemonRadius.button),
                      textStyle: Typo.medium.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
