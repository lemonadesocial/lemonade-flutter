import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/user/entities/user_service_offer.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class CollaboratorDiscoverExpertiseOfferingCard extends StatelessWidget {
  final User? user;
  final Color? backgroundColor;

  const CollaboratorDiscoverExpertiseOfferingCard({
    super.key,
    this.user,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final sections = [
      if (user?.expertise?.isNotEmpty == true)
        _Expertise(
          expertise: user?.expertise ?? [],
        ),
      if (user?.serviceOffersExpanded?.isNotEmpty == true)
        _Offering(
          serviceOffers: user?.serviceOffersExpanded ?? [],
        ),
    ];
    return Container(
      padding: EdgeInsets.all(Spacing.smMedium),
      decoration: ShapeDecoration(
        color: backgroundColor ?? LemonColor.white06,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LemonRadius.normal),
        ),
      ),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: sections.length,
        itemBuilder: (context, index) {
          return sections[index];
        },
        separatorBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: Spacing.smMedium,
            ),
            child: ThemeSvgIcon(
              builder: (colorFilter) => Assets.icons.icArrowDivider.svg(),
            ),
          );
        },
      ),
    );
  }
}

class _Offering extends StatelessWidget {
  final List<UserServiceOffer> serviceOffers;
  const _Offering({
    required this.serviceOffers,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.collaborator.offering,
          style: Typo.medium.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: Spacing.superExtraSmall),
        Text(
          serviceOffers.map((item) => item.title).join(' , '),
          style: Typo.medium.copyWith(
            color: colorScheme.onSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class _Expertise extends StatelessWidget {
  final List<String> expertise;
  const _Expertise({
    required this.expertise,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          t.collaborator.expertise,
          style: Typo.medium.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: Spacing.superExtraSmall),
        Text(
          expertise.join(' , '),
          style: Typo.medium.copyWith(
            color: colorScheme.onSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
