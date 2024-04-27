import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_activity_section.dart';
import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_basic_info_section.dart';
import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_expertise_offering_card.dart';
import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_icebreakers_section.dart';
import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_photos_card.dart';
import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_social_grid_section.dart';
import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_spotline_events_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollaboratorDiscoverView extends StatelessWidget {
  const CollaboratorDiscoverView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        const SliverToBoxAdapter(
          child: CollaboratorDiscoverBasicInfoSection(),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 30.w,
          ),
        ),
        const SliverToBoxAdapter(
          child: CollaboratorDiscoverPhotosCard(
            photos: [
              "https://i.pravatar.cc/1000?img=5",
              "https://i.pravatar.cc/1000?img=9",
              "https://i.pravatar.cc/1000?img=10",
              "https://i.pravatar.cc/1000?img=11",
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 30.w,
          ),
        ),
        const SliverToBoxAdapter(
          child: CollaboratorDiscoverExpertiseOfferingCard(),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 30.w,
          ),
        ),
        const CollaboratorDiscoverSocialGridSection(),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 30.w,
          ),
        ),
        const CollaboratorDiscoverActivitySection(),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 30.w,
          ),
        ),
        const CollaboratorDiscoverSpotlineEventsSection(),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 30.w,
          ),
        ),
        const CollaboratorDiscoverIcebreakersSection(),
      ],
    );
  }
}
