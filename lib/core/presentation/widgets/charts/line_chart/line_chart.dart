import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LemonLineChart extends StatefulWidget {
  final Color? lineColor;
  final Widget Function(double value, TitleMeta meta) xTitlesWidget;
  final Widget Function(double value, TitleMeta meta) yTitlesWidget;
  final double? minX;
  final double? maxX;
  final double? minY;
  final double? maxY;
  final List<FlSpot> data;
  const LemonLineChart({
    super.key,
    required this.data,
    required this.xTitlesWidget,
    required this.yTitlesWidget,
    this.lineColor,
    this.minX,
    this.maxX,
    this.minY,
    this.maxY,
  });

  @override
  State<LemonLineChart> createState() => _LemonLineChartState();
}

class _LemonLineChartState extends State<LemonLineChart> {
  @override
  Widget build(BuildContext context) {
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
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.5,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
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
                    reservedSize: 30,
                    interval: 1,
                    getTitlesWidget: widget.xTitlesWidget,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: widget.yTitlesWidget,
                    reservedSize: 42,
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
              // minX: 0,
              // maxX: 8,
              // minY: 0,
              // maxY: 50,
              lineBarsData: lineChartBarData,
            ),
          ),
        ),
      ],
    );
  }
}
