import 'package:app/core/application/farcaster/create_farcaster_cast_bloc/create_farcaster_cast_bloc.dart';
import 'package:app/core/config.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/farcaster/farcaster_repository.dart';
import 'package:app/core/presentation/pages/farcaster/create_farcaster_cast_page/widgets/create_cast_bottom_bar/create_cast_bottom_bar.dart';
import 'package:app/core/presentation/pages/farcaster/create_farcaster_cast_page/widgets/create_cast_bottom_bar/create_farcaster_editor.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/farcaster/mutation/create_cast.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class CreateFarcasterCastPage extends StatelessWidget {
  final Event event;
  const CreateFarcasterCastPage({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateFarcasterCastBloc(),
      child: CreateFarcasterCastPageView(event: event),
    );
  }
}

class CreateFarcasterCastPageView extends StatefulWidget {
  final Event event;
  const CreateFarcasterCastPageView({
    super.key,
    required this.event,
  });

  @override
  State<CreateFarcasterCastPageView> createState() =>
      _CreateFarcasterCastPageViewState();
}

class _CreateFarcasterCastPageViewState
    extends State<CreateFarcasterCastPageView> {
  Future<void> submitCreateCast() async {
    final t = Translations.of(context);
    final payload = context.read<CreateFarcasterCastBloc>().state.payload;
    final mentions = payload.mentions.map((item) => item.fid).toList();
    final mentionsPositions =
        payload.mentions.map((item) => item.position).toList();
    final response = await showFutureLoadingDialog(
      context: context,
      future: () async {
        return await getIt<FarcasterRepository>().createCast(
          input: Variables$Mutation$CreateCast(
            text: payload.messageWithoutMentions,
            parentUrl: payload.selectedChannel?.url,
            embeds: [
              '${AppConfig.webUrl}/event/${widget.event.id}',
            ],
            mentions: mentions,
            mentionsPositions: mentionsPositions,
          ),
        );
      },
    );
    response.result?.fold((l) {
      return null;
    }, (success) {
      if (success) {
        SnackBarUtils.showSuccess(
          message: t.farcaster.castCreatedSuccess,
        );
        AutoRouter.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthUtils.getUser(context);
    return Scaffold(
      appBar: const LemonAppBar(),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Column(
          children: [
            SizedBox(height: Spacing.medium),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LemonNetworkImage(
                            imageUrl: user?.imageAvatar ?? '',
                            width: Sizing.large,
                            height: Sizing.large,
                            borderRadius: BorderRadius.circular(Sizing.large),
                            placeholder: ImagePlaceholder.defaultPlaceholder(),
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: Spacing.medium),
                        child: const SizedBox(
                          child: CreateFarcasterEditor(),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: _FarcasterEventThumbnail(event: widget.event),
                    ),
                  ],
                ),
              ),
            ),
            CreateCastBottomBar(
              onSubmit: () {
                submitCreateCast();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FarcasterEventThumbnail extends StatelessWidget {
  final Event event;
  const _FarcasterEventThumbnail({
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(LemonRadius.xSmall),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LemonRadius.xSmall),
          border: Border.all(color: colorScheme.outline),
        ),
        child: Column(
          children: [
            LemonNetworkImage(
              width: double.infinity,
              height: 180.w,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(LemonRadius.xSmall),
                topLeft: Radius.circular(LemonRadius.xSmall),
              ),
              imageUrl: "${AppConfig.webUrl}/api/og/event?id=${event.id ?? ''}",
              placeholder: ImagePlaceholder.eventCard(),
            ),
            Container(
              padding: EdgeInsets.all(Spacing.superExtraSmall),
              decoration: BoxDecoration(
                color: LemonColor.atomicBlack,
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
    );
  }
}
