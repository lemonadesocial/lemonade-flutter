import 'package:app/core/domain/collaborator/entities/user_expertise/user_expertise.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/user/entities/user_service_offer.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
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
    final appColors = context.theme.appColors;
    final sections = [
      if (user?.expertiseExpanded?.isNotEmpty == true)
        _Expertise(
          expertises: user?.expertiseExpanded ?? [],
        ),
      if (user?.serviceOffersExpanded?.isNotEmpty == true)
        _Offering(
          serviceOffers: user?.serviceOffersExpanded ?? [],
        ),
    ];
    return Container(
      padding: EdgeInsets.all(Spacing.smMedium),
      decoration: ShapeDecoration(
        color: backgroundColor ?? appColors.cardBg,
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
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.collaborator.offering,
          style: appText.md,
        ),
        SizedBox(height: Spacing.superExtraSmall),
        Text(
          serviceOffers.map((item) => item.title).join(' , '),
          style: appText.md.copyWith(
            color: appColors.textTertiary,
          ),
        ),
      ],
    );
  }
}

class _Expertise extends StatelessWidget {
  final List<UserExpertise> expertises;
  const _Expertise({
    required this.expertises,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          t.collaborator.expertise,
          style: appText.md,
        ),
        SizedBox(height: Spacing.superExtraSmall),
        Text(
          expertises.map((item) => item.title ?? '').join(', '),
          style: appText.md.copyWith(
            color: appColors.textTertiary,
          ),
        ),
      ],
    );
  }
}
