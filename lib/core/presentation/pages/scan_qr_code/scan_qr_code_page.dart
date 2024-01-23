import 'package:app/core/application/event/update_event_checkin_bloc/update_event_checkin_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/scan_qr_code/views/scan_qr_code_view.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SelectedScannerTab {
  checkIn,
  rewards,
}

@RoutePage()
class ScanQRCodePage extends StatefulWidget {
  const ScanQRCodePage({
    super.key,
    required this.event,
    this.successMessage,
  });
  final Event event;
  final String? successMessage;

  @override
  State<ScanQRCodePage> createState() => _ScanQRCodePageState();
}

class _ScanQRCodePageState extends State<ScanQRCodePage> {
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
                  ScanQRCodeView(
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
