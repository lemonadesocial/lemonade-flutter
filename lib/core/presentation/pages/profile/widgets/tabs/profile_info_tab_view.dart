import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/pages/profile/widgets/tabs/base_sliver_tab_view.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileInfoTabView extends StatelessWidget {
  const ProfileInfoTabView({super.key});

  List<SvgGenImage> get _socialIconsSvg => [
        Assets.icons.icTwitter,
        Assets.icons.icInstagram,
        Assets.icons.icFacebook,
        Assets.icons.icLinkedin,
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
            padding: EdgeInsets.symmetric(vertical: Spacing.medium, horizontal: Spacing.smMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Typical creator. Bacon guru. Zombie advocate.\nGamer.'),
                SizedBox(height: Spacing.smMedium),
                Text(StringUtils.capitalize(t.common.description),
                    style: Typo.small.copyWith(color: colorScheme.onSurface)),
                SizedBox(height: Spacing.superExtraSmall),
                Text(
                    'I\'ve previously worked on cloud computing products at Google in San Francisco. Recently I relocated to Boulder and am open to remote roles.'),
                SizedBox(height: Spacing.smMedium),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _socialIconsSvg
                      .map((icon) => Container(
                            width: 42,
                            height: 42,
                            margin: EdgeInsets.only(right: Spacing.xSmall),
                            decoration: BoxDecoration(
                              border: Border.all(color: colorScheme.outline),
                              borderRadius: BorderRadius.circular(42),
                            ),
                            child: Center(
                                child: ThemeSvgIcon(
                                    color: colorScheme.onSurface, builder: (filter) => icon.svg(colorFilter: filter))),
                          ))
                      .toList(),
                ),
                SizedBox(height: Spacing.smMedium),
                Text(
                  StringUtils.capitalize(
                    t.common.joinedOn(date: DateFormatUtils.monthYearOnly(DateTime.now())),
                  ),
                  style: Typo.small.copyWith(color: colorScheme.onSurface),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthEvent.logout());
                  },
                  child: Text("Logout"),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
