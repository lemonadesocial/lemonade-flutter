import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/poap/poap_claim_transfer_subscription_bloc/poap_claim_transfer_subscription_bloc.dart';
import 'package:app/core/domain/poap/poap_enums.dart';
import 'package:app/core/presentation/widgets/poap/poap_claimed_poup/poap_claimed_popup.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PoapClaimTransferControllerWidget extends StatelessWidget {
  const PoapClaimTransferControllerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) => state.maybeWhen(
        orElse: () => const SizedBox.shrink(),
        authenticated: (_) => BlocProvider(
          create: (context) => PoapClaimTransferSubscriptionBloc()
            ..add(PoapClaimTransferSubscriptionEvent.start()),
          child: const _PoapClaimTransferControllerWidgetView(),
        ),
      ),
    );
  }
}

class _PoapClaimTransferControllerWidgetView extends StatefulWidget {
  const _PoapClaimTransferControllerWidgetView();

  @override
  State<_PoapClaimTransferControllerWidgetView> createState() =>
      _PoapClaimTransferControllerWidgetViewState();
}

class _PoapClaimTransferControllerWidgetViewState
    extends State<_PoapClaimTransferControllerWidgetView> {
  void _clear() {
    context
        .read<PoapClaimTransferSubscriptionBloc>()
        .add(PoapClaimTransferSubscriptionEvent.clear());
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return BlocListener<PoapClaimTransferSubscriptionBloc,
        PoapClaimTransferSubscriptionState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          hasClaimModification: (claimModification, token) {
            if (claimModification.state == ClaimState.PENDING) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text('${t.nft.claiming}...'),
                  );
                },
              );
            }

            if (claimModification.state == ClaimState.CONFIRMED) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return PoapClaimedPopup(
                    claim: claimModification,
                    token: token,
                    onClose: () {
                      _clear();
                      Navigator.of(context).pop();
                    },
                    onTransfer: () {
                      _clear();
                      Navigator.of(context).pop();
                    },
                    onView: () {
                      _clear();
                      Navigator.of(context).pop();
                    },
                  );
                },
              );
            }
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
