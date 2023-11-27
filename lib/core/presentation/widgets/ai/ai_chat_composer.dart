import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AIChatComposer extends StatelessWidget {
  const AIChatComposer({
    super.key,
    this.loading,
    required this.inputString,
    required this.onSend,
    required this.onChanged,
    required this.textController,
  });
  final String inputString;
  final bool? loading;
  final TextEditingController textController;
  final Function(String? text) onSend;
  final Function(String text) onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).cardColor),
      child: Container(
        decoration: BoxDecoration(
          color: LemonColor.atomicBlack,
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
            SizedBox(
              width: 6.w,
            ),
            Expanded(
              child: TextField(
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
                    color: colorScheme.onPrimary.withOpacity(0.18),
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
          ],
        ),
      ),
    );
  }

  Widget _buildSendbutton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    Widget icon = inputString == ''
        ? ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (filter) => Assets.icons.icMic.svg(
              colorFilter: filter,
            ),
          )
        : IconButton(
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
              child: const SizedBox(
                height: 24,
                width: 24,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Transform.scale(scale: 0.35, child: icon),
    );
  }
}
