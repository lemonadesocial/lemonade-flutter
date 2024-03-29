import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/sub_pages/guest_event_guest_directory_page/widgets/guest_directory_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/graphql/backend/event/query/get_event_guest_directory.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class GuestEventGuestDirectoryPage extends StatelessWidget {
  const GuestEventGuestDirectoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final event = context.read<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => null,
          fetched: (event) => event,
        );

    return Scaffold(
      appBar: LemonAppBar(
        title: t.event.eventGuestDirectory.eventGuestDirectoryTitle,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
        child: CustomScrollView(
          slivers: [
            Query$GetEventGuestDirectory$Widget(
              options: Options$Query$GetEventGuestDirectory(
                variables: Variables$Query$GetEventGuestDirectory(
                  id: event?.id ?? '',
                ),
              ),
              builder: (
                result, {
                refetch,
                fetchMore,
              }) {
                if (result.isLoading) {
                  return SliverToBoxAdapter(
                    child: Loading.defaultLoading(context),
                  );
                }

                if (result.hasException ||
                    result.parsedData?.getEventGuestDirectory == null) {
                  return SliverToBoxAdapter(
                    child: EmptyList(
                      emptyText: t.common.somethingWrong,
                    ),
                  );
                }

                final guests = result.parsedData!.getEventGuestDirectory
                    .map(
                      (item) => User.fromDto(
                        UserDto.fromJson(
                          item.toJson(),
                        ),
                      ),
                    )
                    .toList();

                if (guests.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: EmptyList(),
                  );
                }

                return SliverGrid.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: Spacing.xSmall,
                    mainAxisSpacing: Spacing.xSmall,
                    childAspectRatio: 1 / 1.22,
                  ),
                  itemCount: guests.length,
                  itemBuilder: (context, index) {
                    final guest = guests[index];
                    return GuestDirectoryItem(
                      guest: guest,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
