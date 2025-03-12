import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/space/get_space_detail_bloc/get_space_detail_bloc.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/transfer_event_space_page/transfer_event_space_page.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/event/mutation/update_event.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HostEventManageSpaceWidget extends StatefulWidget {
  final String eventId;
  const HostEventManageSpaceWidget({
    super.key,
    required this.eventId,
  });

  @override
  State<HostEventManageSpaceWidget> createState() =>
      _HostEventManageSpaceWidgetState();
}

class _HostEventManageSpaceWidgetState
    extends State<HostEventManageSpaceWidget> {
  Future<void> _updateSpace({
    required String spaceId,
  }) async {
    await showFutureLoadingDialog(
      context: context,
      future: () async {
        final result = await getIt<AppGQL>().client.mutate$UpdateEvent(
              Options$Mutation$UpdateEvent(
                variables: Variables$Mutation$UpdateEvent(
                  id: widget.eventId,
                  input: Input$EventInput(
                    space: spaceId,
                  ),
                ),
              ),
            );
        if (result.parsedData?.updateEvent != null) {
          context.read<GetEventDetailBloc>().add(
                GetEventDetailEvent.fetch(
                  eventId: widget.eventId,
                ),
              );
        }
      },
    );
  }

  Future<void> _updateEventPrivate(bool isPrivate) async {
    await showFutureLoadingDialog(
      context: context,
      future: () async {
        final result = await getIt<AppGQL>().client.mutate$UpdateEvent(
              Options$Mutation$UpdateEvent(
                variables: Variables$Mutation$UpdateEvent(
                  id: widget.eventId,
                  input: Input$EventInput(
                    private: isPrivate,
                  ),
                ),
              ),
            );
        if (result.parsedData?.updateEvent != null) {
          context.read<GetEventDetailBloc>().add(
                GetEventDetailEvent.fetch(
                  eventId: widget.eventId,
                ),
              );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return BlocListener<GetEventDetailBloc, GetEventDetailState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          fetched: (event) {
            if (event.space?.isNotEmpty == true) {
              context
                  .read<GetSpaceDetailBloc>()
                  .add(GetSpaceDetailEvent.fetch(spaceId: event.space!));
            }
          },
        );
      },
      child: BlocBuilder<GetSpaceDetailBloc, GetSpaceDetailState>(
        builder: (context, state) {
          final space = state.maybeWhen(
            orElse: () => null,
            success: (space) => space,
          );

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: LemonColor.atomicBlack,
                  borderRadius: BorderRadius.circular(LemonRadius.medium),
                  border: Border.all(
                    color: colorScheme.outlineVariant,
                  ),
                ),
                padding: EdgeInsets.all(Spacing.small),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LemonNetworkImage(
                      imageUrl: space?.imageAvatar?.url ?? "",
                      width: Sizing.medium,
                      height: Sizing.medium,
                      borderRadius:
                          BorderRadius.circular(LemonRadius.extraSmall),
                      placeholder: ImagePlaceholder.spaceThumbnail(),
                    ),
                    SizedBox(width: Spacing.small),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.space.managingCommunity,
                          style: Typo.medium.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        ),
                        Text(
                          space?.title ?? "",
                          style: Typo.mediumPlus.copyWith(
                            color: colorScheme.onPrimary,
                          ),
                        ),
                        SizedBox(height: Spacing.xSmall),
                        Row(
                          children: [
                            BlocBuilder<GetEventDetailBloc,
                                GetEventDetailState>(
                              builder: (context, state) {
                                return _ToggleVisibilityButton(
                                  isPrivate: state.maybeWhen(
                                    orElse: () => false,
                                    fetched: (event) => event.private ?? false,
                                  ),
                                  onChanged: (value) {
                                    _updateEventPrivate(value);
                                  },
                                );
                              },
                            ),
                            SizedBox(width: Spacing.extraSmall),
                            LemonOutlineButton(
                              onTap: () async {
                                if (space?.id != null) {
                                  final newSpaceId =
                                      await TransferEventSpacePage.show(
                                    context,
                                    spaceId: space?.id ?? "",
                                  );
                                  if (newSpaceId != null &&
                                      newSpaceId != space?.id) {
                                    _updateSpace(spaceId: newSpaceId);
                                  }
                                }
                              },
                              label: t.space.transferEventSpace.transfer,
                              textColor: colorScheme.onPrimary,
                              backgroundColor: LemonColor.chineseBlack,
                              leading: ThemeSvgIcon(
                                color: colorScheme.onSecondary,
                                builder: (colorFilter) =>
                                    Assets.icons.icTransfer.svg(
                                  colorFilter: colorFilter,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: Spacing.xSmall),
              Row(
                children: [
                  ThemeSvgIcon(
                    color: colorScheme.onSecondary,
                    builder: (colorFilter) => Assets.icons.icInfo.svg(
                      colorFilter: colorFilter,
                      width: 16.w,
                      height: 16.w,
                    ),
                  ),
                  SizedBox(width: Spacing.xSmall),
                  Expanded(
                    child: Text(
                      t.space.toBeFeatured,
                      style: Typo.small.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ToggleVisibilityButton extends StatefulWidget {
  const _ToggleVisibilityButton({
    required this.isPrivate,
    required this.onChanged,
  });

  final bool isPrivate;
  final void Function(bool) onChanged;

  @override
  State<_ToggleVisibilityButton> createState() =>
      _ToggleVisibilityButtonState();
}

class _ToggleVisibilityButtonState extends State<_ToggleVisibilityButton> {
  bool isPrivate = false;

  @override
  void initState() {
    super.initState();
    isPrivate = widget.isPrivate;
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final items = [
      DropdownMenuItem<bool>(
        value: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (colorFilter) => Assets.icons.icPublic.svg(
                colorFilter: colorFilter,
                width: 18.w,
                height: 18.w,
              ),
            ),
            SizedBox(width: Spacing.small),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.space.manageSpace.public,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  Text(
                    t.space.manageSpace.publicDescription,
                    style: Typo.small.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (!isPrivate)
              ThemeSvgIcon(
                color: colorScheme.onPrimary,
                builder: (colorFilter) => Assets.icons.icDone.svg(
                  colorFilter: colorFilter,
                ),
              ),
          ],
        ),
      ),
      DropdownMenuItem<bool>(
        value: true,
        child: Container(
          padding: EdgeInsets.only(
            top: Spacing.xSmall,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (colorFilter) => Assets.icons.icPrivate.svg(
                  colorFilter: colorFilter,
                  width: 18.w,
                  height: 18.w,
                ),
              ),
              SizedBox(width: Spacing.small),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.space.manageSpace.private,
                      style: Typo.medium.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                    ),
                    Text(
                      t.space.manageSpace.privateDescription,
                      style: Typo.small.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (isPrivate)
                ThemeSvgIcon(
                  color: colorScheme.onPrimary,
                  builder: (colorFilter) => Assets.icons.icDone.svg(
                    colorFilter: colorFilter,
                  ),
                ),
            ],
          ),
        ),
      ),
    ];

    return DropdownButtonHideUnderline(
      child: DropdownButton2<bool>(
        items: items,
        customButton: LemonOutlineButton(
          onTap: null,
          label: isPrivate
              ? t.space.manageSpace.private
              : t.space.manageSpace.public,
          textColor: colorScheme.onPrimary,
          backgroundColor: LemonColor.chineseBlack,
          leading: ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (colorFilter) => isPrivate
                ? Assets.icons.icPrivate.svg(
                    colorFilter: colorFilter,
                    width: 16.w,
                    height: 16.w,
                  )
                : Assets.icons.icPublic.svg(
                    colorFilter: colorFilter,
                    width: 16.w,
                    height: 16.w,
                  ),
          ),
          trailing: ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (colorFilter) => Assets.icons.icDoubleArrowUpDown.svg(
              colorFilter: colorFilter,
              width: 16.w,
              height: 16.w,
            ),
          ),
        ),
        value: widget.isPrivate,
        onChanged: (value) {
          if (value == isPrivate) {
            return;
          }
          setState(() {
            isPrivate = value ?? false;
          });
          widget.onChanged(value ?? false);
        },
        dropdownStyleData: DropdownStyleData(
          padding: EdgeInsets.symmetric(
            vertical: Spacing.xSmall,
          ),
          offset: const Offset(0, 170),
          width: 320.w,
          decoration: BoxDecoration(
            color: LemonColor.atomicBlack,
            borderRadius: BorderRadius.circular(LemonRadius.small),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          height: 60.w,
        ),
      ),
    );
  }
}
