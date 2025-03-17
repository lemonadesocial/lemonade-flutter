import 'package:app/core/application/space/get_space_detail_bloc/get_space_detail_bloc.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/core/utils/social_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/space/space.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class GuestEventDetailSpaceInfo extends StatefulWidget {
  const GuestEventDetailSpaceInfo({
    super.key,
  });

  @override
  State<GuestEventDetailSpaceInfo> createState() =>
      _GuestEventDetailSpaceInfoState();
}

class _GuestEventDetailSpaceInfoState extends State<GuestEventDetailSpaceInfo> {
  bool _loading = false;
  void followSpace(String spaceId, {bool isFollow = true}) async {
    setState(() {
      _loading = true;
    });
    if (isFollow) {
      await getIt<AppGQL>().client.mutate$FollowSpace(
            Options$Mutation$FollowSpace(
              variables: Variables$Mutation$FollowSpace(
                space: spaceId,
              ),
            ),
          );
    } else {
      await getIt<AppGQL>().client.mutate$UnfollowSpace(
            Options$Mutation$UnfollowSpace(
              variables: Variables$Mutation$UnfollowSpace(
                space: spaceId,
              ),
            ),
          );
    }
    setState(() {
      _loading = false;
    });
    context.read<GetSpaceDetailBloc>().add(
          GetSpaceDetailEvent.fetch(
            spaceId: spaceId,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return BlocBuilder<GetSpaceDetailBloc, GetSpaceDetailState>(
      builder: (context, state) {
        final space = state.maybeWhen(
          orElse: () => null,
          success: (space) => space,
        );

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      if (space?.id == null) {
                        return;
                      }
                      AutoRouter.of(context).push(
                        SpaceDetailRoute(
                          spaceId: space!.id!,
                        ),
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LemonNetworkImage(
                          imageUrl: space?.imageAvatar?.url ?? '',
                          width: Sizing.regular,
                          height: Sizing.regular,
                          borderRadius:
                              BorderRadius.circular(LemonRadius.xSmall),
                          placeholder: ImagePlaceholder.spaceThumbnail(),
                        ),
                        SizedBox(width: Spacing.small),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.event.presentedBy,
                              style: Typo.small.copyWith(
                                color: colorScheme.onSecondary,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  space?.title ?? '',
                                  style: Typo.extraMedium.copyWith(
                                    color: colorScheme.onPrimary,
                                  ),
                                ),
                                SizedBox(width: Spacing.superExtraSmall),
                                Padding(
                                  padding: EdgeInsets.only(top: 4.w),
                                  child: ThemeSvgIcon(
                                    color: colorScheme.onSecondary,
                                    builder: (filter) =>
                                        Assets.icons.icArrowRight.svg(
                                      colorFilter: filter,
                                      width: 18.w,
                                      height: 18.w,
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
                  if (_loading)
                    Loading.defaultLoading(context)
                  else
                    LemonOutlineButton(
                      onTap: () {
                        if (space?.id == null) {
                          return;
                        }
                        followSpace(
                          space!.id!,
                          isFollow: space.followed == true ? false : true,
                        );
                      },
                      label: space?.followed == true
                          ? t.common.subscribed
                          : t.common.actions.subscribe,
                      backgroundColor: space?.followed == true
                          ? Colors.transparent
                          : LemonColor.raisinBlack,
                      borderColor:
                          space?.followed == true ? null : Colors.transparent,
                      textStyle: Typo.medium.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                ],
              ),
              SizedBox(height: Spacing.small),
              Text(
                space?.description ?? '',
                style: Typo.medium.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
              SizedBox(height: Spacing.small),
              if (space?.handleTwitter != null ||
                  space?.handleInstagram != null ||
                  space?.handleLinkedin != null ||
                  space?.handleTiktok != null ||
                  space?.handleYoutube != null ||
                  space?.website != null) ...[
                Row(
                  children: <(String?, String, SvgGenImage)>[
                    (
                      space?.handleInstagram,
                      'instagram',
                      Assets.icons.icInstagram
                    ),
                    (space?.handleTwitter, 'twitter', Assets.icons.icXLine),
                    (space?.handleYoutube, 'youtube', Assets.icons.icYoutube),
                    (
                      space?.handleLinkedin,
                      'linkedin',
                      Assets.icons.icLinkedin
                    ),
                    (space?.handleTiktok, 'tiktok', Assets.icons.icTiktok),
                    (space?.website, 'website', Assets.icons.icGlobe),
                  ].where((item) => item.$1 != null).map((item) {
                    return InkWell(
                      onTap: () {
                        if (item.$1 != null) {
                          String url = '';
                          if (item.$2 == 'website') {
                            url = item.$1!;
                          } else {
                            url = SocialUtils.buildSocialLinkBySocialFieldName(
                              socialFieldName: item.$2,
                              socialUserName: item.$1!,
                            );
                          }
                          launchUrl(Uri.parse(url));
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: Spacing.xSmall),
                        child: ThemeSvgIcon(
                          color: colorScheme.onSecondary,
                          builder: (filter) => item.$3.svg(
                            colorFilter: filter,
                            width: 20.w,
                            height: 20.w,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
