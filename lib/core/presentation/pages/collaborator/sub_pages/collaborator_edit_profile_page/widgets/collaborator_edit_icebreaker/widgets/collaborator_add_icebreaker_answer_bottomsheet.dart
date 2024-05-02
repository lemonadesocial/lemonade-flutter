import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollaboratorAddIcebreakerAnswerBottomsheet extends StatelessWidget {
  const CollaboratorAddIcebreakerAnswerBottomsheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(LemonRadius.small),
      borderSide: BorderSide(color: colorScheme.outline),
    );
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BottomSheetGrabber(),
          LemonAppBar(
            title: t.collaborator.editProfile.addIcebreaker,
            backgroundColor: LemonColor.atomicBlack,
          ),
          Padding(
            padding: EdgeInsets.all(Spacing.smMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(Spacing.small),
                  decoration: BoxDecoration(
                    color: colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(LemonRadius.medium),
                  ),
                  child: Text(
                    "The one thing I will always be proud of",
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
                SizedBox(height: Spacing.xSmall),
                SizedBox(
                  height: 140.w,
                  child: TextField(
                    onChanged: (v) {},
                    textAlignVertical: TextAlignVertical.top,
                    expands: true,
                    autofocus: true,
                    cursorColor: colorScheme.onSecondary,
                    decoration: InputDecoration(
                      hintText:
                          t.collaborator.editProfile.addPromptAnswerPlaceholder,
                      filled: true,
                      enabledBorder: border,
                      focusedBorder: border,
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(Spacing.smMedium),
            decoration: BoxDecoration(
              color: LemonColor.atomicBlack,
              border: Border(
                top: BorderSide(
                  color: colorScheme.outline,
                ),
              ),
            ),
            child: SafeArea(
              child: LinearGradientButton.primaryButton(
                label: t.common.actions.add,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
