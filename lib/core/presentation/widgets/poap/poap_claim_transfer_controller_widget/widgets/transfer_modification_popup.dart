import 'package:app/core/domain/poap/entities/poap_entities.dart';
import 'package:app/core/domain/poap/poap_enums.dart';
import 'package:app/core/domain/token/entities/token_entities.dart';
import 'package:app/core/presentation/widgets/poap/poap_transfer_success_poup/poap_transfer_success_popup.dart';
import 'package:app/core/presentation/widgets/poap/popap_busy_popup/poap_busy_popup.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:flutter/material.dart';

class TransferModificationPopup extends StatelessWidget {
  final Transfer? transferModification;
  final TokenDetail? token;
  final Function() onClose;
  final Function(TokenDetail? token) onPressedBack;

  const TransferModificationPopup({
    super.key,
    this.transferModification,
    this.token,
    required this.onClose,
    required this.onPressedBack,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    if (transferModification?.state == TransferState.PENDING) {
      return PoapBusyPopup(
        onClose: onClose,
        title: '${t.nft.transferring}...',
      );
    }

    if (transferModification?.state == TransferState.CONFIRMED) {
      return PoapTransferSuccessPopup(
        token: token,
        onClose: onClose,
      );
    }
    return const SizedBox.shrink();
  }
}
