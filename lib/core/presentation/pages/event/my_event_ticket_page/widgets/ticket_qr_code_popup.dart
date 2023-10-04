import 'package:app/core/utils/auth_utils.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketQRCodePopup extends StatelessWidget {
  const TicketQRCodePopup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final userId = AuthUtils.getUserId(context);
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
                data: userId,
                backgroundColor: colorScheme.onPrimary,
              ),
            ),
          )
        ],
      ),
    );
  }
}
