import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/farcaster/create_farcaster_cast_bloc/create_farcaster_cast_bloc.dart';
import 'package:app/core/domain/farcaster/entities/farcaster_channel.dart';
import 'package:app/core/domain/farcaster/farcaster_repository.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dartz/dartz.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class SelectFarcasterChannelsDropdown extends StatelessWidget {
  final Function(
    FarcasterChannel? channel,
  )? onChannelSelected;
  const SelectFarcasterChannelsDropdown({
    super.key,
    this.onChannelSelected,
  });

  Future<Either<Failure, List<FarcasterChannel>>> getFarcasterChannels({
    required User? user,
  }) async {
    int? fid = user?.farcasterUserInfo?.fid?.toInt();
    if (fid == null) {
      final connectRequestResult =
          await getIt<FarcasterRepository>().getConnectRequest(
        user?.farcasterUserInfo?.accountKeyRequest?.token ?? '',
      );
      fid = connectRequestResult.fold(
            (l) => 0,
            (request) => request.requestFid,
          ) ??
          0;
    }
    return getIt<FarcasterRepository>().getChannels(fid: fid);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final user = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user,
        );
    final createFarcasterBloc = context.watch<CreateFarcasterCastBloc>();
    final selectedChannel = createFarcasterBloc.state.payload.selectedChannel;

    return FutureBuilder(
      future: getFarcasterChannels(user: user),
      builder: (context, snapshot) {
        List<FarcasterChannel> channels =
            snapshot.data?.fold((l) => [], (channels) => channels) ?? [];
        return DropdownButtonHideUnderline(
          child: DropdownButton2<FarcasterChannel?>(
            value: selectedChannel,
            onChanged: (value) {
              createFarcasterBloc.add(
                CreateFarcasterCastEvent.selectChannel(
                  channel: value,
                ),
              );
            },
            isExpanded: true,
            items: [
              const DropdownMenuItem(
                value: null,
                child: _ChannelDropdownItem(channel: null),
              ),
              ...channels.map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: _ChannelDropdownItem(channel: item),
                ),
              ),
            ],
            customButton: _SelectedIChannel(
              selectedChannel: selectedChannel,
            ),
            dropdownStyleData: DropdownStyleData(
              isFullScreen: true,
              useSafeArea: true,
              useRootNavigator: true,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(LemonRadius.small),
                color: colorScheme.secondaryContainer,
              ),
              offset: Offset(0, 100.w),
              maxHeight: 250.w,
              width: 0.9.sw,
            ),
            menuItemStyleData: MenuItemStyleData(
              height: Sizing.xLarge,
              padding: EdgeInsets.all(Spacing.xSmall),
              overlayColor:
                  const MaterialStatePropertyAll(LemonColor.darkBackground),
            ),
          ),
        );
      },
    );
  }
}

class _ChannelDropdownItem extends StatelessWidget {
  final FarcasterChannel? channel;
  const _ChannelDropdownItem({
    required this.channel,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (channel == null)
          Container(
            width: Sizing.medium,
            height: Sizing.medium,
            decoration: BoxDecoration(
              color: LemonColor.white06,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => Assets.icons.icHome.svg(
                  colorFilter: filter,
                  width: 18.w,
                  height: 18.w,
                ),
              ),
            ),
          ),
        if (channel != null)
          LemonNetworkImage(
            imageUrl: channel?.imageUrl ?? '',
            width: Sizing.medium,
            height: Sizing.medium,
            borderRadius: BorderRadius.circular(Sizing.medium),
            placeholder: ImagePlaceholder.defaultPlaceholder(
              radius: BorderRadius.circular(Sizing.medium),
            ),
          ),
        SizedBox(width: Spacing.xSmall),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              channel?.name ?? t.farcaster.home,
              style: Typo.medium.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
            SizedBox(height: 2.w),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Assets.icons.icGuests.svg(
                  width: 12.w,
                  height: 12.w,
                ),
                SizedBox(width: 3.w),
                if (channel != null)
                  Text(
                    NumberFormat.compact()
                        .format((channel?.followerCount ?? 0).toInt()),
                    style: Typo.small.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _SelectedIChannel extends StatelessWidget {
  final FarcasterChannel? selectedChannel;
  const _SelectedIChannel({
    this.selectedChannel,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.only(
        top: Spacing.superExtraSmall,
        bottom: Spacing.superExtraSmall,
        left: Spacing.superExtraSmall,
        right: Spacing.xSmall,
      ),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        children: [
          if (selectedChannel != null)
            LemonNetworkImage(
              imageUrl: selectedChannel?.imageUrl ?? '',
              width: Sizing.medium,
              height: Sizing.medium,
              borderRadius: BorderRadius.circular(Sizing.medium),
              placeholder: ImagePlaceholder.defaultPlaceholder(
                radius: BorderRadius.circular(Sizing.medium),
              ),
            ),
          if (selectedChannel == null)
            Container(
              width: Sizing.medium,
              height: Sizing.medium,
              decoration: BoxDecoration(
                color: LemonColor.white06,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: ThemeSvgIcon(
                  color: colorScheme.onSecondary,
                  builder: (filter) => Assets.icons.icHome.svg(
                    colorFilter: filter,
                    width: 18.w,
                    height: 18.w,
                  ),
                ),
              ),
            ),
          SizedBox(width: Spacing.extraSmall),
          ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (filter) => Assets.icons.icArrowDown.svg(
              colorFilter: filter,
            ),
          ),
        ],
      ),
    );
  }
}
