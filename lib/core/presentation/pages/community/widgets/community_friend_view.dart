import 'package:app/core/presentation/widgets/common/searchbar/lemon_search_bar_widget.dart';
import 'package:app/core/presentation/widgets/discover/discover_card.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommunityFriendView extends StatelessWidget {
  const CommunityFriendView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(Spacing.xSmall),
        child: Column(
          children: [
            LemonTextField(
              leadingIcon: ThemeSvgIcon(
                color: colorScheme.onSurfaceVariant,
                builder: (filter) => Assets.icons.icSearch.svg(
                  colorFilter: filter,
                  width: 18.w,
                  height: 18.w,
                  fit: BoxFit.scaleDown,
                ),
              ),
              hintText: t.setting.searchCommunity,
              contentPadding: EdgeInsets.all(Spacing.small),
              onChange: (value) {},
            ),
            SizedBox(height: Spacing.small),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: DiscoverCard(
                    title: t.setting.crew,
                    subTitle: '0/5',
                    icon: Assets.icons.icCrew.svg(),
                    colors: DiscoverCardGradient.events.colors,
                    padding: EdgeInsets.symmetric(
                      horizontal: Spacing.medium,
                      vertical: Spacing.smMedium,
                    ),
                    onTap: () {},
                  ),
                ),
                SizedBox(width: Spacing.extraSmall),
                Expanded(
                  flex: 1,
                  child: DiscoverCard(
                    title: t.setting.tribe,
                    subTitle: '0/25',
                    icon: Assets.icons.icDiscoverPeople.svg(),
                    colors: DiscoverCardGradient.collaborators.colors,
                    padding: EdgeInsets.symmetric(
                      horizontal: Spacing.medium,
                      vertical: Spacing.smMedium,
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
