import 'package:app/core/application/common/scroll_notification_bloc/scroll_notification_bloc.dart';
import 'package:app/core/application/token/tokens_listing_bloc/tokens_listing_bloc.dart';
import 'package:app/core/domain/token/input/get_tokens_input.dart';
import 'package:app/core/domain/token/token_repository.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/profile/widgets/profile_nft_item.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/service/token/token_service.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart' as dartz;

class ProfileNftCollectedListView extends StatelessWidget {
  final User user;
  late final tokensListingBloc = TokensListingBloc(
      TokenService(
        getIt<TokenRepository>(),
      ),
      defaultInput: GetTokensInput(ownerIn: user.wallets))
    ..add(TokensListingEvent.fetch());

  ProfileNftCollectedListView({
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
                    TokensListingEvent.fetch(),
                  );
                },
                orElse: () {});
          },
          child: _ProfileNftCollectedList(),
        ));
  }
}

class _ProfileNftCollectedList extends StatefulWidget {
  const _ProfileNftCollectedList();

  @override
  State<_ProfileNftCollectedList> createState() => _ProfileNftCreatedListViewState();
}

class _ProfileNftCreatedListViewState extends State<_ProfileNftCollectedList> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
      sliver: BlocBuilder<TokensListingBloc, TokensListingState>(
        builder: (context, tokenListingState) {
          return tokenListingState.when(
              loading: () => SliverFillRemaining(child: Center(child: Loading.defaultLoading(context))),
              failure: () => SliverToBoxAdapter(child: Center(child: Text(t.common.somethingWrong))),
              fetched: (tokens) {
                if (tokens.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text(t.nft.emptyCreatedNfts)),
                  );
                }
                return SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: Spacing.xSmall,
                    mainAxisSpacing: Spacing.xSmall,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final nftToken = tokens[index];
                      return ProfileNftItem(nftToken: dartz.Left(nftToken));
                    },
                    childCount: tokens.length,
                  ),
                );
              });
        },
      ),
    );
  }
}
