import 'package:app/core/application/chat/new_chat_bloc/new_chat_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/scan_qr_code/views/scan_qr_code_view.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
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
class ScanQRCodePage extends StatelessWidget {
  const ScanQRCodePage({
    super.key,
    required this.event,
  });
  final Event event;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewChatBloc(),
      child: _ScanQRCodeView(event: event),
    );
  }
}

class _ScanQRCodeView extends StatefulWidget {
  const _ScanQRCodeView({required this.event});
  final Event event;

  @override
  State<_ScanQRCodeView> createState() => _ScanQRCodeViewState();
}

class _ScanQRCodeViewState extends State<_ScanQRCodeView> {
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
