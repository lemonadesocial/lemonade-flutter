import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/scan_qr_checkin_rewards/views/scan_qr_checkin_rewards_view.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/scan_qr_checkin_rewards/widgets/scanner_actions.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

enum ScanTarget {
  tickets,
  rewards;

  String get label {
    return switch (this) {
      ScanTarget.tickets => t.event.configuration.tickets,
      ScanTarget.rewards => t.event.scanQR.rewards,
    };
  }
}

@RoutePage()
class ScanQRCheckinRewardsPage extends StatelessWidget {
  const ScanQRCheckinRewardsPage({
    super.key,
    required this.event,
  });
  final Event event;

  @override
  Widget build(BuildContext context) {
    return _ScanQRCheckinRewardsView(event: event);
  }
}

class _ScanQRCheckinRewardsView extends StatefulWidget {
  const _ScanQRCheckinRewardsView({required this.event});
  final Event event;

  @override
  State<_ScanQRCheckinRewardsView> createState() =>
      _ScanQRCheckinRewardsViewState();
}

class _ScanQRCheckinRewardsViewState extends State<_ScanQRCheckinRewardsView> {
  late final MobileScannerController controller;
  ScanTarget selectedScanTarget = ScanTarget.tickets;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: LemonAppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Spacing.xSmall),
            child: ValueListenableBuilder<TorchState>(
              valueListenable: controller.torchState,
              builder: (context, value, child) {
                final iconColor =
                    value == TorchState.on ? Colors.yellow : Colors.white;
                return IconButton(
                  onPressed: () => controller.toggleTorch(),
                  icon: Icon(
                    Icons.flashlight_on_outlined,
                    color: iconColor,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ScanQRCheckinRewardsView(
              event: widget.event,
              selectedScanTarget: selectedScanTarget,
              controller: controller,
            ),
          ),
          SafeArea(
            child: ScannerActions(
              event: widget.event,
              controller: controller,
              selectedScanTarget: selectedScanTarget,
              onScanTargetChanged: (target) {
                setState(() => selectedScanTarget = target);
              },
            ),
          ),
        ],
      ),
    );
  }
}
