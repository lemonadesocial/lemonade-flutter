import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/event/entities/event_session.dart';
import 'package:app/core/presentation/widgets/common/dotted_line/dotted_line.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:app/core/utils/date_utils.dart' as date_utils;

final DATE_CARD_SIZE = 42.w;

class EventProgramWidget extends StatelessWidget {
  final EventSession session;
  final bool? showDate;
  final bool? showDottedLine;
  final int index;
  final bool? showGapBetween;

  const EventProgramWidget({
    super.key,
    required this.session,
    required this.showDate,
    required this.index,
    this.showDottedLine,
    this.showGapBetween,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    DbFile? photo = session.photosExpanded?.isNotEmpty ?? false
        ? session.photosExpanded!.first
        : null;
    final imageUrl = photo?.url ?? '';

    return Stack(
      children: [
        showDottedLine == true
            ? Positioned(
                top: showDate == true ? DATE_CARD_SIZE : 0,
                bottom: 0,
                left: DATE_CARD_SIZE / 2,
                child: DottedLine(
                  lineThickness: 3.w,
                  dashLength: 6.h,
                  dashRadius: 20,
                  dashColor: LemonColor.white09,
                  direction: Axis.vertical,
                  lineLength: double.infinity,
                ),
              )
            : const SizedBox.shrink(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            showDate == true
                ? Container(
                    color: colorScheme.background,
                    width: DATE_CARD_SIZE,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: DATE_CARD_SIZE,
                          height: 18.h,
                          decoration: BoxDecoration(
                            color: LemonColor.chineseBlack,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(LemonRadius.extraSmall),
                              topRight: Radius.circular(LemonRadius.extraSmall),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              session.start != null
                                  ? DateFormat('MMM')
                                      .format(session.start ?? DateTime.now())
                                      .toUpperCase()
                                  : '',
                              style: Typo.small.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: DATE_CARD_SIZE,
                          height: 24.h,
                          decoration: BoxDecoration(
                            color: LemonColor.chineseBlack.withOpacity(0.7),
                            borderRadius: BorderRadius.only(
                              bottomLeft:
                                  Radius.circular(LemonRadius.extraSmall),
                              bottomRight:
                                  Radius.circular(LemonRadius.extraSmall),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              session.start != null
                                  ? session.start!.day.toString()
                                  : '',
                              style: Typo.small.copyWith(
                                fontWeight: FontWeight.w600,
                                fontFamily: FontFamily.nohemiVariable,
                                color: colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    width: DATE_CARD_SIZE,
                  ),
            SizedBox(
              width: Spacing.smMedium,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: showGapBetween == true
                      ? Spacing.large
                      : Spacing.superExtraSmall,
                ),
                child: Container(
                  padding: EdgeInsets.all(Spacing.smMedium),
                  decoration: BoxDecoration(
                    color: LemonColor.white09,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: colorScheme.onPrimary.withOpacity(0.06),
                              borderRadius: BorderRadius.all(
                                Radius.circular(LemonRadius.xSmall),
                              ),
                            ),
                            width: Sizing.medium,
                            height: Sizing.medium,
                            child: Center(
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: imageUrl,
                                errorWidget: (context, url, error) =>
                                    ThemeSvgIcon(
                                  color: colorScheme.onSecondary,
                                  builder: (filter) =>
                                      Assets.icons.icEventExclusive.svg(
                                    colorFilter: filter,
                                    width: 15.w,
                                    height: 15.w,
                                  ),
                                ),
                                placeholder: (context, url) => ThemeSvgIcon(
                                  color: colorScheme.onSecondary,
                                  builder: (filter) =>
                                      Assets.icons.icEventExclusive.svg(
                                    colorFilter: filter,
                                    width: 15.w,
                                    height: 15.w,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Spacing.xSmall,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                date_utils.DateUtils.formatTimeRange(
                                  session.start,
                                  session.end,
                                ),
                                style: Typo.small
                                    .copyWith(color: colorScheme.onSecondary),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Text(
                                session.title ?? '',
                                style: Typo.medium.copyWith(
                                  color: colorScheme.onPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      session.description != null && session.description != ''
                          ? Column(
                              children: [
                                SizedBox(
                                  height: Spacing.extraSmall,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: Sizing.medium + Spacing.xSmall,
                                  ),
                                  child: Text(
                                    session.description ?? '',
                                    style: Typo.small.copyWith(
                                      color: colorScheme.onSecondary,
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                      Padding(
                        padding: EdgeInsets.only(
                          left: Sizing.medium + Spacing.xSmall,
                        ),
                        child: Text(
                          session.description ?? '',
                          style: Typo.small.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        ),
                      ),
                      session.speakerUsersExpanded!.isNotEmpty
                          ? Padding(
                              padding: EdgeInsets.only(
                                top: Spacing.smMedium,
                                left: Sizing.medium + Spacing.xSmall,
                              ),
                              child: SpeakersInfo(
                                session: session,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SpeakersInfo extends StatelessWidget {
  final EventSession session;
  const SpeakersInfo({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Container(
          height: 30.h,
          padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
          decoration: BoxDecoration(
            color: LemonColor.chineseBlack,
            border: Border.all(color: colorScheme.outline),
            borderRadius: BorderRadius.all(Radius.circular(LemonRadius.normal)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                t.event.configuration.speakers,
                style: Typo.xSmall.copyWith(color: colorScheme.onSecondary),
              ),
              _buildSpeakersAvatar(colorScheme),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSpeakersAvatar(ColorScheme colorScheme) {
    final speakers = [...session.speakerUsersExpanded ?? []];
    return SizedBox(
      width: (1 + 1 / 2 * (speakers.length - 1)) * Sizing.small,
      height: 20.w,
      child: Stack(
        children: speakers.asMap().entries.map((entry) {
          final file = (entry.value?.newPhotosExpanded?.isNotEmpty == true)
              ? entry.value?.newPhotosExpanded!.first
              : null;
          return Positioned(
            right: entry.key * 12,
            child: Container(
              width: 18.w,
              height: 18.w,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                border: Border.all(color: colorScheme.onPrimary),
                borderRadius: BorderRadius.circular(Sizing.small),
              ),
              child: LemonCircleAvatar(
                url: ImageUtils.generateUrl(file: file),
                size: Sizing.small,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
