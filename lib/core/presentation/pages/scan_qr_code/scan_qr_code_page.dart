import 'package:app/core/application/event/get_event_checkins_bloc/get_event_checkins_bloc.dart';
import 'package:app/core/application/event/update_event_checkin_bloc/update_event_checkin_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/scan_qr_code/widgets/scanner_error_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

@RoutePage()
class ScanQRCodePage extends StatelessWidget {
  const ScanQRCodePage({
    super.key,
    required this.event,
  });
  final Event event;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UpdateEventCheckinBloc(),
        ),
      ],
      child: ScanQRCodePageView(
        event: event,
      ),
    );
  }
}

class ScanQRCodePageView extends StatefulWidget {
  const ScanQRCodePageView({
    super.key,
    required this.event,
  });
  final Event event;

  @override
  State<ScanQRCodePageView> createState() => _ScanQRCodePageViewState();
}

class _ScanQRCodePageViewState extends State<ScanQRCodePageView> {
  String overlayText = "Please scan QR Code";

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
    final t = Translations.of(context);
    setState(() {
      overlayText = barcodeCapture.barcodes.last.displayValue != null
          ? t.event.scanQR.scanTicketSuccess
          : t.common.somethingWrong;
    });
    context.read<UpdateEventCheckinBloc>().add(
          UpdateEventCheckinEvent.checkinUser(
            eventId: widget.event.id ?? '',
            active: true,
            userId: barcodeCapture.barcodes.last.displayValue.toString(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.of(context).size.center(Offset.zero),
      width: 200.w,
      height: 200.w,
    );

    return Scaffold(
      appBar: const LemonAppBar(),
      body: BlocListener<UpdateEventCheckinBloc, UpdateEventCheckinState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () => null,
            success: () {
              AutoRouter.of(context).popTop();
              SnackBarUtils.showSuccessSnackbar(
                t.event.scanQR.scanTicketSuccess,
              );
              context.read<GetEventCheckinsBloc>().add(
                    GetEventCheckinsEvent.fetch(
                      eventId: widget.event.id ?? '',
                    ),
                  );
            },
          );
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Center(
                      child: MobileScanner(
                        fit: BoxFit.cover,
                        onDetect: onBarcodeDetect,
                        overlay: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Opacity(
                              opacity: 1,
                              child: Text(
                                overlayText,
                                style: const TextStyle(
                                  backgroundColor: Colors.black26,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
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
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ValueListenableBuilder<TorchState>(
                              valueListenable: controller.torchState,
                              builder: (context, value, child) {
                                final Color iconColor;
                                switch (value) {
                                  case TorchState.off:
                                    iconColor = Colors.black;
                                    break;
                                  case TorchState.on:
                                    iconColor = Colors.yellow;
                                    break;
                                }
                                return IconButton(
                                  onPressed: () => controller.toggleTorch(),
                                  icon: Icon(
                                    Icons.flashlight_on,
                                    color: iconColor,
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              onPressed: () => controller.switchCamera(),
                              icon: const Icon(
                                Icons.cameraswitch_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScannerOverlay extends CustomPainter {
  ScannerOverlay(this.scanWindow);

  final Rect scanWindow;
  final double borderRadius = 12.0;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()..addRect(Rect.largest);
    final cutoutPath = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          scanWindow,
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
      );

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final borderRect = RRect.fromRectAndCorners(
      scanWindow,
      topLeft: Radius.circular(borderRadius),
      topRight: Radius.circular(borderRadius),
      bottomLeft: Radius.circular(borderRadius),
      bottomRight: Radius.circular(borderRadius),
    );

    // Draw the white border
    canvas.drawPath(backgroundWithCutout, backgroundPaint);
    canvas.drawRRect(borderRect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
