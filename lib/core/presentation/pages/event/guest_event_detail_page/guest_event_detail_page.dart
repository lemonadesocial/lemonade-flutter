import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/presentation/pages/event/guest_event_detail_page/views/post_guest_event_detail_view.dart';
import 'package:app/core/presentation/pages/event/guest_event_detail_page/views/post_host_event_detail_view.dart';
import 'package:app/core/presentation/pages/event/guest_event_detail_page/views/pre_guest_event_detail_view.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      child: const _GuestEventDetailView(),
    );
  }
}

class _GuestEventDetailView extends StatelessWidget {
  const _GuestEventDetailView();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<GetEventDetailBloc, GetEventDetailState>(
      builder: (context, state) => state.when(
        failure: () => Scaffold(
          backgroundColor: colorScheme.primary,
          body: Center(
            child: EmptyList(
              emptyText: t.common.somethingWrong,
            ),
          ),
        ),
        loading: () => Scaffold(
          backgroundColor: colorScheme.primary,
          body: Center(
            child: Loading.defaultLoading(context),
          ),
        ),
        fetched: (event) {
          final userId = context.read<AuthBloc>().state.maybeWhen(
                orElse: () => '',
                authenticated: (session) => session.userId,
              );

          final isAttending =
              EventUtils.isAttending(event: event, userId: userId);
          final isOwnEvent =
              EventUtils.isOwnEvent(event: event, userId: userId);
          if (isOwnEvent) {
            return const PostHostEventDetailView();
          }
          return isAttending
              ? const PostGuestEventDetailView()
              : const PreGuestEventDetailView();
        },
      ),
    );
  }
}
