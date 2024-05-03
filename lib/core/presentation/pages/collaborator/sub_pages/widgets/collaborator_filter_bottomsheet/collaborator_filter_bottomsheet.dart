import 'package:app/core/presentation/pages/collaborator/sub_pages/widgets/collaborator_user_bottomsheet_header/collaborator_user_bottomsheet_header.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

final mockData = [
  "Create new concept",
  "Design advice",
  "Perform video editing",
  "Financial advice",
  "Execute email marketing",
  "Manage budget",
  "Develop marketing strategy",
  "Write blog posts",
  "Optimize website performance",
  "Provide customer support",
  "Conduct market research",
];

class CollaboratorFilterBottomSheet extends StatelessWidget {
  const CollaboratorFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      color: colorScheme.surface,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const BottomSheetGrabber(),
              Padding(
                padding: EdgeInsets.only(
                  top: Spacing.xSmall,
                  bottom: Spacing.smMedium,
                  left: Spacing.smMedium,
                  right: Spacing.smMedium,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CollaboratorUserBottomsheetHeader(
                      icon: ThemeSvgIcon(
                        color: colorScheme.onSecondary,
                        builder: (filter) {
                          return Assets.icons.icEdit.svg(
                            colorFilter: filter,
                            width: Sizing.medium / 2,
                            height: Sizing.medium / 2,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: Spacing.smMedium),
                    Text(
                      t.collaborator.filter.whatAreYouLookingFor,
                      style:
                          Typo.medium.copyWith(color: colorScheme.onSecondary),
                    ),
                    SizedBox(height: Spacing.xSmall),
                    LemonTextField(
                      hintText: t.collaborator.filter.startTypingSomething,
                      contentPadding: EdgeInsets.all(Spacing.small),
                      onChange: (value) {},
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                  child: ListView.builder(
                    itemCount: mockData.length,
                    padding: EdgeInsets.only(bottom: Spacing.large * 4),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: Spacing.small),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              mockData[index],
                              style: Typo.mediumPlus.copyWith(
                                color: colorScheme.onPrimary,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Icon(
                              Icons.circle_outlined,
                              size: Spacing.smMedium,
                              color: colorScheme.onSurfaceVariant,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.all(Spacing.smMedium),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: colorScheme.outline,
                    ),
                  ),
                  color: colorScheme.surface,
                ),
                child: LinearGradientButton.primaryButton(
                  label: t.common.apply,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
