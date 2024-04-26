import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_basic_info_section.dart';
import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_expertise_offering_card.dart';
import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_photos_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollaboratorUserDiscoverView extends StatelessWidget {
  const CollaboratorUserDiscoverView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CollaboratorDiscoverBasicInfoSection(),
        SizedBox(
          height: 30.w,
        ),
        const CollaboratorDiscoverPhotosCard(
          photos: [
            "https://i.pravatar.cc/1000?img=5",
            "https://i.pravatar.cc/1000?img=9",
            "https://i.pravatar.cc/1000?img=10",
            "https://i.pravatar.cc/1000?img=11",
          ],
        ),
        SizedBox(
          height: 30.w,
        ),
        const CollaboratorDiscoverExpertiseOfferingCard(),
        SizedBox(
          height: 30.w,
        ),
        // TODO: need to refactor CollaboratorDiscoverSocialGridSection
        // not using SliverGrid
        // const CollaboratorDiscoverSocialGridSection(),
      ],
    );
  }
}
