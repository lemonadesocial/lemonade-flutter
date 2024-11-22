import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class EventAddInstructionsSettingPage extends StatefulWidget {
  final String? instruction;
  final Function(String instruction)? onConfirm;
  const EventAddInstructionsSettingPage({
    super.key,
    this.instruction,
    this.onConfirm,
  });

  @override
  State<EventAddInstructionsSettingPage> createState() =>
      _EventAddInstructionsSettingPageState();
}

class _EventAddInstructionsSettingPageState
    extends State<EventAddInstructionsSettingPage> {
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
    final colorScheme = Theme.of(context).colorScheme;
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
            title: t.event.instructions.addInstructions,
            onPressBack: () => Navigator.of(context, rootNavigator: true).pop(),
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
