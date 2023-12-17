import 'package:app/core/presentation/pages/left_panel/widgets/left_panel_profile_info.dart';
import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

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
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LeftPanelProfileInfo(),
            ],
          ),
        ),
      ),
    );
  }
}
