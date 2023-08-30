import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/get_event_detail_input.dart';
import 'package:app/core/domain/poap/entities/poap_entities.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class PoapPolicyEventNodeWidget extends StatelessWidget {
  const PoapPolicyEventNodeWidget({
    super.key,
    required this.node,
    required this.result,
  });

  final PoapPolicyNode node;
  final bool result;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final eventId = node.children?[0].value ?? '';

    return FutureBuilder(
      future: getIt<EventRepository>().getEventDetail(input: GetEventDetailInput(id: eventId)),
      builder: (context, snapshot) {
        final event = snapshot.data?.fold((l) => null, (event) => event);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.nft.poapPolicy.eventPolicy.title(event: event?.title ?? ''),
            ),
            if (!result)
              Text(
                !result ? t.nft.poapPolicy.eventPolicy.nonQualified : '',
                style: Typo.small.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
          ],
        );
      },
    );
  }
}
