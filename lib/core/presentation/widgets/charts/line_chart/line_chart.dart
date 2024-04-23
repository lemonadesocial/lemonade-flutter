import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LemonLineChart extends StatefulWidget {
  final List<FlSpot> data;
  final Widget Function(double value, TitleMeta meta) xTitlesWidget;
  final Widget Function(double value, TitleMeta meta) yTitlesWidget;
  final double? minX;
  final double? maxX;
  final double? minY;
  final double? maxY;
  final Color? lineColor;
  final LineTouchData? lineTouchData;
  final bool lineVisible;
  const LemonLineChart({
    super.key,
    required this.data,
    required this.xTitlesWidget,
    required this.yTitlesWidget,
    this.minX,
    this.maxX,
    this.minY,
    this.maxY,
    this.lineColor,
    this.lineTouchData,
    this.lineVisible = true,
  });

  @override
  State<LemonLineChart> createState() => _LemonLineChartState();
}

class _LemonLineChartState extends State<LemonLineChart> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final lineChartBarData = [
      LineChartBarData(
        spots: widget.data,
        isCurved: true,
        color: widget.lineColor,
        barWidth: 5.w,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
          checkToShowDot: (spot, barData) {
            return spot.x == widget.data.last.x && spot.y == widget.data.last.y;
          },
          getDotPainter: (
            FlSpot spot,
            double xPercentage,
            LineChartBarData bar,
            int index, {
            double? size,
          }) {
            return FlDotCirclePainter(
              color: Colors.white,
              radius: 8,
            );
          },
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            transform: const GradientRotation(90),
            colors: [
              Colors.white.withOpacity(0),
              Colors.black.withOpacity(0.4),
            ],
          ),
        ),
      ),
    ];
    return Container(
      padding: EdgeInsets.only(
        top: Spacing.xSmall,
        bottom: Spacing.xSmall,
        left: Spacing.xSmall,
        right: Spacing.medium,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outline),
        borderRadius: BorderRadius.circular(LemonRadius.button),
      ),
      child: Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.5,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Theme.of(context).colorScheme.outline,
                      strokeWidth: 0.2,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: Theme.of(context).colorScheme.outline,
                      strokeWidth: 0.2,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: widget.xTitlesWidget,
                      interval:
                          widget.data.length >= 3 ? widget.data.length / 3 : 1,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: widget.yTitlesWidget,
                    ),
                  ),
                ),
                minX: widget.minX,
                maxX: widget.maxX,
                minY: widget.minY,
                maxY: widget.maxY,
                lineBarsData: widget.lineVisible ? lineChartBarData : [],
                lineTouchData: widget.lineTouchData ??
                    LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        getTooltipColor: (_) => LemonColor.atomicBlack,
                      ),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
