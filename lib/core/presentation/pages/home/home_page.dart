import 'package:app/core/application/newsfeed/newsfeed_listing_bloc/newsfeed_listing_bloc.dart';
import 'package:app/core/data/post/post_repository_impl.dart';
import 'package:app/core/presentation/widgets/burger_menu_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/common/separator/horizontal_line.dart';
import 'package:app/core/presentation/widgets/home/what_on_your_mind_input.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/post/post_profile_card_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/service/post/post_service.dart';
import 'package:app/core/service/shake/shake_service.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  late final PostService postService = PostService(PostRepositoryImpl());

  Widget _newsfeedListingBlocProvider(Widget child) {
    return BlocProvider<NewsfeedListingBloc>(
      create: (context) =>
          NewsfeedListingBloc(postService)..add(NewsfeedListingEvent.fetch(0)),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _newsfeedListingBlocProvider(
      _HomeListingView(),
    );
  }
}

class _HomeListingView extends StatefulWidget {
  const _HomeListingView();

  @override
  State<_HomeListingView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<_HomeListingView> {
  @override
  void initState() {
    super.initState();
    getIt<ShakeService>().startShakeDetection(context);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final themeColor = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: LemonAppBar(
        title: t.home.newsfeed,
        leading: BurgerMenu(),
        actions: [
          GestureDetector(
            onTap: () {
              AutoRouter.of(context).navigate(ChatListRoute());
            },
            child: ThemeSvgIcon(
              color: themeColor.onSurface,
              builder: (filter) => Assets.icons.icChat.svg(
                colorFilter: filter,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: LemonColor.black,
      body: Container(
        child: Column(children: [
          Padding(
              padding: EdgeInsets.only(
                  left: Spacing.small,
                  right: Spacing.small,
                  bottom: Spacing.small),
              child: WhatOnYourMindInput()),
          HorizontalLine(),
          Expanded(
              child: BlocBuilder<NewsfeedListingBloc, NewsfeedListingState>(
            builder: (context, state) {
              return state.when(
                loading: () => Loading.defaultLoading(context),
                fetched: (newsfeed) {
                  if (newsfeed.isEmpty) {
                    return Center(
                      child: EmptyList(
                          emptyText: t.notification.emptyNotifications),
                    );
                  }
                  return ListView.separated(
                    itemBuilder: (ctx, index) => index == newsfeed.length
                        ? const SizedBox(height: 80)
                        : Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: Spacing.small),
                            child: PostProfileCard(
                                key: Key(newsfeed[index].id),
                                post: newsfeed[index]),
                          ),
                    separatorBuilder: (ctx, index) => HorizontalLine(),
                    itemCount: newsfeed.length + 1,
                  );
                },
                failure: () => Center(
                  child: Text(t.common.somethingWrong),
                ),
              );
            },
          )),
        ]),
      ),
    );
  }
}
