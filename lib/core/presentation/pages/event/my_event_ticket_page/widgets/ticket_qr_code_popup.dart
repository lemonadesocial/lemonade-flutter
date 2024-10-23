import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketQRCodePopup extends StatelessWidget {
  const TicketQRCodePopup({
    super.key,
    required this.data,
  });

  final String data;

  void _showErrorAndClose(BuildContext context, String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SnackBarUtils.showError(message: message);
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    if (data.isEmpty) {
      _showErrorAndClose(
        context,
        t.event.invalidQRCode,
      );
      return const SizedBox.shrink();
    }

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(
              Spacing.medium,
            ),
            decoration: BoxDecoration(
              color: LemonColor.atomicBlack,
              border: Border.all(
                color: LemonColor.white06,
              ),
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(LemonRadius.small),
              child: QrImageView(
                data: data,
                backgroundColor: colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
