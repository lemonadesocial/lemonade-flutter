import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/domain/reward/entities/reward_signature_response.dart';
import 'package:app/core/domain/reward/reward_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/service/web3/token_reward/token_reward_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

@RoutePage()
class EventDetailClaimTokenRewardPage extends StatelessWidget {
  const EventDetailClaimTokenRewardPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LemonAppBar(),
      body: Center(
        child: FutureBuilder<dartz.Either<Failure, RewardSignatureResponse>>(
          future: getIt<RewardRepository>().generateClaimTicketRewardSignature(
            event: "",
          ),
          builder: (context, snapshot) {
            final response = snapshot.data?.fold(
              (l) => null,
              (r) => r,
            );

            if (response == null) {
              return const Text("Loading...");
            }
            return LinearGradientButton.primaryButton(
              label: "Claim",
              onTap: () {
                TokenRewardUtils.claimReward(
                  vault: response.settings![0].vaultExpanded!,
                  signature: response.signature!,
                  from:
                      context.read<WalletBloc>().state.activeSession?.address ??
                          '',
                );
              },
            );
          },
        ),
      ),
    );
  }
}
