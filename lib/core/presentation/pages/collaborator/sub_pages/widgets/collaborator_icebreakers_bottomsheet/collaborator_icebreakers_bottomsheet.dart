import 'package:app/core/presentation/pages/collaborator/sub_pages/widgets/collaborator_icebreakers_bottomsheet/collaborator_icebreaker_card.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class CollaboratorIceBreakersBottomSheet extends StatelessWidget {
  const CollaboratorIceBreakersBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      color: colorScheme.secondaryContainer,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BottomSheetGrabber(),
          LemonAppBar(
            title: t.collaborator.iceBreakers,
            backgroundColor: colorScheme.secondaryContainer,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
              child: ListView.separated(
                itemCount: 10,
                padding: EdgeInsets.only(bottom: Spacing.large),
                itemBuilder: (BuildContext context, int index) {
                  return const CollaboratorIceBreakerCard();
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: Spacing.xSmall,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
