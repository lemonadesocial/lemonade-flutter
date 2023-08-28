import 'package:app/core/application/newsfeed/newsfeed_listing_bloc/newsfeed_listing_bloc.dart';
import 'package:app/core/data/post/newsfeed_repository_impl.dart';
import 'package:app/core/domain/newsfeed/input/get_newsfeed_input.dart';
import 'package:app/core/presentation/pages/home/views/list/home_newsfeed_list.dart';
import 'package:app/core/presentation/widgets/common/appbar/appbar_logo.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/service/newsfeed/newsfeed_service.dart';
import 'package:app/core/service/shake/shake_service.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visibility_detector/visibility_detector.dart';


@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final newFeedBloc = NewsfeedListingBloc(
      NewsfeedService(NewsfeedRepositoryImpl()),
      defaultInput: const GetNewsfeedInput(),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsfeedListingBloc>(
          create: (context) => newFeedBloc..add(NewsfeedListingEvent.fetch()),
        ),
        // Add other Blocs here if needed.
      ],
      child: Builder(
        builder: (context) {
          return VisibilityDetector(
            key: const Key('HomePageVisibilityDetector'),
            onVisibilityChanged: (info) {
              if (info.visibleFraction == 1) {
                //Whenever this screen is appear on screen, fetch latest news feed
                context
                    .read<NewsfeedListingBloc>()
                    .add(NewsfeedListingEvent.fetch());
              }
            },
            child: const _HomeListingView(),
          );
        },
      ),
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
    return Scaffold(
      appBar: LemonAppBar(
        title: t.home.newsfeed,
        leading: const AppBarLogo(),
        actions: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              AutoRouter.of(context).navigate(const ChatListRoute());
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              alignment: Alignment.centerRight,
              child: ThemeSvgIcon(
                color: Theme.of(context).colorScheme.onSurface,
                builder: (filter) => Assets.icons.icChatBubble.svg(
                  colorFilter: filter,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: LemonColor.black,
      body: const HomeNewsfeedListView(),
      floatingActionButton: InkWell(
        onTap: () => context.router.push(
          const OnboardingWrapperRoute(
            children: [OnboardingUsernameRoute()],
          ),
        ),
        child: Container(
          width: 54.h,
          height: 54.h,
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [LemonColor.fabSecondaryBg, LemonColor.fabFirstBg],
            ),
            boxShadow: [
              BoxShadow(
                color: LemonColor.fabShadow,
                blurRadius: 8,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: ThemeSvgIcon(
            color: LemonColor.white,
            builder: (filter) => Assets.icons.icAdd.svg(
              colorFilter: filter,
              width: 24.w,
              height: 24.w,
            ),
          ),
        ),
      ),
    );
  }
}
