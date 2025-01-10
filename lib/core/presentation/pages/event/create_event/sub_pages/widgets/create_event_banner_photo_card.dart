import 'dart:io';

import 'package:app/core/application/event/create_event_bloc/create_event_bloc.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/service/file/file_upload_service.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/color.dart';
import 'package:image_picker/image_picker.dart';

class CreateEventBannerPhotoCard extends StatefulWidget {
  final FileUploadService _uploadService;
  final String? thumbnailUrl;
  final Function()? onTapAddPhoto;

  CreateEventBannerPhotoCard({
    super.key,
    this.thumbnailUrl,
    this.onTapAddPhoto,
  }) : _uploadService = FileUploadService(getIt<AppGQL>().client);

  @override
  State<CreateEventBannerPhotoCard> createState() =>
      _CreateEventBannerPhotoCardState();
}

class _CreateEventBannerPhotoCardState
    extends State<CreateEventBannerPhotoCard> {
  final _imagePicker = ImagePicker();
  String? _localImagePath;

  Future<String?> _pickAndUploadImage() async {
    final localImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (localImage == null) {
      return null;
    }
    setState(() {
      _localImagePath = localImage.path;
    });
    final imageId = await widget._uploadService
        .uploadSingleFile(localImage, FileDirectory.event);
    return imageId;
  }

  Future<void> _addPhotoToEvent() async {
    if (widget.onTapAddPhoto != null) {
      widget.onTapAddPhoto?.call();
      return;
    }
    final imageId = await _pickAndUploadImage();
    if (imageId == null) {
      return;
    }
    context.read<CreateEventBloc>().add(
          CreateEventEvent.createEventPhotoImageIdChanged(
            photoImageId: imageId,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () async {
        await showFutureLoadingDialog(
          context: context,
          future: _addPhotoToEvent,
        );
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1.w,
                color: LemonColor.white06,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          child: Stack(
            children: [
              if (_localImagePath != null)
                Image.file(
                  File(_localImagePath!),
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                )
              else if (widget.thumbnailUrl != null)
                Image.network(
                  widget.thumbnailUrl!,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      ImagePlaceholder.eventCard(),
                )
              else
                ImagePlaceholder.eventCard(),
              Positioned(
                right: Spacing.small,
                bottom: Spacing.small,
                child: Container(
                  padding: EdgeInsets.all(Sizing.xxSmall),
                  decoration: ShapeDecoration(
                    color: LemonColor.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(LemonRadius.normal),
                    ),
                  ),
                  child: ThemeSvgIcon(
                    color: colorScheme.surfaceVariant,
                    builder: (filter) => Assets.icons.icUpload.svg(
                      width: Sizing.xSmall,
                      height: Sizing.xSmall,
                      colorFilter: filter,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
