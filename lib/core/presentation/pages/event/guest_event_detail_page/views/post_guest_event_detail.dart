import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/presentation/pages/event/guest_event_detail_page/widgets/guest_event_detail_about_card.dart';
import 'package:app/core/presentation/pages/event/guest_event_detail_page/widgets/guest_event_detail_hosts.dart';
import 'package:app/core/presentation/pages/event/guest_event_detail_page/widgets/guest_event_detail_photos.dart';
import 'package:app/core/presentation/pages/event/guest_event_detail_page/widgets/guest_event_location.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostGuestEventDetail extends StatelessWidget {
  const PostGuestEventDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: BlocBuilder<GetEventDetailBloc, GetEventDetailState>(
        builder: (context, state) => state.when(
          failure: () => Center(
              child: EmptyList(
            emptyText: t.common.somethingWrong,
          )),
          loading: () => Loading.defaultLoading(context),
          fetched: (event) {
            return SafeArea(
              child: Stack(
                children: [
                  CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.only(top: Spacing.large),
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
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                          vertical: Spacing.smMedium,
                          horizontal: Spacing.smMedium,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: GuestEventDetailAboutCard(event: event),
                        ),
                      ),
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
                    ],
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
