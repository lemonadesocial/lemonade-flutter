import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/report/report_bloc/report_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_appbar.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_general_info.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_hosts.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_photos.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_rsvp_status/guest_event_detail_rsvp_status.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_rsvp_status/guest_event_detail_rsvp_status_button.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_location.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_more_actions.dart';
import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PreGuestEventDetailView extends StatefulWidget {
  const PreGuestEventDetailView({super.key});

  @override
  State<PreGuestEventDetailView> createState() =>
      PreGuestEventDetailViewState();
}

class PreGuestEventDetailViewState extends State<PreGuestEventDetailView> {
  late final ScrollController _scrollController = ScrollController();
  final reportBloc = ReportBloc();

  @override
  dispose() {
    _scrollController.dispose();
    super.dispose();
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
            final coverPhoto = EventUtils.getEventThumbnailUrl(event: event);
            final isOwnEvent =
                EventUtils.isOwnEvent(event: event, userId: userId);
            final widgets = [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                child: GuestEventDetailGeneralInfo(
                  event: event,
                ),
              ),
              if (event.approvalRequired == true || event.guestLimit != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                  child: GuestEventDetailRSVPStatus(
                    event: event,
                  ),
                ),
              if (event.latitude != null && event.longitude != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                  child: GuestEventLocation(event: event),
                ),
              if ((event.newNewPhotosExpanded ?? []).isNotEmpty)
                GuestEventDetailPhotos(event: event),
              GuestEventDetailHosts(event: event),
            ];
            return SafeArea(
              child: Stack(
                children: [
                  CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: _scrollController,
                    slivers: [
                      GuestEventDetailAppBar(
                        scrollController: _scrollController,
                        event: event,
                      ),
                      if (coverPhoto.isNotEmpty)
                        SliverPadding(
                          padding: EdgeInsets.only(top: Spacing.large),
                        ),
                      SliverList.separated(
                        itemCount: widgets.length,
                        itemBuilder: (context, index) {
                          return widgets[index];
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: Spacing.smMedium * 2,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(height: 84.w),
                      ),
                    ],
                  ),
                  if (coverPhoto.isNotEmpty)
                    _FloatingButtonsBar(
                      scrollController: _scrollController,
                      event: event,
                    ),
                  if (!isOwnEvent)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GuestEventDetailRSVPStatusButton(
                        event: event,
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

class _FloatingButtonsBar extends StatefulWidget {
  final Event event;
  final ScrollController scrollController;

  const _FloatingButtonsBar({
    required this.event,
    required this.scrollController,
  });

  @override
  State<_FloatingButtonsBar> createState() => _FloatingButtonsBarState();
}

class _FloatingButtonsBarState extends State<_FloatingButtonsBar> {
  bool _isSliverAppBarCollapsed = false;
  @override
  initState() {
    super.initState();
    widget.scrollController.addListener(() {
      final mIsSliverAppBarCollapsed = widget.scrollController.hasClients &&
          widget.scrollController.offset > 150.w;
      if (_isSliverAppBarCollapsed == mIsSliverAppBarCollapsed) return;
      setState(() {
        _isSliverAppBarCollapsed = mIsSliverAppBarCollapsed;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Align(
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
            GuestEventMoreActions(
              event: widget.event,
              isAppBarCollapsed: _isSliverAppBarCollapsed,
            ),
          ],
        ),
      ),
    );
  }
}
