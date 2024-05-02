import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_view.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_icon_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class CollaboratorLikePreviewPage extends StatelessWidget {
  const CollaboratorLikePreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: LemonAppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Spacing.xSmall),
            child: InkWell(
              child: ThemeSvgIcon(
                color: colorScheme.onPrimary,
                builder: (filter) => Assets.icons.icMoreHoriz.svg(
                  colorFilter: filter,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                sliver: const SliverToBoxAdapter(
                  child: _MessagesPreview(),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: Spacing.large),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                sliver: const CollaboratorDiscoverView(),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Spacing.smMedium,
                  horizontal: Spacing.xSmall,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: Sizing.xLarge,
                      height: Sizing.xLarge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Sizing.xLarge),
                        color: colorScheme.background,
                      ),
                      child: LinearGradientIconButton(
                        width: Sizing.xLarge,
                        height: Sizing.xLarge,
                        radius: BorderRadius.circular(Sizing.xLarge),
                        icon: Assets.icons.icClose.svg(),
                      ),
                    ),
                    LinearGradientIconButton(
                      width: Sizing.xLarge,
                      height: Sizing.xLarge,
                      radius: BorderRadius.circular(Sizing.xLarge),
                      icon: Assets.icons.icChatBubble.svg(),
                      mode: GradientButtonMode.lavenderMode,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessagesPreview extends StatelessWidget {
  const _MessagesPreview();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(Spacing.xSmall),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(LemonRadius.small),
            color: LemonColor.atomicBlack,
          ),
          child: Text(
            t.collaborator.likedYourProfile,
            style: Typo.medium.copyWith(
              color: colorScheme.onSecondary,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        SizedBox(height: 2.w),
        Container(
          padding: EdgeInsets.all(Spacing.xSmall),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(LemonRadius.small),
            color: LemonColor.atomicBlack,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.collaborator.needHelpWith,
                style: Typo.medium.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
              Text(
                'Design advice, Financial advice',
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 2.w),
        Container(
          padding: EdgeInsets.all(Spacing.xSmall),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(LemonRadius.small),
            color: colorScheme.surface,
          ),
          child: Text(
            'Hey! We are build the worlds biggest automobile brand in the world! Would you like to join us?',
            style: Typo.medium.copyWith(
              color: colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
