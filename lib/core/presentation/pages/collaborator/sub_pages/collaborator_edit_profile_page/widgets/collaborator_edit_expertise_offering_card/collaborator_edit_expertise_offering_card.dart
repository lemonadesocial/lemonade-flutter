import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_edit_profile_page/widgets/collaborator_edit_expertise_offering_card/widgets/collaborator_edit_expertise_bottomsheet.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_edit_profile_page/widgets/collaborator_edit_expertise_offering_card/widgets/collaborator_edit_offering_bottomsheet.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_edit_profile_page/widgets/collaborator_edit_profile_field_card.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
            onTap: () {
              showCupertinoModalBottomSheet(
                context: context,
                backgroundColor: LemonColor.atomicBlack,
                topRadius: Radius.circular(30.r),
                builder: (mContext) {
                  return const CollaboratorEditExpertiseBottomSheet();
                },
              );
            },
          ),
          SizedBox(height: Spacing.superExtraSmall),
          CollaboratorProfileFieldCard(
            title: t.collaborator.offering,
            description: 'Advise companies, find customers',
            onTap: () {
              showCupertinoModalBottomSheet(
                context: context,
                backgroundColor: LemonColor.atomicBlack,
                topRadius: Radius.circular(30.r),
                builder: (mContext) {
                  return const CollaboratorEditOfferingBottomSheet();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
