import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

const aiChatComposerHeight = 80.0;

class AIChatComposer extends StatelessWidget {
  const AIChatComposer({
    super.key,
    this.loading,
    required this.inputString,
    required this.onSend,
    required this.onChanged,
    required this.textController,
    this.selectedCommand,
    required this.onToggleCommand,
    this.onFocusChange,
  });
  final String inputString;
  final bool? loading;
  final TextEditingController textController;
  final Function(String? text) onSend;
  final Function(String text) onChanged;
  final bool? selectedCommand;
  final Function() onToggleCommand;
  final Function(bool focus)? onFocusChange;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).cardColor),
      child: Container(
        height: aiChatComposerHeight,
        decoration: BoxDecoration(
          color: colorScheme.background,
          border: Border(
            top: BorderSide(
              width: 1.h,
              color: colorScheme.onPrimary.withOpacity(0.06),
            ),
          ),
        ),
        padding:
            EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h, bottom: 12.h),
        child: Row(
          children: [
            InkWell(
              child: Container(
                height: Sizing.small * 2,
                width: Sizing.medium,
                padding: EdgeInsets.symmetric(horizontal: Spacing.extraSmall),
                decoration: BoxDecoration(
                  color: selectedCommand == true
                      ? LemonColor.paleViolet18
                      : LemonColor.white09,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Center(
                  child: ThemeSvgIcon(
                    color: selectedCommand == true
                        ? LemonColor.paleViolet
                        : colorScheme.onSecondary,
                    builder: (filter) => Assets.icons.icCommand.svg(
                      colorFilter: filter,
                      width: Sizing.xSmall,
                      height: Sizing.xSmall,
                    ),
                  ),
                ),
              ),
              onTap: () {
                Vibrate.feedback(FeedbackType.light);
                onToggleCommand();
              },
            ),
            SizedBox(
              width: 6.w,
            ),
            Expanded(
              child: FocusScope(
                child: Focus(
                  onFocusChange: (focus) => onFocusChange!(focus),
                  child: TextField(
                    cursorColor: colorScheme.outline,
                    controller: textController,
                    onSubmitted: (value) => onSend(value),
                    onChanged: onChanged,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: Spacing.extraSmall,
                        horizontal: Spacing.smMedium,
                      ),
                      hintText: 'Enter your prompt here',
                      hintStyle: Typo.medium.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.r),
                        borderSide: BorderSide(
                          color: colorScheme.outline,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: BorderSide(
                          color: colorScheme.outline,
                        ),
                      ),
                      suffixIcon: _buildSendbutton(context),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSendbutton(BuildContext context) {
    Widget icon = IconButton(
      icon: Icon(
        Icons.send_rounded,
        color: LemonColor.babyPurple,
        size: 35.w,
      ),
      onPressed: () => onSend(inputString),
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      child: loading == true
          ? Transform.scale(
              scale: 0.5,
              child: SizedBox(
                height: 50.h,
                width: 50.w,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Transform.scale(
              scale: 0.35,
              child: icon,
            ),
    );
  }
}
