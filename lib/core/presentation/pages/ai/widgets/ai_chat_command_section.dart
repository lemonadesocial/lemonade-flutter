import 'package:app/core/presentation/pages/ai/ai_view_model.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AiChatCommandSection extends StatelessWidget {
  final String sectionLabel;
  final List<AICommandViewModel> commandList;

  const AiChatCommandSection({
    super.key,
    required this.sectionLabel,
    required this.commandList,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          sectionLabel,
          style: Typo.extraMedium.copyWith(
            fontFamily: FontFamily.spaceGrotesk,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        Wrap(
          spacing: 6,
          children: commandList.map((command) {
            return ActionChip(
              label: Text(command.label),
              onPressed: () => _handleChipPress(command.onTap),
              backgroundColor: LemonColor.atomicBlack,
              labelStyle: Typo.small.copyWith(color: colorScheme.onSecondary),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: colorScheme.outline,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(9.0),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _handleChipPress(Function? onPressed) {
    if (onPressed != null) {
      onPressed();
    }
  }
}
