import 'dart:io';

import 'package:app/core/application/profile/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/utils/permission_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final theme = Theme.of(context);
    final profilePhotos = (user?.newPhotosExpanded ?? [])
        .map((item) => item.id)
        .whereType<String>()
        .toList();

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
          // Edit button (only show if not loading)
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: () async {
                final hasPermission =
                    await PermissionUtils.checkPhotosPermission(context);
                if (!hasPermission) return;
                context.read<EditProfileBloc>().add(
                      EditProfileEvent.selectProfileImage(
                        profilePhotos: profilePhotos,
                      ),
                    );
              },
              child: Container(
                width: Sizing.s9,
                height: Sizing.s9,
                padding: EdgeInsets.all(Spacing.s2_5),
                decoration: BoxDecoration(
                  color: LemonColor.greyBg,
                  shape: BoxShape.circle,
                ),
                child:
                    Assets.icons.icEdit.svg(color: theme.colorScheme.onPrimary),
              ),
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
