import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_edit_profile_page/widgets/collaborator_edit_spotlight_events/widgets/collaborator_add_sppotlight_events_bottomsheet/collaborator_add_sppotlight_events_bottomsheet.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_edit_profile_page/widgets/remove_icon_wrapper.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CollaboratorEditSpotlightEvents extends StatelessWidget {
  const CollaboratorEditSpotlightEvents({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Text(
            StringUtils.capitalize(t.collaborator.editProfile.spotlightEvents),
            style: Typo.mediumPlus.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: Spacing.xSmall),
        ),
        SliverPadding(
          padding: EdgeInsets.only(right: Spacing.superExtraSmall),
          sliver: SliverGrid.builder(
            itemCount: 5,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: Spacing.xSmall,
              crossAxisSpacing: Spacing.xSmall,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              if (index == 0) {
                return InkWell(
                  onTap: () => showCupertinoModalBottomSheet(
                    context: context,
                    expand: true,
                    backgroundColor: LemonColor.atomicBlack,
                    builder: (mContext) =>
                        const CollaboratorAddSpotlightEventBottomSheet(),
                  ),
                  child: DottedBorder(
                    color: colorScheme.outline,
                    borderType: BorderType.RRect,
                    dashPattern: [6.w, 6.w],
                    strokeWidth: 2.w,
                    radius: Radius.circular(LemonRadius.medium),
                    child: Center(
                      child: ThemeSvgIcon(
                        color: colorScheme.onSecondary,
                        builder: (filter) => Assets.icons.icAdd.svg(
                          colorFilter: filter,
                        ),
                      ),
                    ),
                  ),
                );
              }
              return RemoveIconWrapper(
                child: Stack(
                  children: [
                    LemonNetworkImage(
                      imageUrl: "",
                      border: Border.all(color: colorScheme.outline),
                      borderRadius: BorderRadius.circular(LemonRadius.medium),
                      placeholder: ImagePlaceholder.defaultPlaceholder(),
                      fit: BoxFit.cover,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Spacing.xSmall,
                          vertical: Spacing.xSmall,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Living rooom gig",
                              style: Typo.small.copyWith(
                                color: colorScheme.onPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 2.w),
                            Text(
                              DateFormatUtils.dateOnly(DateTime.now()),
                              style: Typo.xSmall.copyWith(
                                color: colorScheme.onSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
