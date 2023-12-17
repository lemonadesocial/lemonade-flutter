import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/pages/left_panel/widgets/left_panel_profile_info.dart';
import 'package:app/core/presentation/pages/left_panel/widgets/left_panel_tile_widget.dart';
import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/modal_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:slang/builder/utils/string_extensions.dart';

@RoutePage()
class LeftPanelPage extends StatelessWidget {
  const LeftPanelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LeftPanelPageView();
  }
}

class LeftPanelPageView extends StatelessWidget {
  const LeftPanelPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: LemonAppBar(
        title: '',
        leading: const LemonBackButton(),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Spacing.smMedium),
            child: InkWell(
              onTap: () {
                Vibrate.feedback(FeedbackType.light);
                AutoRouter.of(context).navigate(const SettingRoute());
              },
              child: ThemeSvgIcon(
                color: colorScheme.onSurface,
                builder: (filter) => Assets.icons.icSettings.svg(
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LeftPanelProfileInfo(),
              SizedBox(
                height: 30.h,
              ),
              LeftPanelTileWidget(
                title: t.common.vaults,
                leading: ThemeSvgIcon(
                  color: colorScheme.onPrimary,
                  builder: (filter) {
                    return Assets.icons.icBank
                        .svg(colorFilter: filter, width: 18, height: 18);
                  },
                ),
                featureAvailable: true,
                trailing: Assets.icons.icArrowBack.svg(
                  width: 18.w,
                  height: 18.w,
                ),
                onTap: () {
                  Vibrate.feedback(FeedbackType.light);
                  context.read<AuthBloc>().state.maybeWhen(
                        authenticated: (authSession) => context.router.push(
                          const VaultsListingRoute(),
                        ),
                        orElse: () => context.router.navigate(
                          const LoginRoute(),
                        ),
                      );
                },
              ),
              SizedBox(
                height: Spacing.xSmall,
              ),
              LeftPanelTileWidget(
                title: t.common.community.capitalize(),
                leading: ThemeSvgIcon(
                  color: colorScheme.onPrimary,
                  builder: (filter) {
                    return Assets.icons.icPeopleAlt
                        .svg(colorFilter: filter, width: 18, height: 18);
                  },
                ),
                featureAvailable: true,
                trailing: Assets.icons.icArrowBack.svg(
                  width: 18.w,
                  height: 18.w,
                ),
                onTap: () {
                  Vibrate.feedback(FeedbackType.light);
                  context.read<AuthBloc>().state.maybeWhen(
                        authenticated: (authSession) =>
                            context.router.push(const CommunityRoute()),
                        orElse: () => context.router.navigate(
                          const LoginRoute(),
                        ),
                      );
                },
              ),
              SizedBox(
                height: Spacing.xSmall,
              ),
              LeftPanelTileWidget(
                title: t.common.ticket(n: 2).capitalize(),
                leading: ThemeSvgIcon(
                  color: colorScheme.onPrimary,
                  builder: (filter) {
                    return Assets.icons.icTicket
                        .svg(colorFilter: filter, width: 18, height: 18);
                  },
                ),
                trailing: Assets.icons.icArrowBack.svg(
                  width: 18.w,
                  height: 18.w,
                ),
                featureAvailable: true,
                onTap: () {
                  Vibrate.feedback(FeedbackType.light);
                  context.read<AuthBloc>().state.maybeWhen(
                        authenticated: (authSession) => context.router.push(
                          MyEventTicketsListRoute(),
                        ),
                        orElse: () => context.router.navigate(
                          const LoginRoute(),
                        ),
                      );
                },
              ),
              SizedBox(
                height: Spacing.xSmall,
              ),
              LeftPanelTileWidget(
                title: t.common.dashboard.capitalize(),
                leading: ThemeSvgIcon(
                  color: colorScheme.onPrimary,
                  builder: (filter) {
                    return Assets.icons.icInsights
                        .svg(colorFilter: filter, width: 18, height: 18);
                  },
                ),
                featureAvailable: false,
                onTap: () => showComingSoonDialog(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
