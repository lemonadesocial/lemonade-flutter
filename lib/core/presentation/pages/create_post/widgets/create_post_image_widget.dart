import 'dart:io';

import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:app/gen/assets.gen.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';

class CreatePostImageWidget extends StatelessWidget {
  const CreatePostImageWidget({
    Key? key,
    required this.imageFile,
    required this.onDismiss,
  }) : super(key: key);

  final XFile imageFile;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          clipBehavior: Clip.hardEdge,
          child: Image.file(
            File(imageFile.path),
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          top: 9,
          left: 9,
          child: InkWell(
            onTap: onDismiss,
            child: Container(
              padding: EdgeInsets.all(Spacing.extraSmall),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: colorScheme.outline),
              ),
              child: ThemeSvgIcon(
                color: colorScheme.onSurface,
                builder: (filter) =>
                    Assets.icons.icClose.svg(colorFilter: filter),
              ),
            ),
          ),
        )
      ],
    );
  }
}
