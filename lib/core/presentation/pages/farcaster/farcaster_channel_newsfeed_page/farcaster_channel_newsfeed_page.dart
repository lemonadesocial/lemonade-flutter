// create an auto router page widget

import 'package:app/core/domain/farcaster/entities/farcaster_channel.dart';
import 'package:app/core/presentation/pages/farcaster/farcaster_channel_newsfeed_page/widgets/farcaster_cast_item_widget.dart';
import 'package:app/core/presentation/pages/farcaster/farcaster_channel_newsfeed_page/widgets/farcaster_channel_detail_bottomsheet.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/farcaster_airstack/query/get_farcaster_casts.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

@RoutePage()
class FarcasterChannelNewsfeedPage extends StatefulWidget {
  final FarcasterChannel channel;
  const FarcasterChannelNewsfeedPage({
    super.key,
    required this.channel,
  });

  @override
  State<FarcasterChannelNewsfeedPage> createState() =>
      _FarcasterChannelNewsfeedPageState();
}

class _FarcasterChannelNewsfeedPageState
    extends State<FarcasterChannelNewsfeedPage> {
  late ValueNotifier<GraphQLClient> airstackClient;
  @override
  initState() {
    super.initState();
    airstackClient = ValueNotifier(getIt<AirstackGQL>().client);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: LemonAppBar(
        actions: [
          SizedBox(
            width: Spacing.xLarge,
          ),
        ],
        titleBuilder: (context) => InkWell(
          onTap: () {
            showCupertinoModalBottomSheet(
              context: context,
              backgroundColor: LemonColor.atomicBlack,
              builder: (mContext) {
                return GraphQLProvider(
                  client: airstackClient,
                  child: FarcasterChannelDetailBottomsheet(
                    channel: widget.channel,
                  ),
                );
              },
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LemonNetworkImage(
                width: 27.w,
                height: 27.w,
                imageUrl: widget.channel.imageUrl ?? '',
                borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
              ),
              SizedBox(width: Spacing.xSmall),
              Flexible(
                child: Text(
                  widget.channel.id?.isNotEmpty == true
                      ? '/${widget.channel.id}'
                      : '',
                  style: Typo.medium.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                ),
              ),
              SizedBox(width: Spacing.xSmall),
              ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => Assets.icons.icArrowUp.svg(
                  colorFilter: filter,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.bgChat.provider(),
            fit: BoxFit.cover,
          ),
        ),
        child: GraphQLProvider(
          client: airstackClient,
          child: Query$GetFarCasterCasts$Widget(
            options: Options$Query$GetFarCasterCasts(
              variables: Variables$Query$GetFarCasterCasts(
                rootParentUrl: widget.channel.url,
              ),
            ),
            builder: (
              result, {
              refetch,
              fetchMore,
            }) {
              final casts = result.parsedData?.FarcasterCasts?.Cast ?? [];
              if (result.isLoading) {
                return Center(
                  child: Loading.defaultLoading(context),
                );
              }
              return CustomScrollView(
                slivers: [
                  SliverList.separated(
                    itemCount: casts.length,
                    itemBuilder: (context, index) {
                      return FarcasterCastItemWidget(
                        cast: casts[index],
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                      height: 1.w,
                      color: colorScheme.outline,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
