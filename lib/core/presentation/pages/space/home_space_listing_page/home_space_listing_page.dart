import 'package:app/core/application/space/list_spaces_bloc/list_spaces_bloc.dart';
import 'package:app/core/domain/space/space_repository.dart';
import 'package:app/core/presentation/pages/space/home_space_listing_page/home_space_listing.dart';
import 'package:app/core/presentation/widgets/home_appbar/home_appbar.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomeSpaceListingPage extends StatelessWidget {
  const HomeSpaceListingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mySpacesBloc = ListSpacesBloc(
      spaceRepository: getIt<SpaceRepository>(),
      withMySpaces: true,
      roles: [
        Enum$SpaceRole.admin,
        Enum$SpaceRole.creator,
        Enum$SpaceRole.subscriber,
        Enum$SpaceRole.ambassador,
      ],
    )..add(const ListSpacesEvent.fetch());

    final ambassadorSpacesBloc = ListSpacesBloc(
      spaceRepository: getIt<SpaceRepository>(),
      withMySpaces: false,
      roles: [Enum$SpaceRole.ambassador],
    )..add(const ListSpacesEvent.fetch());

    final subscribedSpacesBloc = ListSpacesBloc(
      spaceRepository: getIt<SpaceRepository>(),
      withMySpaces: false,
      roles: [Enum$SpaceRole.subscriber],
    )..add(const ListSpacesEvent.fetch());

    return MultiBlocProvider(
      providers: [
        BlocProvider<ListSpacesBloc>.value(value: mySpacesBloc),
        BlocProvider<ListSpacesBloc>.value(value: ambassadorSpacesBloc),
        BlocProvider<ListSpacesBloc>.value(value: subscribedSpacesBloc),
      ],
      child: _View(
        mySpacesBloc: mySpacesBloc,
        ambassadorSpacesBloc: ambassadorSpacesBloc,
        subscribedSpacesBloc: subscribedSpacesBloc,
      ),
    );
  }
}

class _View extends StatelessWidget {
  const _View({
    required this.mySpacesBloc,
    required this.ambassadorSpacesBloc,
    required this.subscribedSpacesBloc,
  });

  final ListSpacesBloc mySpacesBloc;
  final ListSpacesBloc ambassadorSpacesBloc;
  final ListSpacesBloc subscribedSpacesBloc;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Scaffold(
      appBar: HomeAppBar(
        title: t.space.communities,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          mySpacesBloc.add(const ListSpacesEvent.refresh());
          ambassadorSpacesBloc.add(const ListSpacesEvent.refresh());
          subscribedSpacesBloc.add(const ListSpacesEvent.refresh());
        },
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(
                top: Spacing.s5,
              ),
              sliver: HomeSpaceListing(
                mySpacesBloc: mySpacesBloc,
                ambassadorSpacesBloc: ambassadorSpacesBloc,
                subscribedSpacesBloc: subscribedSpacesBloc,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
