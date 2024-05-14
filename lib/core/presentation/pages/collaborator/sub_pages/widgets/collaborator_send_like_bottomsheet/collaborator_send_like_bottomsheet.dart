import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_expertise_offering_card.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/widgets/collaborator_user_bottomsheet_header/collaborator_user_bottomsheet_header.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class CollaboratorSendLikeBottomSheet extends StatefulWidget {
  final User? user;
  final Function(String? message)? onPressSendLike;

  const CollaboratorSendLikeBottomSheet({
    super.key,
    required this.user,
    this.onPressSendLike,
  });

  @override
  State<CollaboratorSendLikeBottomSheet> createState() =>
      _CollaboratorSendLikeBottomSheetState();
}

class _CollaboratorSendLikeBottomSheetState
    extends State<CollaboratorSendLikeBottomSheet> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      color: colorScheme.surface,
      child: SingleChildScrollView(
        child: Column(
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
                children: [
                  CollaboratorUserBottomsheetHeader(
                    icon: Assets.icons.icShiningLove.svg(),
                    user: widget.user,
                  ),
                  SizedBox(height: Spacing.smMedium),
                  if (widget.user?.expertise?.isNotEmpty == true ||
                      widget.user?.serviceOffersExpanded?.isNotEmpty ==
                          true) ...[
                    CollaboratorDiscoverExpertiseOfferingCard(
                      user: widget.user,
                      backgroundColor: LemonColor.charlestonGreen,
                    ),
                    SizedBox(height: Spacing.smMedium),
                  ],
                  LemonTextField(
                    controller: _textController,
                    hintText: t.collaborator.sendMessage,
                    onChange: (value) {
                      _textController.text = value;
                      // _message = value;
                    },
                  ),
                ],
              ),
            ),
            SafeArea(
              child: Container(
                padding: EdgeInsets.all(Spacing.smMedium),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: colorScheme.outline,
                    ),
                  ),
                ),
                child: LinearGradientButton.primaryButton(
                  onTap: () {
                    widget.onPressSendLike?.call(_textController.text);
                  },
                  label: t.collaborator.sendLike,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
