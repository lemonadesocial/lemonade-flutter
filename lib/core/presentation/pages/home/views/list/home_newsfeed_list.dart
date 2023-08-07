import 'package:app/core/application/newsfeed/newsfeed_listing_bloc/newsfeed_listing_bloc.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/common/separator/horizontal_line.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/post/post_profile_card_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeNewsfeedListView extends StatelessWidget {
  HomeNewsfeedListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return BlocBuilder<NewsfeedListingBloc, NewsfeedListingState>(
        builder: (context, state) {
      return state.when(
        loading: () => Loading.defaultLoading(context),
        fetched: (newsfeed) {
          if (newsfeed.isEmpty) {
            return Center(
              child: EmptyList(emptyText: t.notification.emptyNotifications),
            );
          }
          return ListView.separated(
            itemBuilder: (ctx, index) => index == newsfeed.length
                ? const SizedBox(height: 80)
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.small),
                    child: PostProfileCard(
                      key: Key(newsfeed[index].id),
                      post: newsfeed[index],
                    ),
                  ),
            separatorBuilder: (ctx, index) => HorizontalLine(),
            itemCount: newsfeed.length + 1,
          );
        },
        failure: () => Center(
          child: Text(t.common.somethingWrong),
        ),
      );
    });
  }
}
