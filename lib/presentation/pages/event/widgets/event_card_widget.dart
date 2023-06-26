import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Column(
        children: [
          _buildCardHeader(),
          _buildCardBody(),
          _buildCardFooter(context, colorScheme),
        ],
      ),
    );
  }

  _buildCardHeader() => Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall, vertical: Spacing.xSmall),
        child: const LemonCircleAvatar(url: '', label: 'Sunburn'),
      );

  _buildCardBody() => SizedBox(
      width: double.infinity,
      height: 200,
      child: CachedNetworkImage(
          width: double.infinity,
          fit: BoxFit.cover,
          imageUrl:
              'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'));

  _buildCardFooter(BuildContext context ,ColorScheme colorScheme) => Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.small, vertical: Spacing.small),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Sunburn Goa ‘22"),
                SizedBox(height: Spacing.superExtraSmall),
                Text("Sat, Jan 15 • 11:00am", style: Typo.small.copyWith(color: colorScheme.onSecondary)),
              ],
            ),
            const Spacer(),
            _buildBuyTicketButton(context,colorScheme)
          ],
        ),
      );


  _buildBuyTicketButton(BuildContext ctx, ColorScheme colorScheme) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall, vertical: Spacing.extraSmall),
        decoration: BoxDecoration(
          border: Border.all(color: colorScheme.outline),
          borderRadius: BorderRadius.circular(LemonRadius.normal),
          color: LemonColor.lavender18,
        ),
        child: Row(
          children: [
            Assets.icons.icTicket.svg(
              width: Sizing.xSmall,
              height: Sizing.xSmall,
              colorFilter: ColorFilter.mode(LemonColor.paleViolet, BlendMode.srcIn),
            ),
            SizedBox(width: Spacing.superExtraSmall),
            Text(
              '${t.event.buy}  \$15',
              style: Typo.small.copyWith(color: LemonColor.paleViolet),
            )
          ],
        ),
      ),
    );
  }
}
