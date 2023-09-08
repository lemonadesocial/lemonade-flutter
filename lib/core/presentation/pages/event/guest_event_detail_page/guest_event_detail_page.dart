import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/presentation/pages/event/guest_event_detail_page/widgets/guest_event_detail_appbar.dart';
import 'package:app/core/presentation/pages/event/guest_event_detail_page/widgets/guest_event_detail_buy_button.dart';
import 'package:app/core/presentation/pages/event/guest_event_detail_page/widgets/guest_event_detail_general_info.dart';
import 'package:app/core/presentation/pages/event/guest_event_detail_page/widgets/guest_event_detail_hosts.dart';
import 'package:app/core/presentation/pages/event/guest_event_detail_page/widgets/guest_event_detail_photos.dart';
import 'package:app/core/presentation/pages/event/guest_event_detail_page/widgets/guest_event_location.dart';
import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class GuestEventDetailPage extends StatelessWidget {
  const GuestEventDetailPage({
    super.key,
    @PathParam('id') required this.eventId,
  });
  final String eventId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetEventDetailBloc()
        ..add(
          GetEventDetailEvent.fetch(
            eventId: eventId,
          ),
        ),
      child: const _GuestEventDetailPageView(),
    );
  }
}

class _GuestEventDetailPageView extends StatefulWidget {
  const _GuestEventDetailPageView();

  @override
  State<_GuestEventDetailPageView> createState() =>
      _GuestEventDetailPageViewState();
}

class _GuestEventDetailPageViewState extends State<_GuestEventDetailPageView> {
  late final ScrollController _scrollController = ScrollController();
  bool _isSliverAppBarCollapsed = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final mIsSliverAppBarCollapsed =
          _scrollController.hasClients && _scrollController.offset > 150.w;
      if (_isSliverAppBarCollapsed == mIsSliverAppBarCollapsed) return;
      setState(() {
        _isSliverAppBarCollapsed = mIsSliverAppBarCollapsed;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final userId = context.read<AuthBloc>().state.maybeWhen(
          authenticated: (session) => session.userId,
          orElse: () => '',
        );
    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: BlocBuilder<GetEventDetailBloc, GetEventDetailState>(
        builder: (context, state) => state.when(
          failure: () => Center(
            child: EmptyList(
              emptyText: t.common.somethingWrong,
            ),
          ),
          loading: () => Loading.defaultLoading(context),
          fetched: (event) {
            final isAttending =
                EventUtils.isAttending(event: event, userId: userId);
            return SafeArea(
              child: Stack(
                children: [
                  CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: _scrollController,
                    slivers: [
                      GuestEventDetailAppBar(
                        isCollapsed: _isSliverAppBarCollapsed,
                        event: event,
                      ),
                      SliverPadding(
                        padding: EdgeInsets.only(top: Spacing.large),
                      ),
                      SliverPadding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                        sliver: SliverToBoxAdapter(
                          child: GuestEventDetailGeneralInfo(
                            event: event,
                          ),
                        ),
                      ),
                      if (event.latitude != null &&
                          event.longitude != null) ...[
                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Spacing.smMedium),
                          sliver: SliverToBoxAdapter(
                            child: GuestEventLocation(event: event),
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                            vertical: Spacing.smMedium,
                          ),
                        ),
                      ],
                      SliverToBoxAdapter(
                        child: GuestEventDetailPhotos(event: event),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                          vertical: Spacing.smMedium,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: GuestEventDetailHosts(event: event),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(height: 84.w),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Spacing.extraSmall,
                        vertical: Spacing.extraSmall,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BlurCircle(
                            child: LemonBackButton(
                              color: _isSliverAppBarCollapsed
                                  ? colorScheme.onPrimary
                                  : colorScheme.onSurface,
                            ),
                          ),
                          BlurCircle(
                            child: Center(
                              child: ThemeSvgIcon(
                                color: _isSliverAppBarCollapsed
                                    ? colorScheme.onPrimary
                                    : colorScheme.onSurface,
                                builder: (filter) =>
                                    Assets.icons.icMoreHoriz.svg(
                                  colorFilter: filter,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (!isAttending)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GuestEventDetailBuyButton(
                        event: event,
                        onBuySuccess: () {
                          context.read<GetEventDetailBloc>().add(
                              GetEventDetailEvent.fetch(eventId: event.id!));
                          AutoRouter.of(context).replace(
                            RSVPEventSuccessPopupRoute(
                              event: event,
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
