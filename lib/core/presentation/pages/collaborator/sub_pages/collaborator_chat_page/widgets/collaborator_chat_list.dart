import 'package:app/core/presentation/pages/collaborator/sub_pages/widgets/collaborator_counter_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CollaboratorChatList extends StatelessWidget {
  const CollaboratorChatList({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return MultiSliver(
      children: [
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                Text(
                  t.collaborator.matches,
                  style: Typo.mediumPlus.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
                SizedBox(
                  width: Spacing.extraSmall,
                ),
                const CollaboratorCounter(),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: Spacing.xSmall)),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
          sliver: SliverList.separated(
            itemCount: 6,
            itemBuilder: (context, index) => const _ChatItem(),
            separatorBuilder: (context, index) => SizedBox(
              height: Spacing.xSmall,
            ),
          ),
        ),
      ],
    );
  }
}

class _ChatItem extends StatelessWidget {
  const _ChatItem();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                width: 42.w,
                height: 42.w,
                decoration: BoxDecoration(
                  border: Border.all(color: colorScheme.outline),
                  borderRadius: BorderRadius.circular(42.w),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(42.w),
                  child: CachedNetworkImage(
                    imageUrl: "https://via.placeholder.com/60x60",
                    width: 42.w,
                    height: 42.w,
                    errorWidget: (_, __, ___) =>
                        ImagePlaceholder.defaultPlaceholder(
                      radius: BorderRadius.circular(42.w),
                    ),
                    placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(
                      radius: BorderRadius.circular(42.w),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 3.w,
                child: Container(
                  width: Sizing.xxSmall,
                  height: Sizing.xxSmall,
                  decoration: ShapeDecoration(
                    color: LemonColor.malachiteGreen,
                    shape: OvalBorder(
                      side: BorderSide(
                        width: 3.w,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: Spacing.xSmall),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Kierra Donin',
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 2.w),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "That's great news! What's next on our to-do list for that account?",
                    style: Typo.medium.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '8:12pm',
                style: Typo.small.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 4.w),
              const _UnreadCounter(),
            ],
          ),
        ],
      ),
    );
  }
}

class _UnreadCounter extends StatelessWidget {
  const _UnreadCounter();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: Spacing.extraSmall, vertical: 2.w),
      decoration: ShapeDecoration(
        color: colorScheme.secondaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Center(
        child: Text(
          '2',
          style: Typo.xSmall.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
