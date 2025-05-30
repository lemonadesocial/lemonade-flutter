import 'dart:io';

import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileAvatar extends StatelessWidget {
  final User? user;
  final String? imageUrl;
  final XFile? imageFile;

  const EditProfileAvatar({
    super.key,
    this.user,
    this.imageUrl,
    this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    Widget avatarContent;
    if (imageFile != null) {
      avatarContent = Image.file(
        File(imageFile!.path),
        fit: BoxFit.cover,
        width: 120.w,
        height: 120.w,
      );
    } else if (imageUrl != null) {
      avatarContent = CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: BoxFit.cover,
        width: 120.w,
        height: 120.w,
        placeholder: (_, __) => _buildPlaceholder(),
        errorWidget: (_, __, ___) => _buildPlaceholder(),
      );
    } else {
      avatarContent = _buildPlaceholder();
    }

    return SizedBox(
      width: 120.w,
      height: 120.w,
      child: Stack(
        children: [
          ClipOval(
            child: SizedBox(
              width: 120.w,
              height: 120.w,
              child: avatarContent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    // Ensures the placeholder fills the circle
    return SizedBox(
      width: 120.w,
      height: 120.w,
      child: FittedBox(
        fit: BoxFit.cover,
        child: ImagePlaceholder.avatarPlaceholder(
          userId: user?.userId ?? '',
        ),
      ),
    );
  }
}
