import 'package:app/core/presentation/widgets/common/dotted_line/dotted_line.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTicketCard extends StatelessWidget {
  const MyTicketCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        const TicketCardTop(),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15.w),
          child: DottedLine(
            lineThickness: 2.w,
            dashRadius: 10,
            dashLength: 8.w,
            dashGapColor: colorScheme.onPrimary.withOpacity(0.06),
            dashColor: colorScheme.background,
          ),
        ),
        const TicketCardBottom(),
      ],
    );
  }
}

class TicketCardTop extends StatelessWidget {
  const TicketCardTop({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: colorScheme.onPrimary.withOpacity(0.06),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.r),
          topRight: Radius.circular(15.r),
        ),
      ),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(Spacing.medium),
            child: Row(
              children: [
                Container(
                  width: 42.w,
                  height: 42.w,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://s3-alpha-sig.figma.com/img/8448/74ff/afa063f89d78e9f9137eb4b299f6643c?Expires=1696204800&Signature=NRQC5vG1JIAcF9Yd4TeIJTXxU2c1yxQTm-n14IBB6NYqPmX8wWQ5~SbSfuJ-RfDIPUMhJjIBhzUV-ifKCSyDeimfyh0jZ-W5yWawNFyicnAIbKeuA9Fu9qvjebqI2y2mzCkRCi1qa0AWRcN9DZVGnSrWyBHojDyyYEFA5nY-dl263a9P~PDSL4v3G-83CFu2fuX6OIoT3uNUiF4yRXFwjRuYJrLSUrTPM~3onkWkiDTmp6O2R51czghgCJ1MNZeFzlIi8HNJfgmLaq5S-dZKweO6BuPx0vhCCd3OsQSaA8CeXbuyLhCPdtJTGdV8LHigFhLuNYlrTmxamb09zcI8oQ__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4",
                    errorWidget: (_, __, ___) =>
                        ImagePlaceholder.defaultPlaceholder(),
                    placeholder: (_, __) =>
                        ImagePlaceholder.defaultPlaceholder(),
                  ),
                ),
                SizedBox(width: Spacing.small),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Culture fest',
                      style: Typo.mediumPlus.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 2.w,
                    ),
                    Text(
                      'Festival pass',
                      style: Typo.medium.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            bottom: -15.w,
            left: -15.w,
            child: const _Circle(),
          ),
          Positioned(
            bottom: -15.w,
            right: -15.w,
            // alignment: Alignment.bottomLeft,
            child: const _Circle(),
          ),
        ],
      ),
    );
  }
}

class TicketCardBottom extends StatelessWidget {
  const TicketCardBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final labelTextStyle = Typo.small.copyWith(
      color: colorScheme.onSurfaceVariant,
    );
    final valueTextStyle = Typo.medium.copyWith(
      color: colorScheme.onPrimary.withOpacity(0.87),
    );
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: colorScheme.onPrimary.withOpacity(0.06),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.r),
          bottomRight: Radius.circular(15.r),
        ),
      ),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(Spacing.medium),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 80.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Date',
                                  style: labelTextStyle,
                                ),
                                SizedBox(height: 2.w),
                                Text(
                                  '1 Sep, 23 -\n3 Sep, 23',
                                  style: valueTextStyle,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: Spacing.xSmall),
                          SizedBox(
                            width: 80.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Time',
                                  style: labelTextStyle,
                                ),
                                SizedBox(height: 2.w),
                                Text(
                                  '8:00PM\nIST',
                                  style: valueTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Spacing.xSmall),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Location',
                            style: labelTextStyle,
                          ),
                          SizedBox(height: 2.w),
                          Text(
                            'Nomad bar',
                            style: valueTextStyle,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                //TODO: Fake QR code
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 100.w,
                    height: 100.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(LemonRadius.extraSmall),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -15.w,
            left: -15.w,
            child: const _Circle(),
          ),
          Positioned(
            top: -15.w,
            right: -15.w,
            // alignment: Alignment.bottomLeft,
            child: const _Circle(),
          ),
        ],
      ),
    );
  }
}

class _Circle extends StatelessWidget {
  const _Circle();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 30.w,
      height: 30.w,
      decoration: BoxDecoration(
        color: colorScheme.background,
        borderRadius: BorderRadius.circular(30.r),
      ),
    );
  }
}
