// ignore_for_file: must_be_immutable

import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_photos_setting_page/widgets/cover_photo_item.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_photos_setting_page/widgets/upload_photo_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/service/file/file_upload_service.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app/core/utils/permission_utils.dart';

@RoutePage()
class EventPhotosSettingPage extends StatelessWidget {
  const EventPhotosSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final event = context.watch<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => null,
          fetched: (event) => event,
        );
    return EventPhotosSettingPageView(
      event: event,
    );
  }
}

class EventPhotosSettingPageView extends StatefulWidget {
  late FileUploadService _uploadService;
  final Event? event;

  EventPhotosSettingPageView({
    super.key,
    this.event,
  }) {
    final gqlClient = getIt<AppGQL>().client;
    _uploadService = FileUploadService(gqlClient);
  }

  @override
  State<EventPhotosSettingPageView> createState() =>
      _EventPhotosSettingPageViewState();
}

class _EventPhotosSettingPageViewState
    extends State<EventPhotosSettingPageView> {
  final _imagePicker = ImagePicker();

  List<String> get eventPhotos {
    return widget.event?.newNewPhotos ?? [];
  }

  Future<String?> _pickAndUploadImage() async {
    final hasPermission = await PermissionUtils.checkPhotosPermission(context);
    if (!hasPermission) {
      return null;
    }
    final localImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (localImage == null) {
      return null;
    }
    return await widget._uploadService
        .uploadSingleFile(localImage, FileDirectory.event);
  }

  Future<void> _addPhotoToEvent() async {
    final imageId = await _pickAndUploadImage();
    if (imageId == null) {
      return;
    }
    await _saveEventPhotos(
      [...eventPhotos, imageId],
    );
  }

  Future<void> _editCover() async {
    final imageId = await _pickAndUploadImage();
    if (imageId == null) {
      return;
    }
    await _saveEventPhotos(
      [imageId, ...eventPhotos],
    );
  }

  Future<void> _setPhotoAsCover(String imageId) async {
    final newPhotos = eventPhotos
        .where((element) => element != imageId)
        .toList()
      ..insert(0, imageId);
    await _saveEventPhotos(newPhotos);
  }

  Future<void> _deletePhoto(String imageId) async {
    final newPhotos =
        eventPhotos.where((element) => element != imageId).toList();
    await _saveEventPhotos(newPhotos);
  }

  Future<void> _saveEventPhotos(List<String> newPhotos) async {
    final result = await getIt<EventRepository>().updateEvent(
      input: Input$EventInput(
        new_new_photos: newPhotos,
      ),
      id: widget.event?.id ?? '',
    );
    result.fold((l) => null, (r) {
      context.read<GetEventDetailBloc>().add(
            GetEventDetailEvent.fetch(eventId: widget.event?.id ?? ''),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final eventPhotos = (widget.event?.newNewPhotosExpanded ?? [])
        .where((element) => element != null)
        .cast<DbFile>()
        .toList();
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: LemonAppBar(
        title: StringUtils.capitalize(
          t.common.photo(n: 2),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: CoverPhotoItem(
                    photo: eventPhotos.isNotEmpty ? eventPhotos.first : null,
                    onEdit: () async {
                      await showFutureLoadingDialog(
                        context: context,
                        future: _editCover,
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: Spacing.large),
                ),
                if (eventPhotos.isNotEmpty)
                  SliverGrid.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      mainAxisSpacing: Spacing.xSmall,
                      crossAxisSpacing: Spacing.xSmall,
                    ),
                    itemCount: eventPhotos.length,
                    itemBuilder: (context, index) {
                      return UploadPhotoItem(
                        photo: eventPhotos[index],
                        index: index,
                        onSetAsCover: (imageId) {
                          showFutureLoadingDialog(
                            context: context,
                            future: () => _setPhotoAsCover(imageId),
                          );
                        },
                        onDelete: (imageId) {
                          showFutureLoadingDialog(
                            context: context,
                            future: () => _deletePhoto(imageId),
                          );
                        },
                      );
                    },
                  ),
                SliverToBoxAdapter(
                  child: SizedBox(height: Spacing.xLarge * 3.5),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: colorScheme.outline,
                  ),
                ),
                color: colorScheme.background,
              ),
              padding: EdgeInsets.all(Spacing.smMedium),
              child: SafeArea(
                child: LinearGradientButton.secondaryButton(
                  onTap: () async {
                    await showFutureLoadingDialog(
                      context: context,
                      future: _addPhotoToEvent,
                    );
                  },
                  label: t.event.eventPhotos.addPhoto,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
