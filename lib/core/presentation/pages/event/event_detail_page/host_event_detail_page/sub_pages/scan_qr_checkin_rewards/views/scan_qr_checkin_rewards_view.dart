import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/scan_qr_checkin_rewards/scan_qr_checkin_rewards_page.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/scan_qr_checkin_rewards/views/guest_detail_bottom_sheet_view.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/scan_qr_checkin_rewards/widgets/scanner_error_widget.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/scan_qr_checkin_rewards/widgets/scanner_overlay.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ScanQRCheckinRewardsView extends StatefulWidget {
  const ScanQRCheckinRewardsView({
    super.key,
    required this.event,
    required this.selectedScanTarget,
    required this.controller,
  });
  final Event event;
  final ScanTarget selectedScanTarget;
  final MobileScannerController controller;

  @override
  State<ScanQRCheckinRewardsView> createState() =>
      _ScanQRCheckinRewardsViewState();
}

class _ScanQRCheckinRewardsViewState extends State<ScanQRCheckinRewardsView> {
  Future<void> onBarcodeDetect(BarcodeCapture barcodeCapture) async {
    await widget.controller.stop();
    final shortId = barcodeCapture.barcodes.isNotEmpty
        ? barcodeCapture.barcodes.last.displayValue?.toString() ?? ''
        : '';

    switch (widget.selectedScanTarget) {
      case ScanTarget.tickets:
        await showCupertinoModalBottomSheet(
          context: context,
          useRootNavigator: true,
          backgroundColor: LemonColor.atomicBlack,
          builder: (context) => GuestDetailBottomSheetView(
            shortId: shortId,
            event: widget.event,
          ),
        );
      case ScanTarget.rewards:
        final response = await showFutureLoadingDialog(
          context: context,
          future: () =>
              getIt<EventTicketRepository>().getTicket(shortId: shortId),
        );
        response.result?.fold(
          (failure) => null,
          (ticket) async {
            final assignedTo = ticket.assignedTo;
            if (assignedTo != null) {
              await AutoRouter.of(context)
                  .popAndPush(ClaimRewardsRoute(userId: assignedTo));
            }
          },
        );
    }
    if (!widget.controller.isStarting) {
      widget.controller.start();
    }
  }

  @override
  Widget build(BuildContext context) {
    final scanWindowSize = MediaQuery.of(context).size.width * 0.75;

    // Get the actual visible area of the screen
    final screenSize = MediaQuery.of(context).size;
    final safeArea = MediaQuery.of(context).padding;
    final appBarHeight = AppBar().preferredSize.height;
    final tabBarHeight = 100.w;
    final spacingBottom = 35.w;
    final availableHeight = screenSize.height -
        safeArea.top -
        safeArea.bottom -
        appBarHeight -
        tabBarHeight -
        spacingBottom;

    final centerY = (availableHeight / 2);

    final scanWindow = Rect.fromCenter(
      center: Offset(screenSize.width / 2, centerY),
      width: scanWindowSize,
      height: scanWindowSize,
    );

    return Column(
      children: [
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Center(
                child: MobileScanner(
                  fit: BoxFit.cover,
                  onDetect: onBarcodeDetect,
                  controller: widget.controller,
                  scanWindow: scanWindow,
                  errorBuilder: (context, error, child) {
                    return ScannerErrorWidget(error: error);
                  },
                ),
              ),
              CustomPaint(
                painter: ScannerOverlay(scanWindow: scanWindow),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
