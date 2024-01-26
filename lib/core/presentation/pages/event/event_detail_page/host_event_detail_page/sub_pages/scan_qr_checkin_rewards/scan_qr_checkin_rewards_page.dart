import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/scan_qr_checkin_rewards/views/scan_qr_checkin_rewards_view.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

enum SelectedScannerTab {
  checkIn,
  rewards,
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
  var selectedScannerTabIndex = SelectedScannerTab.checkIn.index;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: const LemonAppBar(),
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Column(
          children: [
            TabBar(
              onTap: (item) {
                setState(() => selectedScannerTabIndex = item);
              },
              labelStyle: Typo.medium.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelStyle: Typo.medium.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
              indicatorColor: LemonColor.paleViolet,
              tabs: [
                Tab(text: t.event.scanQR.checkin.toUpperCase()),
                Tab(text: t.event.scanQR.rewards.toUpperCase()),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Using same instance scan QR code controller when scan QR code
                  // Even it's 2 tabbar
                  ScanQRCheckinRewardsView(
                    event: widget.event,
                    selectedScannerTabIndex: selectedScannerTabIndex,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
