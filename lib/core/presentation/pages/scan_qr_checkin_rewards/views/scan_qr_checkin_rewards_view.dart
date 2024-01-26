import 'package:app/core/application/event/update_event_checkin_bloc/update_event_checkin_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/scan_qr_checkin_rewards/scan_qr_checkin_rewards_page.dart';
import 'package:app/core/presentation/pages/scan_qr_checkin_rewards/widgets/scanner_actions.dart';
import 'package:app/core/presentation/pages/scan_qr_checkin_rewards/widgets/scanner_error_widget.dart';
import 'package:app/core/presentation/pages/scan_qr_checkin_rewards/widgets/scanner_overlay.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQRCheckinRewardsView extends StatefulWidget {
  const ScanQRCheckinRewardsView({
    super.key,
    required this.event,
    required this.selectedScannerTabIndex,
  });
  final Event event;
  final int selectedScannerTabIndex;

  @override
  State<ScanQRCheckinRewardsView> createState() =>
      _ScanQRCheckinRewardsViewState();
}

class _ScanQRCheckinRewardsViewState extends State<ScanQRCheckinRewardsView> {
  final MobileScannerController controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
    autoStart: true,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onBarcodeDetect(BarcodeCapture barcodeCapture) {
    if (widget.selectedScannerTabIndex == SelectedScannerTab.checkIn.index) {
      context.read<UpdateEventCheckinBloc>().add(
            UpdateEventCheckinEvent.checkinUser(
              eventId: widget.event.id ?? '',
              active: true,
              userId: barcodeCapture.barcodes.last.displayValue.toString(),
            ),
          );
    }
    if (widget.selectedScannerTabIndex == SelectedScannerTab.rewards.index) {
      AutoRouter.of(context).navigate(
        ClaimRewardsRoute(
          userId: barcodeCapture.barcodes.last.displayValue.toString(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.of(context).size.center(Offset.zero),
      width: 200.w,
      height: 200.w,
    );
    return BlocListener<UpdateEventCheckinBloc, UpdateEventCheckinState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          success: () {
            SnackBarUtils.showSuccessSnackbar(
              t.event.scanQR.checkedinSuccessfully,
            );
            AutoRouter.of(context).pop();
          },
        );
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Center(
                    child: MobileScanner(
                      fit: BoxFit.cover,
                      onDetect: onBarcodeDetect,
                      controller: controller,
                      scanWindow: scanWindow,
                      errorBuilder: (context, error, child) {
                        return ScannerErrorWidget(error: error);
                      },
                    ),
                  ),
                  CustomPaint(
                    painter: ScannerOverlay(scanWindow),
                  ),
                  ScannerActions(controller: controller),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
