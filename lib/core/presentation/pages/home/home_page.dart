import 'package:app/core/application/newsfeed/newsfeed_listing_bloc/newsfeed_listing_bloc.dart';
import 'package:app/core/data/post/newsfeed_repository_impl.dart';
import 'package:app/core/domain/newsfeed/input/get_newsfeed_input.dart';
import 'package:app/core/presentation/pages/home/views/list/home_newsfeed_list.dart';
import 'package:app/core/presentation/widgets/burger_menu_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/separator/horizontal_line.dart';
import 'package:app/core/presentation/widgets/home/what_on_your_mind_input.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/service/newsfeed/newsfeed_service.dart';
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
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsfeedListingBloc>(
          create: (context) => NewsfeedListingBloc(
            NewsfeedService(NewsfeedRepositoryImpl()),
            defaultInput: const GetNewsfeedInput(),
          )..add(NewsfeedListingEvent.fetch()),
        ),
        // Add other Blocs here if needed.
      ],
      child: const _HomeListingView(),
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
        leading: const BurgerMenu(),
        actions: [
          GestureDetector(
            onTap: () {
              AutoRouter.of(context).navigate(const ChatListRoute());
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
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: Spacing.small,
                right: Spacing.small,
                bottom: Spacing.small,
              ),
              child: WhatOnYourMindInput(),
            ),
            HorizontalLine(),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollEndNotification) {
                    if (notification.metrics.pixels == notification.metrics.maxScrollExtent) {
                      context.read<NewsfeedListingBloc>().add(NewsfeedListingEvent.fetch());
                    }
                  }
                  return true;
                },
                child: HomeNewsfeedListView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
