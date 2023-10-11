import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/poap/poap_claim_subscription_bloc/poap_claim_subscription_bloc.dart';
import 'package:app/core/application/poap/poap_transfer_subscription_bloc/poap_transfer_subscription_bloc.dart';
import 'package:app/core/domain/token/entities/token_entities.dart';
import 'package:app/core/presentation/widgets/poap/poap_claim_transfer_controller_widget/widgets/claim_modification_popup.dart';
import 'package:app/core/presentation/widgets/poap/poap_claim_transfer_controller_widget/widgets/transfer_modification_popup.dart';
import 'package:app/core/presentation/widgets/poap/poap_claimed_poup/poap_claimed_popup.dart';
import 'package:app/core/presentation/widgets/poap/poap_transfer_popup/poap_transfer_popup.dart';
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
  bool visible = false;

  void clear() {
    context
        .read<PoapClaimSubscriptionBloc>()
        .add(PoapClaimSubscriptionEvent.clear());
  }

  void close() {
    visible = false;
    Navigator.of(context).pop();
  }

  void showTransferPopup({TokenDetail? token}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PoapTransferPopup(
        token: token,
        onBack: () {
          close();
          showClaimSuccessPopup(token: token);
        },
        onClose: close,
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
            clear();
            close();
          },
          onTransfer: () {
            clear();
            close();
            showTransferPopup(token: token);
          },
          onView: () {
            clear();
            close();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PoapClaimSubscriptionBloc, PoapClaimSubscriptionState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () => setState(() {
                visible = false;
              }),
              hasClaimModification: (mClaimModification, mToken) {
                if (visible) {
                  Navigator.of(context).pop();
                }
                visible = true;
                showDialog(
                  context: context,
                  builder: (_) => ClaimModificationPopup(
                    claimModification: mClaimModification,
                    token: mToken,
                    onClose: close,
                    onPressedTransfer: (token) {
                      close();
                      showTransferPopup(token: token);
                    },
                  ),
                );
              },
            );
          },
        ),
        BlocListener<PoapTransferSubscriptionBloc,
            PoapTransferSubscriptionState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {
                visible = false;
              },
              hasTransferModification: (mTransferModification, mToken) {
                if (visible) {
                  Navigator.of(context).pop();
                }
                visible = true;
                showDialog(
                  context: context,
                  builder: (_) => TransferModificationPopup(
                    transferModification: mTransferModification,
                    token: mToken,
                    onClose: close,
                    onPressedBack: (token) {
                      close();
                      showClaimSuccessPopup(token: token);
                    },
                  ),
                );
              },
            );
          },
        ),
      ],
      child: const SizedBox.shrink(),
    );
  }
}
