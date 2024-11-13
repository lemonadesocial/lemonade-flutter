import 'package:app/core/domain/event/entities/event_payment_ticket_discount.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

double ticketLeftSideSize = 75.w;
double triangleWidth = 18.w;

class EventDiscountItem extends StatelessWidget {
  final EventPaymentTicketDiscount discount;
  const EventDiscountItem({
    super.key,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final discountPercentage = ((discount.ratio ?? 0) * 100).toInt();
    final highlighted = discountPercentage >= 20;

    return InkWell(
      onTap: () => AutoRouter.of(context).push(
        EventDiscountFormSettingRoute(
          discount: discount,
        ),
      ),
      child: Stack(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                children: [
                  CustomPaint(
                    size: Size(ticketLeftSideSize, ticketLeftSideSize),
                    painter: DiscountLeftSidePainterWidget(
                      backgroundColor: highlighted
                          ? LemonColor.paleViolet18
                          : colorScheme.secondaryContainer,
                    ),
                  ),
                  Positioned.fill(
                    child: Center(
                      child: Text(
                        '$discountPercentage%',
                        style: Typo.medium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: highlighted
                              ? LemonColor.paleViolet
                              : colorScheme.onSecondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  height: 75.w,
                  padding: EdgeInsets.all(Spacing.small),
                  decoration: BoxDecoration(
                    color: LemonColor.atomicBlack,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(LemonRadius.medium),
                      bottomRight: Radius.circular(LemonRadius.medium),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              discount.code ?? '',
                              style: Typo.medium.copyWith(
                                fontWeight: FontWeight.w600,
                                color: colorScheme.onPrimary,
                              ),
                              maxLines: 1,
                            ),
                            SizedBox(height: 2.w),
                            Text(
                              t.event.eventPromotions.usedCount(
                                count: discount.useCount?.toInt() ?? 0,
                                total: discount.ticketLimit?.toInt() ?? 0,
                              ),
                              style: Typo.medium.copyWith(
                                color: colorScheme.onSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ThemeSvgIcon(
                        color: colorScheme.onSecondary,
                        builder: (colorFilter) => Assets.icons.icArrowRight.svg(
                          colorFilter: colorFilter,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: ticketLeftSideSize - triangleWidth / 2,
            child: CustomPaint(
              size: Size(triangleWidth, 9.w),
              painter: _TrianglePainterWidget(
                backgroundColor: colorScheme.background,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 75.w - 9.w,
            child: RotatedBox(
              quarterTurns: 2,
              child: CustomPaint(
                size: Size(triangleWidth, 9.w),
                painter: _TrianglePainterWidget(
                  backgroundColor: colorScheme.background,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DiscountLeftSidePainterWidget extends CustomPainter {
  final Color? backgroundColor;
  DiscountLeftSidePainterWidget({
    this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.08000000, size.height * 0.6250000);
    path_0.lineTo(0, size.height * 0.7500000);
    path_0.lineTo(size.width * 0.08000000, size.height * 0.8750000);
    path_0.lineTo(0, size.height);
    path_0.lineTo(size.width * 0.08000000, size.height);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width * 0.08000000, 0);
    path_0.lineTo(0, 0);
    path_0.lineTo(size.width * 0.08000000, size.height * 0.1250000);
    path_0.lineTo(0, size.height * 0.2500000);
    path_0.lineTo(size.width * 0.08000000, size.height * 0.3750000);
    path_0.lineTo(0, size.height * 0.5000000);
    path_0.lineTo(size.width * 0.08000000, size.height * 0.6250000);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = backgroundColor ?? Colors.white.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

//Copy this CustomPainter code to the Bottom of the File
class _TrianglePainterWidget extends CustomPainter {
  final Color? backgroundColor;

  _TrianglePainterWidget({
    this.backgroundColor,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, 0);
    path_0.lineTo(size.width * 0.5000000, size.height);
    path_0.lineTo(0, 0);
    path_0.lineTo(size.width, 0);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = backgroundColor ?? Colors.black.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
