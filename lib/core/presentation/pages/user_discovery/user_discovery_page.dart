import 'package:app/core/presentation/pages/user_discovery/widgets/user_discovery_basic_info_section.dart';
import 'package:app/core/presentation/pages/user_discovery/widgets/user_discovery_photo_gallery.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class UserDiscoveryPage extends StatelessWidget {
  const UserDiscoveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: LemonAppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Spacing.xSmall),
            child: InkWell(
              onTap: () {},
              child: ThemeSvgIcon(
                color: colorScheme.onPrimary,
                builder: (filter) => Assets.icons.icChatBubble.svg(
                  colorFilter: filter,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: Spacing.xSmall),
            child: InkWell(
              onTap: () {},
              child: ThemeSvgIcon(
                color: colorScheme.onPrimary,
                builder: (filter) => Assets.icons.icChatBubble.svg(
                  colorFilter: filter,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: Spacing.xSmall),
            child: InkWell(
              onTap: () {},
              child: ThemeSvgIcon(
                color: colorScheme.onPrimary,
                builder: (filter) => Assets.icons.icChatBubble.svg(
                  colorFilter: filter,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: Spacing.xSmall),
            child: InkWell(
              onTap: () {},
              child: ThemeSvgIcon(
                color: colorScheme.onPrimary,
                builder: (filter) => Assets.icons.icChatBubble.svg(
                  colorFilter: filter,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: UserDiscoveryBasicInfoSection(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 30.w,
              ),
            ),
            const SliverToBoxAdapter(
              child: UserDiscoveryPhotoGallery(),
            ),
          ],
        ),
      ),
    );
  }
}
