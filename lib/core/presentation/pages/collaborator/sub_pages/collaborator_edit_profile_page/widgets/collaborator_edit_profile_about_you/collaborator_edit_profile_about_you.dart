import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_edit_profile_page/widgets/collaborator_edit_profile_field_card.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

enum CollaboratorAboutYouField {
  displayName,
  shortBio,
  jobTitle,
  organization,
  basedIn,
  languagesSpoken,
  age,
  ethnicity,
}

class CollaboratorEditProfileAboutYou extends StatelessWidget {
  const CollaboratorEditProfileAboutYou({
    super.key,
  });

  (String, String) getNameAndValue(
    BuildContext context, {
    required CollaboratorAboutYouField field,
  }) {
    final t = Translations.of(context);
    String value = t.collaborator.editProfile.aboutYou.empty;
    switch (field) {
      case CollaboratorAboutYouField.displayName:
        return (t.collaborator.editProfile.aboutYou.displayName, value);
      case CollaboratorAboutYouField.shortBio:
        return (t.collaborator.editProfile.aboutYou.shortBio, value);
      case CollaboratorAboutYouField.jobTitle:
        return (t.collaborator.editProfile.aboutYou.jobTitle, value);
      case CollaboratorAboutYouField.organization:
        return (t.collaborator.editProfile.aboutYou.displayName, value);
      case CollaboratorAboutYouField.basedIn:
        return (t.collaborator.editProfile.aboutYou.basedIn, value);
      case CollaboratorAboutYouField.languagesSpoken:
        return (t.collaborator.editProfile.aboutYou.languagesSpoken, value);
      case CollaboratorAboutYouField.age:
        return (t.collaborator.editProfile.aboutYou.age, value);
      case CollaboratorAboutYouField.ethnicity:
        return (t.collaborator.editProfile.aboutYou.ethnicity, value);
      default:
        return ('', '');
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Text(
            t.collaborator.editProfile.aboutYou.aboutYouTitle,
            style: Typo.mediumPlus.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: Spacing.xSmall,
          ),
        ),
        SliverList.separated(
          itemCount: CollaboratorAboutYouField.values.length,
          itemBuilder: (context, index) {
            final (displayName, value) = getNameAndValue(
              context,
              field: CollaboratorAboutYouField.values[index],
            );
            return CollaboratorProfileFieldCard(
              title: displayName,
              description: value,
            );
          },
          separatorBuilder: (context, index) => SizedBox(
            height: Spacing.superExtraSmall,
          ),
        ),
      ],
    );
  }
}
