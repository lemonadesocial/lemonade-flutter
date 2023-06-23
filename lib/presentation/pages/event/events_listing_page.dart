import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/presentation/pages/event/widgets/event_card_widget.dart';
import 'package:app/presentation/pages/event/widgets/event_time_filter_button_widget.dart';
import 'package:app/presentation/widgets/lemon_chip_widget.dart';
import 'package:app/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EventsListingPage extends StatelessWidget {
  const EventsListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _EventsListingView();
  }
}

class _EventsListingView extends StatelessWidget {
  const _EventsListingView();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final themeColor = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(t.event.events),
        leading: const Icon(Icons.menu_rounded),
        actions: [
          ThemeSvgIcon(color: themeColor.onSurface, builder: (filter) => Assets.icons.icChat.svg(colorFilter: filter)),
          SizedBox(width: Spacing.medium),
        ],
      ),
      backgroundColor: themeColor.primary,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.small),
        child: Column(
          children: [
            SizedBox(height: Spacing.xSmall),
            _buildEventsFilterBar(context),
            SizedBox(height: Spacing.small),
            _buildEventsListing(),
          ],
        ),
      ),
    );
  }

  Widget _buildEventsFilterBar(BuildContext ctx) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LemonChip(label: t.event.all, isActive: true),
        SizedBox(width: Spacing.superExtraSmall),
        LemonChip(label: t.event.attending),
        SizedBox(width: Spacing.superExtraSmall),
        LemonChip(label: t.event.hosting),
        const Spacer(),
        const EventTimeFilterButton(),
      ],
    );
  }

  _buildEventsListing() {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (ctx, index) => index == 5 ? const SizedBox(height: 80) : const EventCard(),
        separatorBuilder: (ctx, index) => SizedBox(height: Spacing.extraSmall),
        itemCount: 6,
      ),
    );
  }
}
