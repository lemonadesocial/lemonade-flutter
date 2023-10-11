import 'package:app/core/domain/poap/entities/poap_entities.dart';
import 'package:app/core/domain/poap/poap_enums.dart';
import 'package:app/core/domain/token/entities/token_entities.dart';
import 'package:app/core/presentation/widgets/common/dialog/lemon_alert_dialog.dart';
import 'package:app/core/presentation/widgets/poap/poap_claimed_poup/poap_claimed_popup.dart';
import 'package:app/core/presentation/widgets/poap/popap_busy_popup/poap_busy_popup.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:flutter/material.dart';

class ClaimModificationPopup extends StatelessWidget {
  final Claim? claimModification;
  final TokenDetail? token;
  final Function() onClose;
  final Function(TokenDetail? token) onPressedTransfer;

  const ClaimModificationPopup({
    super.key,
    this.claimModification,
    this.token,
    required this.onClose,
    required this.onPressedTransfer,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    if (claimModification?.state == ClaimState.FAILED) {
      final errorDescriptionName = claimModification?.errorDescription != null
          ? claimModification?.errorDescription!['name']
          : '';
      String errorDescriptionMessage = '';
      if (errorDescriptionName == ClaimErrorDescriptionName.AllClaimed.name) {
        errorDescriptionMessage = t.nft.claimFailedDescription.allClaimed;
      }
      if (errorDescriptionName ==
          ClaimErrorDescriptionName.AlreadyClaimed.name) {
        errorDescriptionMessage = t.nft.claimFailedDescription.alreadyClaimed;
      }

      if (errorDescriptionName == ClaimErrorDescriptionName.Forbidden.name) {
        errorDescriptionMessage = t.nft.claimFailedDescription.forbidden;
      } else {
        errorDescriptionMessage = errorDescriptionName ?? '';
      }

      if (errorDescriptionMessage.isEmpty) {
        onClose.call();
        return const SizedBox.shrink();
      }

      return LemonAlertDialog(
        onClose: onClose,
        child: Text(
          errorDescriptionMessage,
        ),
      );
    }

    if (claimModification?.state == ClaimState.PENDING) {
      return PoapBusyPopup(
        onClose: onClose,
        title: '${t.nft.claiming}...',
      );
    }

    if (claimModification?.state == ClaimState.CONFIRMED) {
      return PoapClaimedPopup(
        token: token,
        onClose: () {
          onClose.call();
        },
        onTransfer: () {
          onPressedTransfer.call(token);
        },
        onView: () {
          onClose.call();
        },
      );
    }

    return const SizedBox.shrink();
  }
}
