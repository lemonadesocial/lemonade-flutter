import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/widgets/checklist_items/event_publish_cohosts_checklist_item.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/widgets/checklist_items/event_publish_collectible_checklist_item.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/widgets/checklist_items/event_publish_cover_photo_checklist_item.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/widgets/checklist_items/event_publish_faq_checklist_item.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/widgets/checklist_items/event_publish_program_checklist_item.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/widgets/checklist_items/event_publish_rewards_checklist_item.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/widgets/checklist_items/event_publish_speakers_checklist_item.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/widgets/checklist_items/event_publish_ticket_checklist_item.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/widgets/event_publish_checklist_rating_bar.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HostEventPublishFlowPage extends StatelessWidget {
  const HostEventPublishFlowPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    final checklists = [
      const EventPublishTicketChecklistItem(),
      const EventPublishCoverPhotoChecklistItem(),
      const EventPublishCollectibleChecklistItem(),
      const EventPublishRewardsChecklistItem(),
      const EventPublishProgramChecklistItem(),
      const EventPublishCohostsChecklistItem(),
      const EventPublishSpeakersChecklistItem(),
      const EventPublishFAQChecklistItem(),
    ];

    return Scaffold(
      appBar: const LemonAppBar(),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.xSmall,
            ),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        t.event.eventPublish.eventPublishTitle,
                        style: Typo.extraLarge.copyWith(
                          color: colorScheme.onPrimary,
                          fontFamily: FontFamily.nohemiVariable,
                        ),
                      ),
                      SizedBox(height: Spacing.superExtraSmall),
                      Text(
                        t.event.eventPublish.eventPublishDescription,
                        style: Typo.mediumPlus.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    vertical: Spacing.smMedium * 2,
                  ),
                  sliver: const SliverToBoxAdapter(
                    child: EventPublishChecklistRatingBar(),
                  ),
                ),
                SliverList.separated(
                  itemCount: checklists.length,
                  itemBuilder: (context, index) {
                    return checklists[index];
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    height: Spacing.xSmall,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: Spacing.xLarge * 3.5),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(Spacing.smMedium),
              decoration: BoxDecoration(
                color: colorScheme.background,
                border: Border(
                  top: BorderSide(
                    color: colorScheme.outline,
                  ),
                ),
              ),
              child: SafeArea(
                child: LinearGradientButton.primaryButton(
                  label: t.common.actions.publish,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
