import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/config.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/profile/views/tabs/base_sliver_tab_view.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileInfoTabView extends StatelessWidget {
  final User user;

  const ProfileInfoTabView({
    super.key,
    required this.user,
  });

  List<SvgGenImage> get _socialIconsSvg => [
        Assets.icons.icTwitter,
        Assets.icons.icInstagram,
        Assets.icons.icFacebook,
        Assets.icons.icLinkedin,
      ];

  List<String> get _socialUrls => [
        AppConfig.twitterUrl,
        AppConfig.instagramUrl,
        AppConfig.facebookUrl,
        AppConfig.linkedinUrl,
      ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return BaseSliverTabView(
      name: "info",
      children: [
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: Spacing.medium,
              horizontal: Spacing.smMedium,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (user.tagline != null &&
                    user.tagline?.isNotEmpty == true) ...[
                  Text(user.tagline!),
                  SizedBox(height: Spacing.smMedium),
                ],
                if (user.description != null &&
                    user.description?.isNotEmpty == true) ...[
                  Text(
                    StringUtils.capitalize(t.common.description),
                    style: Typo.small
                        .copyWith(color: colorScheme.onSurfaceVariant),
                  ),
                  SizedBox(height: Spacing.superExtraSmall),
                  Text(user.description!),
                  SizedBox(height: Spacing.smMedium),
                ],
                _renderSocials(context, colorScheme),
                SizedBox(height: Spacing.smMedium),
                Text(
                  StringUtils.capitalize(
                    t.common.joinedOn(
                      date: DateFormatUtils.monthYearOnly(user.createdAt),
                    ),
                  ),
                  style:
                      Typo.small.copyWith(color: colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ),
        if (AuthUtils.isMe(context, user: user))
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Spacing.smMedium,
              ),
              child: LinearGradientButton(
                onTap: () =>
                    context.read<AuthBloc>().add(const AuthEvent.logout()),
                label: t.auth.logout,
                textStyle: Typo.medium.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                radius: BorderRadius.all(
                  Radius.circular(LemonRadius.large),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Row _renderSocials(BuildContext context, ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        user.handleTwitter,
        user.handleInstagram,
        user.handleFacebook,
        user.handleLinkedin,
      ].asMap().entries.map((entry) {
        if (entry.value == null || entry.value?.isEmpty == true) {
          return const SizedBox.shrink();
        }
        return GestureDetector(
          onTap: () async {
            AutoRouter.of(context).navigate(
              WebviewRoute(
                uri: Uri.parse('${_socialUrls[entry.key]}/${entry.value}}'),
              ),
            );
          },
          child: Container(
            width: 42,
            height: 42,
            margin: EdgeInsets.only(right: Spacing.xSmall),
            decoration: BoxDecoration(
              color: colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(LemonRadius.xSmall),
            ),
            child: Center(
              child: ThemeSvgIcon(
                color: colorScheme.onSurface,
                builder: (filter) =>
                    _socialIconsSvg[entry.key].svg(colorFilter: filter),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
