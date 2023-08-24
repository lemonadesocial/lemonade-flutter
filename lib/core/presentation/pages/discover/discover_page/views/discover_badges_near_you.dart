import 'package:app/core/presentation/widgets/poap/hot_badge_item.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliver_tools/sliver_tools.dart';

class DiscoverBadgesNearYou extends StatelessWidget {
  const DiscoverBadgesNearYou({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return MultiSliver(
      children: [
        SliverPadding(
          padding: EdgeInsets.symmetric(
            vertical: Spacing.xSmall,
            horizontal: Spacing.xSmall,
          ),
          sliver: SliverToBoxAdapter(
            child: Text(
              t.discover.hotBadgesNearYou,
              style: Typo.medium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 226.w,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => const HotBadgeItem(),
              separatorBuilder: (context, index) => SizedBox(
                width: Spacing.xSmall,
              ),
              itemCount: 5,
            ),
          ),
        ),
      ],
    );
  }
}
