import 'package:app/core/application/space/get_space_detail_bloc/get_space_detail_bloc.dart';
import 'package:app/core/application/space/get_space_events_bloc/get_space_events_bloc.dart';
import 'package:app/core/domain/space/space_repository.dart';
import 'package:app/core/presentation/pages/space/space_detail_page/widgets/space_events_list.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/graphql/backend/event/query/get_events.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/core/presentation/pages/space/space_detail_page/widgets/space_header.dart';
import 'package:app/core/presentation/pages/space/space_detail_page/widgets/space_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class SpaceDetailPage extends StatelessWidget {
  final String spaceId;
  const SpaceDetailPage({
    super.key,
    required this.spaceId,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetSpaceDetailBloc(getIt<SpaceRepository>())
            ..add(
              GetSpaceDetailEvent.fetch(
                spaceId: spaceId,
              ),
            ),
        ),
        BlocProvider(
          create: (context) => GetSpaceEventsBloc()
            ..add(
              GetSpaceEventsEvent.fetch(
                input: Variables$Query$GetEvents(
                  space: spaceId,
                  limit: 50,
                  sort: Input$EventSortInput(
                    start: Enum$SortOrder.desc,
                  ),
                ),
              ),
            ),
        ),
      ],
      child: const _View(),
    );
  }
}

class _View extends StatefulWidget {
  const _View();

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  final ScrollController _scrollController = ScrollController();
  bool _showFloatingSubscribe = false;
  bool _showSimpleHeader = false;
  final double _subscribeButtonThreshold = 250;
  final double _headerThreshold = 200;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(_onScroll);
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final shouldShowFloatingSubscribe =
        _scrollController.offset >= _subscribeButtonThreshold;
    final shouldShowSimpleHeader = _scrollController.offset >= _headerThreshold;

    if (shouldShowFloatingSubscribe != _showFloatingSubscribe ||
        shouldShowSimpleHeader != _showSimpleHeader) {
      setState(() {
        _showFloatingSubscribe = shouldShowFloatingSubscribe;
        _showSimpleHeader = shouldShowSimpleHeader;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<GetSpaceDetailBloc, GetSpaceDetailState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => Scaffold(
            body: Center(
              child: Loading.defaultLoading(context),
            ),
          ),
          failure: (_) {
            return Scaffold(
              appBar: const LemonAppBar(title: ""),
              body: EmptyList(
                emptyText: t.common.somethingWrong,
              ),
            );
          },
          loading: () => Scaffold(
            appBar: const LemonAppBar(title: ""),
            body: Center(
              child: Loading.defaultLoading(
                context,
              ),
            ),
          ),
          success: (space) {
            return Scaffold(
              body: Stack(
                children: [
                  CustomScrollView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SpaceHeader(space: space),
                      SliverToBoxAdapter(
                        child: SpaceInfo(space: space),
                      ),
                      SliverToBoxAdapter(
                        child: Divider(
                          color: colorScheme.outline,
                        ),
                      ),
                      SpaceEventsList(space: space),
                    ],
                  ),
                  _FloatingSpaceHeader(
                    title: space.title ?? '',
                    showSimpleHeader: _showSimpleHeader,
                  ),
                  _FloatingSubscribeButton(
                    showFloatingSubscribe: _showFloatingSubscribe,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _FloatingSpaceHeader extends StatelessWidget {
  final String title;
  const _FloatingSpaceHeader({
    required this.showSimpleHeader,
    required this.title,
  });

  final bool showSimpleHeader;

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      top: showSimpleHeader ? 0 : -(LemonAppBar.height + statusBarHeight),
      left: 0,
      right: 0,
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: SafeArea(
          bottom: false,
          child: LemonAppBar(
            title: title,
          ),
        ),
      ),
    );
  }
}

class _FloatingSubscribeButton extends StatelessWidget {
  const _FloatingSubscribeButton({
    required this.showFloatingSubscribe,
  });

  final bool showFloatingSubscribe;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      bottom: showFloatingSubscribe ? Spacing.large : -2 * Spacing.large,
      left: 0,
      right: 0,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.small),
          child: SizedBox(
            height: 49.w,
            child: LinearGradientButton.primaryButton(
              label: t.common.actions.subscribe,
            ),
          ),
        ),
      ),
    );
  }
}
