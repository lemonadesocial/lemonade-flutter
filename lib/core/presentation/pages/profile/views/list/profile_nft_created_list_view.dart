import 'package:app/core/application/common/scroll_notification_bloc/scroll_notification_bloc.dart';
import 'package:app/core/application/token/tokens_listing_bloc/tokens_listing_bloc.dart';
import 'package:app/core/domain/token/input/get_tokens_input.dart';
import 'package:app/core/domain/token/token_repository.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/profile/widgets/profile_nft_item.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/service/token/token_service.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileNftCreatedListView extends StatelessWidget {
  final User user;
  late final tokensListingBloc = TokensListingBloc(
    TokenService(
      getIt<TokenRepository>(),
    ),
    defaultInput: GetTokensInput(creator: user.wallets?[0]),
  )..add(const TokensListingEvent.fetch());

  ProfileNftCreatedListView({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: tokensListingBloc,
      child: BlocListener<ScrollNotificationBloc, ScrollNotificationState>(
        listener: (context, scrollState) {
          scrollState.maybeWhen(
            endReached: () {
              tokensListingBloc.add(
                const TokensListingEvent.fetch(),
              );
            },
            orElse: () {},
          );
        },
        child: const _ProfileNftCreatedList(),
      ),
    );
  }
}

class _ProfileNftCreatedList extends StatefulWidget {
  const _ProfileNftCreatedList();

  @override
  State<_ProfileNftCreatedList> createState() =>
      _ProfileNftCreatedListViewState();
}

class _ProfileNftCreatedListViewState extends State<_ProfileNftCreatedList> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
      sliver: BlocBuilder<TokensListingBloc, TokensListingState>(
        builder: (context, tokenListingState) {
          return tokenListingState.when(
            loading: () => SliverFillRemaining(
              child: Center(child: Loading.defaultLoading(context)),
            ),
            failure: () => SliverToBoxAdapter(
              child: Center(child: Text(t.common.somethingWrong)),
            ),
            fetched: (mediaList) {
              if (mediaList.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: EmptyList(emptyText: t.nft.noCollectible),
                );
              }
              return SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: Spacing.superExtraSmall,
                  mainAxisSpacing: Spacing.superExtraSmall,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ProfileNftItem(
                      mediaList: mediaList,
                      index: index,
                    );
                  },
                  childCount: mediaList.length,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
