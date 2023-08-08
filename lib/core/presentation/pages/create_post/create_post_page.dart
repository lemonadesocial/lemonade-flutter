import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../../i18n/i18n.g.dart';

@RoutePage()
class CreatePostPage extends StatelessWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textCtrl = TextEditingController();
    final t = Translations.of(context);
    return Scaffold(
      backgroundColor: LemonColor.black,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: [
          InkWell(
            onTap: textCtrl.text.isEmpty ? null : () {},
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Spacing.smMedium,
                    vertical: Spacing.superExtraSmall,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: LemonColor.lavender,
                  ),
                  child: Text(
                    'Post',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
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
            Divider(color: LemonColor.white.withOpacity(0.7)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                child: TextFormField(
                  controller: textCtrl,
                  maxLines: 10,
                  cursorColor: LemonColor.white,
                  decoration: InputDecoration.collapsed(hintText: t.home.whatOnYourMind),
                ),
              ),
            ),
            Divider(color: LemonColor.white.withOpacity(0.7)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
              child: Row(
                children: [
                  Assets.icons.icHouseParty.svg(color: LemonColor.white.withOpacity(0.7)),
                  SizedBox(width: Spacing.medium),
                  Assets.icons.icCrystal.svg(color: LemonColor.white.withOpacity(0.7)),
                  SizedBox(width: Spacing.medium),
                  Assets.icons.icTicket.svg(color: LemonColor.white.withOpacity(0.7)),
                  SizedBox(width: Spacing.medium),
                  Assets.icons.icPoll.svg(color: LemonColor.white.withOpacity(0.7)),
                  SizedBox(width: Spacing.medium),
                  Assets.icons.icCamera.svg(color: LemonColor.white.withOpacity(0.7)),
                  SizedBox(width: Spacing.medium),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: LemonColor.black,
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: LemonColor.white.withOpacity(0.7),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: Spacing.superExtraSmall,
                        horizontal: Spacing.small,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.icons.icPublic.svg(),
                          SizedBox(width: Spacing.superExtraSmall),
                          Text('Public'),
                        ],
                      ),
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
