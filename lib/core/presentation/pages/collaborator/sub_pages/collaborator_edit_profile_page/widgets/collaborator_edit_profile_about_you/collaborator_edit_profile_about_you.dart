import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_edit_profile_page/widgets/collaborator_edit_profile_field_card.dart';
import 'package:app/core/utils/user_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    User? user = context.watch<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession,
          orElse: () => null,
        );
    final t = Translations.of(context);
    String emptyValue = t.collaborator.editProfile.aboutYou.empty;
    switch (field) {
      case CollaboratorAboutYouField.displayName:
        return (
          t.collaborator.editProfile.aboutYou.displayName,
          user?.displayName ?? emptyValue
        );
      case CollaboratorAboutYouField.shortBio:
        return (
          t.collaborator.editProfile.aboutYou.shortBio,
          user?.description ?? emptyValue
        );
      case CollaboratorAboutYouField.jobTitle:
        return (
          t.collaborator.editProfile.aboutYou.jobTitle,
          user?.jobTitle ?? emptyValue
        );
      case CollaboratorAboutYouField.organization:
        return (
          t.collaborator.editProfile.aboutYou.displayName,
          user?.companyName ?? emptyValue
        );
      case CollaboratorAboutYouField.basedIn:
        return (
          t.collaborator.editProfile.aboutYou.basedIn,
          UserUtils.getBasedInLocation(
            user: user,
            emptyText: emptyValue,
          )
        );
      case CollaboratorAboutYouField.languagesSpoken:
        return (
          t.collaborator.editProfile.aboutYou.languagesSpoken,
          emptyValue
        );
      case CollaboratorAboutYouField.age:
        return (
          t.collaborator.editProfile.aboutYou.age,
          UserUtils.getUserAge(
            user: user,
            emptyText: emptyValue,
          )
        );
      case CollaboratorAboutYouField.ethnicity:
        return (
          t.collaborator.editProfile.aboutYou.ethnicity,
          user?.ethnicity ?? emptyValue
        );
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
              onTap: () {
                AutoRouter.of(context).navigate(const EditProfileRoute());
              },
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
