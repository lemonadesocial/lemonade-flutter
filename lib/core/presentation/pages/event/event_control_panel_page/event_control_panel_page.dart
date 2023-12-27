import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/create_event/widgets/create_event_config_grid.dart';
import 'package:app/core/presentation/pages/event/guest_event_detail_page/widgets/host_event_detail_config_grid.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EventControlPanelPage extends StatefulWidget {
  final Event event;

  const EventControlPanelPage({
    super.key,
    required this.event,
  });

  @override
  State<EventControlPanelPage> createState() => _EventControlPanelPageState();
}

class _EventControlPanelPageState extends State<EventControlPanelPage> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      appBar: LemonAppBar(
        backgroundColor: colorScheme.primary,
        title: t.event.dateAndTime,
      ),
      backgroundColor: colorScheme.primary,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
              sliver: HostEventDetailConfigGrid(
                event: widget.event,
              ),
            ),
            CreateEventConfigGrid(),
          ],
        ),
      ),
    );
  }
}
