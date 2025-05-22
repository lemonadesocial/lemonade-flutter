import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/app_theme/app_theme.dart';

class EventVirtualLinkSettingPage extends StatefulWidget {
  final String? defaultUrl;
  final Function(String link)? onConfirm;
  const EventVirtualLinkSettingPage({
    super.key,
    this.defaultUrl,
    this.onConfirm,
  });

  @override
  State<EventVirtualLinkSettingPage> createState() =>
      _EventVirtualLinkSettingPageState();
}

class _EventVirtualLinkSettingPageState
    extends State<EventVirtualLinkSettingPage> {
  final editingController = TextEditingController();
  bool isEmpty = false;
  @override
  void initState() {
    super.initState();
    if (widget.defaultUrl != null) {
      editingController.text = widget.defaultUrl ?? "";
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
    final appColors = context.theme.appColors;

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom != 0
            ? MediaQuery.of(context).viewInsets.bottom + Spacing.smMedium
            : 0,
      ),
      color: appColors.pageBg,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const BottomSheetGrabber(),
          LemonAppBar(
            backgroundColor: appColors.pageBg,
            onPressBack: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.event.virtualLinkSetting.addVirtualLink,
                  style: Typo.extraLarge.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                    fontFamily: FontFamily.clashDisplay,
                  ),
                ),
                SizedBox(height: Spacing.superExtraSmall),
                Text(
                  t.event.virtualLinkSetting.addVirtualLinkDescription,
                  style: Typo.mediumPlus.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
                SizedBox(height: Spacing.large),
                LemonTextField(
                  controller: editingController,
                  hintText: t.event.virtualLinkSetting.enterLink,
                  suffixIcon: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!isEmpty)
                        InkWell(
                          onTap: () {
                            editingController.clear();
                          },
                          child: Assets.icons.icClose.svg(
                            color: colorScheme.onSecondary,
                          ),
                        )
                      else
                        Container(
                          margin: EdgeInsets.only(right: Spacing.xSmall),
                          width: Sizing.xLarge,
                          child: LemonOutlineButton(
                            borderColor: LemonColor.chineseBlack,
                            backgroundColor: LemonColor.chineseBlack,
                            radius: BorderRadius.circular(LemonRadius.button),
                            label: t.common.actions.patse,
                            onTap: () {
                              Clipboard.getData('text/plain').then((value) {
                                editingController.text = value?.text ?? "";
                              });
                            },
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: Spacing.large),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
              child: LinearGradientButton.primaryButton(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  widget.onConfirm?.call(editingController.text);
                },
                label: t.common.confirm,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
