import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_view.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CollaboratorPreviewProfilePage extends StatelessWidget {
  final User? user;
  const CollaboratorPreviewProfilePage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    final appText = context.theme.appTextTheme;
    final appColors = context.theme.appColors;
    return Scaffold(
      appBar: LemonAppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Spacing.xSmall),
            child: InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Spacing.xSmall,
                  vertical: Spacing.superExtraSmall,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: appColors.pageDivider,
                    ),
                    borderRadius: BorderRadius.circular(LemonRadius.normal),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      t.collaborator.preview,
                      style: appText.sm.copyWith(
                        color: appColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                sliver: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) => CollaboratorDiscoverView(
                    user: state.maybeWhen(
                      orElse: () => null,
                      authenticated: (user) => user,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: Spacing.xLarge * 2),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
