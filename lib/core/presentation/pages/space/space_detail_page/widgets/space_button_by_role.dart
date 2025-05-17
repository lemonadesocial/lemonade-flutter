import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/config.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/presentation/pages/space/space_detail_page/widgets/space_follow_button.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class SpaceButtonByRole extends StatelessWidget {
  final Space space;
  const SpaceButtonByRole({
    super.key,
    required this.space,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appColors = context.theme.appColors;
    final userId = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user.userId,
        );
    final radius = BorderRadius.circular(LemonRadius.full);

    if (userId == null || userId.isEmpty == true) {
      return SpaceFollowButton(space: space);
    }

    if (space.isCreator(userId: userId) || space.isAdmin(userId: userId)) {
      return LinearGradientButton.secondaryButton(
        label: t.common.actions.manage,
        radius: radius,
        onTap: () {
          final spaceWebUrl = AppConfig.webUrl +
              '/s/' +
              (space.slug?.isNotEmpty == true ? space.slug : space.id);
          launchUrl(
            Uri.parse(spaceWebUrl),
            mode: LaunchMode.externalApplication,
          );
        },
      );
    }

    if (space.isAmbassador == true) {
      return LemonOutlineButton(
        label: t.space.ambassadorAccess,
        radius: radius,
        leading: ThemeSvgIcon(
          color: appColors.textTertiary,
          builder: (filter) => Assets.icons.icPremiumBadge.svg(
            colorFilter: filter,
          ),
        ),
      );
    }

    return SpaceFollowButton(space: space);
  }
}
