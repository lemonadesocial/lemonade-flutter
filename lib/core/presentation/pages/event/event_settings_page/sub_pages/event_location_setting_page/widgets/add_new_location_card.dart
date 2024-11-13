import 'package:app/core/presentation/pages/event/event_settings_page/sub_pages/event_location_setting_page/sub_pages/event_location_setting_detail_page.dart';
import 'package:flutter/material.dart';

class AddNewLocationCard extends StatelessWidget {
  const AddNewLocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      clipBehavior: Clip.hardEdge,
      child: FractionallySizedBox(
        heightFactor: 0.95,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 35,
              height: 5,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const Expanded(
              child: EventLocationSettingDetailPage(),
            ),
          ],
        ),
      ),
    );
  }
}
