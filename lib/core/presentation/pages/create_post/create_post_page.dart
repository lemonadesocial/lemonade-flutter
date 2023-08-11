import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../i18n/i18n.g.dart';
import '../../widgets/common/button/linear_gradient_button_widget.dart';
import '../../widgets/theme_svg_icon_widget.dart';

@RoutePage()
class CreatePostPage extends StatelessWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textCtrl = TextEditingController();
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: AppBar(
        leading: const LemonBackButton(),
        actions: [
          InkWell(
            onTap: textCtrl.text.isEmpty ? null : () {},
            child: Row(
              children: [
                LinearGradientButton(
                  label: t.post.post,
                  radius: BorderRadius.circular(32),
                  padding: EdgeInsets.symmetric(
                    horizontal: Spacing.smMedium,
                    vertical: Spacing.superExtraSmall,
                  ),
                  onTap: textCtrl.text.isEmpty ? null : () {},
                )
              ],
            ),
          ),
          SizedBox(width: Spacing.smMedium),
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Divider(color: colorScheme.onSurface),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                child: TextFormField(
                  controller: textCtrl,
                  maxLines: 10,
                  cursorColor: colorScheme.onPrimary,
                  decoration: InputDecoration.collapsed(hintText: t.home.whatOnYourMind),
                ),
              ),
            ),
            Divider(color: colorScheme.onSurface),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: Row(
                      children: [
                        ThemeSvgIcon(
                          color: colorScheme.onSurface,
                          builder: (filter) => Assets.icons.icHouseParty.svg(colorFilter: filter),
                        ),
                        SizedBox(width: Spacing.medium),

                        // TODO(Ron): Temporary remove since we don't have integration with it yet
                        // Assets.icons.icCrystal.svg(color: LemonColor.white.withOpacity(0.7)),
                        // SizedBox(width: Spacing.medium),
                        // Assets.icons.icTicket.svg(color: LemonColor.white.withOpacity(0.7)),
                        // SizedBox(width: Spacing.medium),
                        // Assets.icons.icPoll.svg(color: LemonColor.white.withOpacity(0.7)),
                        // SizedBox(width: Spacing.medium),
                        ThemeSvgIcon(
                          color: colorScheme.onSurface,
                          builder: (filter) => Assets.icons.icCamera.svg(colorFilter: filter),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: LemonOutlineButton(
                      leading: Assets.icons.icPublic.svg(),
                      label: t.post.public,
                      padding: EdgeInsets.symmetric(
                        vertical: Spacing.superExtraSmall,
                        horizontal: Spacing.small,
                      ),
                      radius: BorderRadius.circular(32),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Spacing.small),
          ],
        ),
      ),
    );
  }
}
