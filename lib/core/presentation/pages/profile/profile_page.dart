import 'package:app/core/application/profile/user_profile_bloc/user_profile_bloc.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/pages/profile/views/profile_page_view.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  final String userId;

  const ProfilePage({super.key, @PathParam("id") required this.userId});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return BlocProvider(
      create: (context) => UserProfileBloc(getIt<UserRepository>())
        ..add(
          UserProfileEvent.fetch(userId: userId),
        ),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
            return state.maybeWhen(
              fetched: (userProfile) =>
                  ProfilePageView(userProfile: userProfile),
              loading: () => Center(
                child: Loading.defaultLoading(context),
              ),
              orElse: () => Center(
                child: Text(t.common.somethingWrong),
              ),
            );
          },
        ),
      ),
    );
  }
}
