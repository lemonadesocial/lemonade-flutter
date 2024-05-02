import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_edit_profile_page/widgets/remove_icon_wrapper.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CollaboratorEditPhotos extends StatelessWidget {
  const CollaboratorEditPhotos({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Text(
            StringUtils.capitalize(t.common.photo(n: 2)),
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
                child: LemonNetworkImage(
                  imageUrl: "",
                  border: Border.all(color: colorScheme.outline),
                  borderRadius: BorderRadius.circular(LemonRadius.medium),
                  placeholder: ImagePlaceholder.defaultPlaceholder(),
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
