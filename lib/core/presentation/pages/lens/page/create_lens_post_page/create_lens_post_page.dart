import 'dart:io';

import 'package:app/core/application/lens/create_lens_post_bloc/create_lens_post_bloc.dart';
import 'package:app/core/config.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/lens/entities/lens_create_post_metadata.dart';
import 'package:app/core/domain/lens/lens_repository.dart';
import 'package:app/core/presentation/pages/lens/page/create_lens_post_page/widgets/create_lens_post_bottom_bar.dart';
import 'package:app/core/presentation/pages/lens/page/create_lens_post_page/widgets/create_lens_post_editor.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/service/file/file_upload_service.dart';
import 'package:app/core/service/lens/lens_grove_service/lens_grove_service.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

@RoutePage()
class CreateLensPostPage extends StatelessWidget {
  const CreateLensPostPage({
    super.key,
    this.lensFeedId,
  });

  final String? lensFeedId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateLensPostBloc(
        getIt<LensRepository>(),
        getIt<LensGroveService>(),
      ),
      child: CreateLensPostPageView(lensFeedId: lensFeedId),
    );
  }
}

class CreateLensPostPageView extends StatefulWidget {
  const CreateLensPostPageView({
    super.key,
    this.lensFeedId,
  });

  final String? lensFeedId;

  @override
  State<CreateLensPostPageView> createState() => _CreateLensPostPageViewState();
}

class _CreateLensPostPageViewState extends State<CreateLensPostPageView> {
  final _editorController = TextEditingController();
  Event? selectedEvent;
  XFile? selectedImage;
  bool uploadingImage = false;
  String? mimeType;

  Future<void> submitCreatePost() async {
    String? imageUrl;

    if (selectedImage != null) {
      imageUrl = await uploadImage();
    }
    context.read<CreateLensPostBloc>().add(
          CreateLensPostEvent.createPost(
            content: _editorController.text,
            lensFeedId: widget.lensFeedId,
            image: imageUrl != null
                ? LensMediaImageMetadata(
                    type: mimeType ?? "image/png",
                    item: imageUrl,
                  )
                : null,
            event: selectedEvent,
          ),
        );
  }

  void onEventSelected(Event event) {
    setState(() {
      selectedEvent = event;
      selectedImage = null;
    });
  }

  void onEventRemoved() {
    setState(() {
      selectedEvent = null;
    });
  }

  void onImagePick(XFile image) async {
    setState(() {
      mimeType = lookupMimeType(image.path);
      selectedImage = image;
      selectedEvent = null;
    });
  }

  Future<String?> uploadImage() async {
    setState(() {
      uploadingImage = true;
    });
    final client = getIt<AppGQL>().client;
    final fileUploadService = FileUploadService(client);
    DbFile? dbFile = await fileUploadService.uploadFile(
      selectedImage,
      FileDirectory.post,
    );
    if (dbFile != null) {
      final imageUrl = ImageUtils.generateUrl(file: dbFile);
      setState(() {
        uploadingImage = false;
      });
      return imageUrl;
    }
    setState(() {
      uploadingImage = false;
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateLensPostBloc, CreateLensPostState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          success: (txHash) {
            SnackBarUtils.showSuccess(message: 'Post successfully created!');
            AutoRouter.of(context).pop(true);
          },
          failed: (failure) {
            SnackBarUtils.showError(message: failure.message);
          },
        );
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: const LemonAppBar(),
            body: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                      child: CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: CreateLensPostEditor(
                              onContentChanged: (message) {
                                _editorController.text = message;
                              },
                            ),
                          ),
                          if (selectedEvent != null)
                            SliverToBoxAdapter(
                              child: _LensEventThumbnail(
                                event: selectedEvent!,
                                onEventRemoved: onEventRemoved,
                              ),
                            ),
                          if (selectedImage != null)
                            SliverToBoxAdapter(
                              child: _ImageThumbnail(
                                image: selectedImage!,
                                onImageRemoved: () {
                                  setState(() {
                                    selectedImage = null;
                                  });
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  CreateLensPostBottomBar(
                    controller: _editorController,
                    onSubmit: () {
                      FocusScope.of(context).unfocus();
                      submitCreatePost();
                    },
                    onEventSelected: onEventSelected,
                    onImagePick: onImagePick,
                  ),
                ],
              ),
            ),
          ),
          if (uploadingImage)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Loading.defaultLoading(context),
            ),
          BlocBuilder<CreateLensPostBloc, CreateLensPostState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => const SizedBox.shrink(),
                loading: () => Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Loading.defaultLoading(context),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ImageThumbnail extends StatelessWidget {
  final XFile image;
  final VoidCallback onImageRemoved;
  const _ImageThumbnail({
    required this.image,
    required this.onImageRemoved,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(LemonRadius.md),
          child: Image.file(
            File(image.path),
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
        ),
        Positioned(
          top: Spacing.s2,
          right: Spacing.s2,
          child: Container(
            width: Sizing.s9,
            height: Sizing.s9,
            decoration: ShapeDecoration(
              shape: const CircleBorder(),
              color: appColors.buttonTertiaryBg,
            ),
            child: IconButton(
              onPressed: onImageRemoved,
              icon: ThemeSvgIcon(
                color: appColors.textTertiary,
                builder: (filter) => Assets.icons.icClose.svg(
                  colorFilter: filter,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LensEventThumbnail extends StatelessWidget {
  final Event event;
  final VoidCallback onEventRemoved;
  const _LensEventThumbnail({
    required this.event,
    required this.onEventRemoved,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appColors = context.theme.appColors;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(LemonRadius.md),
            border: Border.all(color: appColors.pageDivider),
          ),
          child: Column(
            children: [
              LemonNetworkImage(
                width: double.infinity,
                height: 180.w,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(LemonRadius.md),
                  topLeft: Radius.circular(LemonRadius.md),
                ),
                imageUrl:
                    "${AppConfig.webUrl}/api/og/event?id=${event.id ?? ''}",
                placeholder: ImagePlaceholder.eventCard(),
              ),
              Container(
                padding: EdgeInsets.all(Spacing.superExtraSmall),
                decoration: BoxDecoration(
                  color: appColors.cardBg,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(LemonRadius.xSmall),
                    bottomLeft: Radius.circular(LemonRadius.xSmall),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: LemonOutlineButton(
                        label: t.farcaster.moreInfo,
                      ),
                    ),
                    SizedBox(
                      width: Spacing.superExtraSmall,
                    ),
                    Expanded(
                      child: LemonOutlineButton(
                        label: t.farcaster.viewEvent,
                        trailing: Assets.icons.icExpand.svg(
                          width: 12.w,
                          height: 12.w,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: Spacing.s2,
          right: Spacing.s2,
          child: Container(
            width: Sizing.s9,
            height: Sizing.s9,
            decoration: ShapeDecoration(
              shape: const CircleBorder(),
              color: appColors.buttonTertiaryBg,
            ),
            child: IconButton(
              onPressed: onEventRemoved,
              icon: ThemeSvgIcon(
                color: appColors.textTertiary,
                builder: (filter) => Assets.icons.icClose.svg(
                  colorFilter: filter,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
