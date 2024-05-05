import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_edit_profile_page/widgets/collaborator_edit_expertise_offering_card/collaborator_edit_expertise_offering_card.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_edit_profile_page/widgets/collaborator_edit_icebreaker/collaborator_edit_icebreaker.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_edit_profile_page/widgets/collaborator_edit_photos/collaborator_edit_photos.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_edit_profile_page/widgets/collaborator_edit_profile_about_you/collaborator_edit_profile_about_you.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_edit_profile_page/widgets/collaborator_edit_social_connect/collaborator_edit_social_connect.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_edit_profile_page/widgets/collaborator_edit_spotlight_events/collaborator_edit_spotlight_events.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CollaboratorEditProfilePage extends StatelessWidget {
  const CollaboratorEditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Scaffold(
      appBar: LemonAppBar(
        title: t.common.actions.editProfile,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Spacing.small),
            child: InkWell(
              onTap: () {
                AutoRouter.of(context)
                    .navigate(const CollaboratorPreviewProfileRoute());
              },
              child: ThemeSvgIcon(
                builder: (filter) => Assets.icons.icPreviewProfile.svg(
                  colorFilter: filter,
                  width: Sizing.small,
                  height: Sizing.small,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
        child: CustomScrollView(
          slivers: [
            const CollaboratorEditExpertiseOfferingCard(),
            SliverToBoxAdapter(
              child: SizedBox(height: Spacing.large),
            ),
            const CollaboratorEditSocialConnect(),
            SliverToBoxAdapter(
              child: SizedBox(height: Spacing.large),
            ),
            const CollaboratorEditSpotlightEvents(),
            SliverToBoxAdapter(
              child: SizedBox(height: Spacing.large),
            ),
            const CollaboratorEditIcebreakers(),
            SliverToBoxAdapter(
              child: SizedBox(height: Spacing.large),
            ),
            const CollaboratorEditPhotos(),
            // SliverToBoxAdapter(
            //   child: SizedBox(height: Spacing.large),
            // ),
            // const CollaboratorEditProfileAboutYou(),
            // SliverToBoxAdapter(
            //   child: SizedBox(height: Spacing.large),
            // ),
          ],
        ),
      ),
    );
  }
}
