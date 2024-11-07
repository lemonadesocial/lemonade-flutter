import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CreateDuplicatedSubEventsSuccessPage extends StatelessWidget {
  final List<DateTime> dates;
  final List<String> eventIds;
  final Event originalSubEvent;
  const CreateDuplicatedSubEventsSuccessPage({
    super.key,
    required this.dates,
    required this.eventIds,
    required this.originalSubEvent,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: const LemonAppBar(
        title: '',
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: Spacing.small),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.event.sessionDuplication.duplicateSuccess,
                  style: Typo.extraLarge.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
                SizedBox(height: 4.w),
                Text(
                  t.event.sessionDuplication.duplicateSuccessDescription(
                    n: dates.length,
                  ),
                  style: Typo.medium.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
                SizedBox(height: Spacing.medium),
                Container(
                  padding: EdgeInsets.all(Spacing.small),
                  decoration: BoxDecoration(
                    color: LemonColor.atomicBlack,
                    borderRadius: BorderRadius.circular(LemonRadius.medium),
                    border: Border.all(
                      color: colorScheme.outlineVariant,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LemonNetworkImage(
                        width: Sizing.medium,
                        height: Sizing.medium,
                        border: Border.all(
                          color: colorScheme.outlineVariant,
                        ),
                        borderRadius:
                            BorderRadius.circular(LemonRadius.extraSmall),
                        imageUrl: EventUtils.getEventThumbnailUrl(
                          event: originalSubEvent,
                        ),
                        placeholder: ImagePlaceholder.eventCard(),
                      ),
                      SizedBox(width: Spacing.small),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              originalSubEvent.title ?? '',
                              style: Typo.medium.copyWith(
                                color: colorScheme.onPrimary,
                              ),
                            ),
                            SizedBox(height: 2.w),
                            Text(
                              t.event.virtual,
                              style: Typo.small.copyWith(
                                color: colorScheme.onSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Spacing.medium),
                Text(
                  t.event.sessionDuplication.newTimes(n: dates.length),
                  style: Typo.medium.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
                SizedBox(height: Spacing.xSmall),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        AutoRouter.of(context).replace(
                          EventDetailRoute(
                            eventId: eventIds[index],
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(Spacing.small),
                        decoration: BoxDecoration(
                          color: LemonColor.atomicBlack,
                          borderRadius:
                              BorderRadius.circular(LemonRadius.medium),
                          border: Border.all(
                            color: colorScheme.outlineVariant,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              DateFormat('EEE MMMM d').format(dates[index]),
                              style: Typo.medium.copyWith(
                                color: colorScheme.onPrimary,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              DateFormat('h:mm a').format(dates[index]),
                              style: Typo.medium.copyWith(
                                color: colorScheme.onSecondary,
                              ),
                            ),
                            SizedBox(width: Spacing.extraSmall),
                            Assets.icons.icExpand.svg(),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    height: Spacing.xSmall,
                  ),
                  itemCount: dates.length,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(
                left: Spacing.small,
                right: Spacing.small,
                top: Spacing.smMedium,
              ),
              decoration: BoxDecoration(
                color: colorScheme.background,
                border: Border(top: BorderSide(color: colorScheme.outline)),
              ),
              child: SafeArea(
                top: false,
                child: LinearGradientButton.secondaryButton(
                  mode: GradientButtonMode.light,
                  label: t.common.done,
                  onTap: () {
                    AutoRouter.of(context).pop();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
