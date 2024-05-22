import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/farcaster/entities/farcaster_channel.dart';
import 'package:app/core/domain/farcaster/farcaster_repository.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FarcasterChannelsList extends StatelessWidget {
  const FarcasterChannelsList({super.key});

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
    final loggedInUser = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user,
        );

    if (loggedInUser == null) {
      return const SizedBox.shrink();
    }

    if (loggedInUser.farcasterUserInfo?.accountKeyRequest?.accepted != true) {
      return const SizedBox.shrink();
    }

    return FutureBuilder<List<FarcasterChannel>>(
      future: getFarcasterChannels(user: loggedInUser).then(
        (either) => either.fold(
          (failure) => [],
          (channels) => channels,
        ),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.hasError) {
          return const SizedBox.shrink();
        }

        List<FarcasterChannel> channels = snapshot.data ?? [];

        return SizedBox(
          height: 87.w,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) =>
                SizedBox(width: Spacing.small),
            itemCount: channels.length,
            itemBuilder: (context, index) {
              FarcasterChannel channel = channels[index];
              return InkWell(
                onTap: () {
                  AutoRouter.of(context).push(
                    FarcasterChannelNewsfeedRoute(
                      channel: channel,
                    ),
                  );
                },
                child: _FarcasterChannelItem(
                  channel: channel,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _FarcasterChannelItem extends StatelessWidget {
  final FarcasterChannel channel;
  const _FarcasterChannelItem({
    required this.channel,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: 68.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                width: 64.w,
                height: 64.w,
                padding: EdgeInsets.all(2.w),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 2.w,
                      color: LemonColor.paleViolet,
                    ),
                    borderRadius: BorderRadius.circular(64.r),
                  ),
                ),
                child: LemonNetworkImage(
                  imageUrl: channel.imageUrl ?? '',
                  width: 60.w,
                  height: 60.w,
                  borderRadius: BorderRadius.circular(60.w),
                  placeholder: ImagePlaceholder.defaultPlaceholder(),
                ),
              ),
            ],
          ),
          SizedBox(height: Spacing.superExtraSmall),
          Text(
            channel.name ?? '',
            textAlign: TextAlign.center,
            style: Typo.xSmall.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
