import 'package:app/core/domain/lens/entities/lens_account.dart';
import 'package:app/core/presentation/pages/lens/page/lens_user_profile_page/widgets/lens_account_profile_header.dart';
import 'package:app/core/presentation/pages/lens/page/lens_user_profile_page/widgets/lens_account_profile_newsfeed.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/common/sliver/dynamic_sliver_appbar.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/graphql/lens/account/query/lens_get_account.graphql.dart';
import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:app/core/utils/debouncer.dart';

@RoutePage()
class LensUserProfilePage extends StatefulWidget {
  final LensAccount? lensAccount;
  const LensUserProfilePage({
    super.key,
    required this.lensAccount,
  });

  @override
  State<LensUserProfilePage> createState() => _LensUserProfilePageState();
}

class _LensUserProfilePageState extends State<LensUserProfilePage>
    with SingleTickerProviderStateMixin {
  final debouncer = Debouncer(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return GraphQLProvider(
      client: ValueNotifier(getIt<LensGQL>().client),
      child: Query$Account$Widget(
        options: Options$Query$Account(
          fetchPolicy: FetchPolicy.cacheFirst,
          variables: Variables$Query$Account(
            request: Input$AccountRequest(
              address: widget.lensAccount?.address ?? '',
            ),
          ),
        ),
        builder: (result, {refetch, fetchMore}) {
          return Scaffold(
            appBar: LemonAppBar(
              title: '@${widget.lensAccount?.username?.localName ?? ''}',
            ),
            body: Builder(
              builder: (context) {
                if (result.isLoading) {
                  return Center(
                    child: Loading.defaultLoading(context),
                  );
                }
                final rawData = result.parsedData?.account;
                final lensAccount = rawData == null
                    ? null
                    : LensAccount.fromJson(rawData.toJson());
                if (lensAccount == null) {
                  return Center(
                    child: EmptyList(
                      emptyText: t.common.somethingWrong,
                    ),
                  );
                }

                return NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context,
                      ),
                      sliver: MultiSliver(
                        children: [
                          DynamicSliverAppBar(
                            maxHeight: 250.h,
                            floating: true,
                            forceElevated: innerBoxIsScrolled,
                            child: LensAccountProfileHeader(
                              lensAccount: lensAccount,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  body: LensAccountProfileNewsfeed(
                    lensAccount: lensAccount,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
