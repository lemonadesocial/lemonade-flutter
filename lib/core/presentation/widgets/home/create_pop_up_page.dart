import 'package:app/core/application/newsfeed/newsfeed_listing_bloc/newsfeed_listing_bloc.dart';
import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/core/presentation/widgets/home/create_pop_up_tile.dart';
import 'package:app/core/presentation/widgets/lemon_bottom_sheet_mixin.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class CreatePopUpPage extends StatelessWidget with LemonBottomSheet {
  const CreatePopUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: const LemonBackButton(),
        backgroundColor: colorScheme.onPrimaryContainer,
      ),
      backgroundColor: colorScheme.onPrimaryContainer,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            LemonRadius.normal,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.home.create,
              style: Typo.extraLarge.copyWith(
                fontFamily: FontFamily.nohemiVariable,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: Spacing.small),
            CreatePopUpTile(
              onTap: () => context.router.push(
                CreatePostRoute(
                  onPostCreated: (newPost) =>
                      context.read<NewsfeedListingBloc>().add(
                            NewsfeedListingEvent.newPostAdded(post: newPost),
                          ),
                ),
              ),
              color: colorScheme.onPrimary.withOpacity(0.06),
              label: t.home.post,
              content: t.home.postDesc,
              suffixIcon: Assets.icons.icCreatePost.svg(),
              featureAvailable: true,
            ),
            SizedBox(height: Spacing.xSmall),
            CreatePopUpTile(
              color: colorScheme.onPrimary.withOpacity(0.06),
              label: t.home.room,
              content: t.home.roomDesc,
              suffixIcon: Assets.icons.icCreateRoom.svg(),
            ),
            SizedBox(height: Spacing.xSmall),
            CreatePopUpTile(
              color: colorScheme.onPrimary.withOpacity(0.06),
              label: t.home.event,
              content: t.home.eventDesc,
              suffixIcon: ThemeSvgIcon(
                color: LemonColor.paleViolet,
                builder: (colorFilter) => Assets.icons.icHouseParty.svg(
                  width: 30.w,
                  height: 30.w,
                  colorFilter: colorFilter,
                ),
              ),
            ),
            SizedBox(height: Spacing.xSmall),
            CreatePopUpTile(
              color: colorScheme.onPrimary.withOpacity(0.06),
              label: t.home.poap,
              content: t.home.poapDesc,
              suffixIcon: Assets.icons.icCreatePoap.svg(),
            ),
            SizedBox(height: Spacing.xSmall),
            CreatePopUpTile(
              color: colorScheme.onPrimary.withOpacity(0.06),
              label: t.home.collectible,
              content: t.home.collectibleDesc,
              suffixIcon: ThemeSvgIcon(
                color: LemonColor.collectibleIcon,
                builder: (colorFilter) => Assets.icons.icCrystal.svg(
                  width: 30.w,
                  height: 30.w,
                  colorFilter: colorFilter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
