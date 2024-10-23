import 'package:app/core/application/event/update_event_checkin_bloc/update_event_checkin_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/scan_qr_checkin_rewards/scan_qr_checkin_rewards_page.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/scan_qr_checkin_rewards/widgets/scanner_actions.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/scan_qr_checkin_rewards/widgets/scanner_error_widget.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/scan_qr_checkin_rewards/widgets/scanner_overlay.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/graphql/backend/event/mutation/update_event_checkin.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
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
    detectionSpeed: DetectionSpeed.normal,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> onBarcodeDetect(BarcodeCapture barcodeCapture) async {
    await controller.stop();
    final shortId = barcodeCapture.barcodes.isNotEmpty
        ? barcodeCapture.barcodes.last.displayValue?.toString() ?? ''
        : '';
    if (widget.selectedScannerTabIndex == SelectedScannerTab.checkIn.index) {
      final response = await showFutureLoadingDialog(
        context: context,
        future: () => getIt<AppGQL>().client.mutate$UpdateEventCheckin(
              Options$Mutation$UpdateEventCheckin(
                variables: Variables$Mutation$UpdateEventCheckin(
                  input: Input$UpdateEventCheckinInput(
                    event: widget.event.id ?? '',
                    active: true,
                    shortid: shortId,
                  ),
                ),
              ),
            ),
      );
      if (response.result?.parsedData?.updateEventCheckin != null) {
        SnackBarUtils.showSuccess(
          message: t.event.scanQR.checkedinSuccessfully,
        );
        await AutoRouter.of(context).pop();
      }
    }
    else if (widget.selectedScannerTabIndex == SelectedScannerTab.rewards.index) {
      final response = await showFutureLoadingDialog(
        context: context,
        future: () => getIt<EventTicketRepository>().getTicket(shortId: shortId),
      );
      
      response.result?.fold(
        (failure) => null,
        (ticket) async {
          final assignedTo = ticket.assignedTo;
          if (assignedTo != null) {
            await AutoRouter.of(context).popAndPush(ClaimRewardsRoute(userId: assignedTo));
          }
        },
      );
    }
    controller.start();
  }

  @override
  Widget build(BuildContext context) {
    final scanWindowSize = 200.w;

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

    return BlocListener<UpdateEventCheckinBloc, UpdateEventCheckinState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () async {
            await AutoRouter.of(context).pop();
            controller.start();
          },
          success: () async {
            SnackBarUtils.showSuccess(
              message: t.event.scanQR.checkedinSuccessfully,
            );
            await AutoRouter.of(context).pop();
            controller.start();
          },
        );
      },
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
            painter: ScannerOverlay(scanWindow: scanWindow),
          ),
          SafeArea(
            child: ScannerActions(controller: controller),
          ),
        ],
      ),
    );
  }
}
