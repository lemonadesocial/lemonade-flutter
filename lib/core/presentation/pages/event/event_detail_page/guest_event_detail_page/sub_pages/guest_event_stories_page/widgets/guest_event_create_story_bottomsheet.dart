import 'dart:io';
import 'package:app/core/application/event/create_event_story_bloc/create_event_story_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/core/utils/permission_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestEventCreateStoryBottomsheet extends StatefulWidget {
  final Function()? onSuccess;
  final Event? event;
  const GuestEventCreateStoryBottomsheet({
    super.key,
    this.onSuccess,
    this.event,
  });

  @override
  State<GuestEventCreateStoryBottomsheet> createState() =>
      _GuestEventCreateStoryBottomsheetState();
}

class _GuestEventCreateStoryBottomsheetState
    extends State<GuestEventCreateStoryBottomsheet> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final currentUser = AuthUtils.getUser(context);

    return BlocListener<CreateEventStoryBloc, CreateEventStoryState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          success: (_) {
            Navigator.of(context, rootNavigator: true).pop();
            widget.onSuccess?.call();
          },
        );
      },
      child: Focus(
        onFocusChange: (focused) {
          setState(() {
            isFocused = focused;
          });
        },
        child: Container(
          height: 1.h,
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          color: LemonColor.atomicBlack,
          child: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: LemonAppBar(
                        onPressBack: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        backgroundColor: LemonColor.atomicBlack,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                        child: SizedBox(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText:
                                  '${t.home.whatOnYourMind}, ${currentUser?.name}?',
                            ),
                            maxLines: null,
                            cursorColor: colorScheme.onSecondary,
                            onChanged: (value) {
                              context.read<CreateEventStoryBloc>().add(
                                    CreateEventStoryEvent.onDescriptionChanged(
                                      description: value,
                                    ),
                                  );
                            },
                          ),
                        ),
                      ),
                    ),
                    BlocBuilder<CreateEventStoryBloc, CreateEventStoryState>(
                      builder: (context, state) {
                        if (state.data.imageFile == null) {
                          return const SliverToBoxAdapter(
                            child: SizedBox.shrink(),
                          );
                        }
                        return SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Spacing.smMedium,
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(LemonRadius.medium),
                              child: Image.file(
                                File(state.data.imageFile!.path),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: Spacing.medium,
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<CreateEventStoryBloc, CreateEventStoryState>(
                builder: (context, state) {
                  return Container(
                    padding: EdgeInsets.only(
                      top: Spacing.xSmall,
                      bottom: isFocused && state.data.imageFile != null
                          ? Spacing.large
                          : Spacing.xSmall,
                      left: Spacing.smMedium,
                      right: Spacing.smMedium,
                    ),
                    decoration: BoxDecoration(
                      color: isFocused
                          ? LemonColor.chineseBlack
                          : LemonColor.atomicBlack,
                    ),
                    child: SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () async {
                              final hasPermission =
                                  await PermissionUtils.checkPhotosPermission(
                                      context);
                              if (!hasPermission) {
                                return;
                              }
                              final file = await getImageFromGallery();
                              if (file == null) {
                                return;
                              }
                              context.read<CreateEventStoryBloc>().add(
                                    CreateEventStoryEvent.onImageFileChanged(
                                      imageFile: file,
                                    ),
                                  );
                            },
                            child: ThemeSvgIcon(
                              color: colorScheme.onPrimary,
                              builder: (colorFilter) =>
                                  Assets.icons.icCamera.svg(
                                colorFilter: colorFilter,
                              ),
                            ),
                          ),
                          Builder(
                            builder: (context) {
                              final isLoading =
                                  state is CreateEventStoryStateLoading;
                              return Opacity(
                                opacity:
                                    state.data.isValid && !isLoading ? 1 : 0.5,
                                child: SizedBox(
                                  width: Sizing.medium * 2,
                                  height: Sizing.medium,
                                  child: LinearGradientButton.primaryButton(
                                    loadingWhen: isLoading,
                                    onTap: () async {
                                      if (!state.data.isValid || isLoading) {
                                        return;
                                      }
                                      context.read<CreateEventStoryBloc>().add(
                                            CreateEventStoryEvent.submit(
                                              eventId: widget.event?.id ?? '',
                                            ),
                                          );
                                    },
                                    textStyle: Typo.small.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: colorScheme.onPrimary,
                                      height: -0.15,
                                    ),
                                    label: t.common.actions.post,
                                    trailing: Assets.icons.icSendMessage.svg(
                                      width: 12.w,
                                      height: 12.w,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
