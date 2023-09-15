import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/poap/poap_claim_subscription_bloc/poap_claim_subscription_bloc.dart';
import 'package:app/core/application/poap/poap_transfer_subscription_bloc/poap_transfer_subscription_bloc.dart';
import 'package:app/core/domain/poap/poap_enums.dart';
import 'package:app/core/domain/token/entities/token_entities.dart';
import 'package:app/core/presentation/widgets/poap/poap_claimed_poup/poap_claimed_popup.dart';
import 'package:app/core/presentation/widgets/poap/poap_transfer_popup/poap_transfer_popup.dart';
import 'package:app/core/presentation/widgets/poap/poap_transfer_success_poup/poap_transfer_success_popup.dart';
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
        authenticated: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => PoapClaimSubscriptionBloc()
                ..add(PoapClaimSubscriptionEvent.start()),
            ),
            BlocProvider(
              create: (context) => PoapTransferSubscriptionBloc()
                ..add(PoapTransferSubscriptionEvent.start()),
            ),
          ],
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
        .read<PoapClaimSubscriptionBloc>()
        .add(PoapClaimSubscriptionEvent.clear());
  }

  void showTransferPopup({TokenDetail? token}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PoapTransferPopup(
        token: token,
        onClose: () {
          Navigator.of(context).pop();
          showClaimSuccessPopup(token: token);
        },
      ),
    );
  }

  void showClaimSuccessPopup({TokenDetail? token}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return PoapClaimedPopup(
          token: token,
          onClose: () {
            _clear();
            Navigator.of(context).pop();
          },
          onTransfer: () {
            _clear();
            Navigator.of(context).pop();
            showTransferPopup(token: token);
          },
          onView: () {
            _clear();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<PoapClaimSubscriptionBloc, PoapClaimSubscriptionState>(
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
                  showClaimSuccessPopup(
                    token: token,
                  );
                }
              },
            );
          },
        ),
        BlocListener<PoapTransferSubscriptionBloc,
            PoapTransferSubscriptionState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () => null,
              hasTransferModification: (transferModification, token) {
                if (transferModification.state == TransferState.PENDING) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text('${t.nft.transferring}...'),
                      );
                    },
                  );
                }

                if (transferModification.state == TransferState.CONFIRMED) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return PoapTransferSuccessPopup(
                        token: token,
                      );
                    },
                  );
                }
              },
            );
          },
        ),
      ],
      child: const SizedBox.shrink(),
    );
  }
}
