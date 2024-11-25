import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';

class EventCustomInstructionsSettingPage extends StatefulWidget {
  final String? instruction;
  final Function(String instruction)? onConfirm;
  const EventCustomInstructionsSettingPage({
    super.key,
    this.instruction,
    this.onConfirm,
  });

  @override
  State<EventCustomInstructionsSettingPage> createState() =>
      _EventCustomInstructionsSettingPageState();
}

class _EventCustomInstructionsSettingPageState
    extends State<EventCustomInstructionsSettingPage> {
  final editingController = TextEditingController();
  bool isEmpty = false;
  @override
  void initState() {
    super.initState();
    if (widget.instruction != null) {
      editingController.text = widget.instruction ?? "";
    }
    isEmpty = editingController.text.isEmpty;
    editingController.addListener(_onChange);
  }

  @override
  void dispose() {
    editingController.removeListener(_onChange);
    super.dispose();
  }

  void _onChange() {
    setState(() {
      isEmpty = editingController.text.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final bool isEditing = widget.instruction?.isNotEmpty ?? false;
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom != 0
            ? MediaQuery.of(context).viewInsets.bottom + Spacing.smMedium
            : 0,
      ),
      color: LemonColor.chineseBlack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const BottomSheetGrabber(),
          LemonAppBar(
            backgroundColor: LemonColor.chineseBlack,
            title: isEditing
                ? t.event.instructions.editInstructions
                : t.event.instructions.addInstructions,
            onPressBack: () => Navigator.of(context, rootNavigator: true).pop(),
            actions: isEditing
                ? [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                      child: InkWell(
                        onTap: () {
                          editingController.clear();
                          _onChange();
                          widget.onConfirm?.call("");
                          AutoRouter.of(context).pop();
                        },
                        child: ThemeSvgIcon(
                          color: LemonColor.coralReef,
                          builder: (filter) => Assets.icons.icDelete.svg(
                            colorFilter: filter,
                            width: Sizing.small,
                            height: Sizing.small,
                          ),
                        ),
                      ),
                    ),
                  ]
                : [],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LemonTextField(
                  controller: editingController,
                  hintText: t.event.instructions.addInstructionsDescription,
                  maxLines: 10,
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: Spacing.xSmall,
                right: Spacing.xSmall,
                top: Spacing.small,
                bottom: Spacing.extraSmall,
              ),
              child: Opacity(
                opacity: isEmpty ? 0.5 : 1,
                child: LinearGradientButton.secondaryButton(
                  onTap: isEmpty
                      ? null
                      : () {
                          Navigator.of(context, rootNavigator: true).pop();
                          widget.onConfirm?.call(editingController.text);
                        },
                  label: t.common.actions.add,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
