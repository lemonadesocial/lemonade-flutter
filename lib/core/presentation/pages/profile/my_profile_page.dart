import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/pages/profile/views/profile_page_view.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return state.maybeWhen(
            authenticated: (authSession) =>
                ProfilePageView(userProfile: authSession),
            processing: () => Center(
              child: Loading.defaultLoading(context),
            ),
            orElse: () => Center(
              child: Text(t.common.somethingWrong),
            ),
          );
        },
      ),
    );
  }
}
