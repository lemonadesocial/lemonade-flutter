import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_edit_profile_page/widgets/collaborator_edit_profile_field_card.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class CollaboratorEditExpertiseOfferingCard extends StatelessWidget {
  const CollaboratorEditExpertiseOfferingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return SliverToBoxAdapter(
      child: Column(
        children: [
          CollaboratorProfileFieldCard(
            title: t.collaborator.expertise,
            description:
                'Product Management, Product Development / Product Strategy',
          ),
          SizedBox(height: Spacing.superExtraSmall),
          CollaboratorProfileFieldCard(
            title: t.collaborator.offering,
            description: 'Advise companies, find customers',
          ),
        ],
      ),
    );
  }
}
