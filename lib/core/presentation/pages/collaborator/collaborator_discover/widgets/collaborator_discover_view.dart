import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_activity_section.dart';
import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_basic_info_section.dart';
import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_expertise_offering_card.dart';
import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_icebreakers_section.dart';
import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_photos_card.dart';
import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_social_grid_section.dart';
import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_spotlight_events_section.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CollaboratorDiscoverView extends StatelessWidget {
  final User? user;
  const CollaboratorDiscoverView({
    super.key,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    final sections = [
      SliverPadding(
        padding: EdgeInsets.only(
          bottom: 30.w,
        ),
        sliver: SliverToBoxAdapter(
          child: CollaboratorDiscoverBasicInfoSection(
            user: user,
          ),
        ),
      ),
      SliverPadding(
        padding: EdgeInsets.only(
          bottom: 30.w,
        ),
        sliver: SliverToBoxAdapter(
          child: CollaboratorDiscoverPhotosCard(
            photos: (user?.newPhotosExpanded ?? [])
                .map(
                  (item) => ImageUtils.generateUrl(
                    file: item,
                  ),
                )
                .toList(),
            bio: user?.description,
          ),
        ),
      ),
      if (user?.expertise?.isNotEmpty == true ||
          user?.serviceOffers?.isNotEmpty == true)
        SliverPadding(
          padding: EdgeInsets.only(
            bottom: 30.w,
          ),
          sliver: SliverToBoxAdapter(
            child: CollaboratorDiscoverExpertiseOfferingCard(
              user: user,
            ),
          ),
        ),
      if (user?.handleFarcaster?.isNotEmpty == true &&
          user?.handleTwitter?.isNotEmpty == true)
        SliverPadding(
          padding: EdgeInsets.only(
            bottom: 30.w,
          ),
          sliver: const CollaboratorDiscoverSocialGridSection(),
        ),
      SliverPadding(
        padding: EdgeInsets.only(
          bottom: 30.w,
        ),
        sliver: const CollaboratorDiscoverActivitySection(),
      ),
      if (user?.eventsExpanded?.isNotEmpty == true)
        SliverPadding(
          padding: EdgeInsets.only(
            bottom: 30.w,
          ),
          sliver: CollaboratorDiscoverSpotlightEventsSection(
            user: user,
          ),
        ),
      if (user?.icebreakers?.isNotEmpty == true)
        CollaboratorDiscoverIcebreakersSection(
          user: user,
        ),
    ];

    return MultiSliver(
      children: sections,
    );
  }
}
