import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/presentation/widgets/animation/circular_countdown_timer_widget/circular_countdown_timer.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionConfirmingView extends StatelessWidget {
  final int duration;
  final String? txHash;
  final Chain? chain;

  const TransactionConfirmingView({
    super.key,
    required this.duration,
    this.txHash,
    required this.chain,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          // TODO: BE will support return explorer url to view transaction
          // Padding(
          //   padding: EdgeInsets.only(
          //     top: Spacing.smMedium,
          //     right: Spacing.smMedium,
          //   ),
          //   child: Row(
          //     mainAxisSize: MainAxisSize.max,
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       LemonOutlineButton(
          //         onTap: () {
          //         },
          //         backgroundColor: LemonColor.otherMessage,
          //         radius: BorderRadius.circular(LemonRadius.button),
          //         label: t.event.eventBuyTickets.viewTransaction,
          //         textStyle: Typo.small.copyWith(
          //           color: colorScheme.onSecondary,
          //         ),
          //         borderColor: Colors.transparent,
          //         trailing: ThemeSvgIcon(
          //           color: colorScheme.onPrimary,
          //           builder: (colorFilter) => Assets.icons.icExpand.svg(
          //             colorFilter: colorFilter,
          //             width: 9.w,
          //             height: 9.w,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(height: Spacing.xLarge * 2),
          const Spacer(),
          const Spacer(),
          const Spacer(),
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 240.w,
                  height: 240.w,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(220.w),
                    border: Border.all(
                      color: colorScheme.outline,
                      width: 4.w,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: CircularCountDownTimer(
                  width: 240.w,
                  height: 240.w,
                  duration: duration,
                  isReverse: true,
                  isReverseAnimation: true,
                  fillColor: LemonColor.paleViolet,
                  ringColor: Colors.transparent,
                  strokeWidth: 25.w,
                  strokeCap: StrokeCap.round,
                  textStyle: TextStyle(
                    fontSize: 56.sp,
                    color: colorScheme.onPrimary,
                    fontFamily: FontFamily.orbitron,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          const Spacer(),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.smMedium,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  t.event.eventBuyTickets.confirmingTransaction,
                  style: Typo.extraLarge.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontFamily.nohemiVariable,
                  ),
                ),
                SizedBox(height: Spacing.superExtraSmall),
                Text(
                  t.event.eventBuyTickets.confirmingTransactionDescription(
                    duration: prettyDuration(
                      Duration(
                        seconds: duration,
                      ),
                      tersity: DurationTersity.second,
                      upperTersity: DurationTersity.minute,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: Typo.mediumPlus.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
