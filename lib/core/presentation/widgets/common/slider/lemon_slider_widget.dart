import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:flutter/material.dart';

class LemonSlider extends StatefulWidget {
  const LemonSlider({
    super.key,
    required this.min,
    required this.max,
    this.defaultValue,
    this.onChange,
  });
  final double min;
  final double max;
  final double? defaultValue;
  final Function(double value)? onChange;

  @override
  State<LemonSlider> createState() => _LemonSliderState();
}

class _LemonSliderState extends State<LemonSlider> {
  late double _value = widget.defaultValue ?? widget.min;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: Sizing.small,
      child: SliderTheme(
        data: SliderThemeData(
          trackShape: _CustomTrackShape(),
          trackHeight: 2,
          overlayColor: Colors.transparent,
          activeTrackColor: LemonColor.sunrise,
          inactiveTrackColor: LemonColor.sunrise18,
          thumbColor: colorScheme.onPrimary,
        ),
        child: Slider(
          value: _value,
          onChanged: (v) {
            widget.onChange?.call(v);
            setState(() {
              _value = v;
            });
          },
          min: widget.min,
          max: widget.max,
        ),
      ),
    );
  }
}

class _CustomTrackShape extends RoundedRectSliderTrackShape {
  _CustomTrackShape();

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 0,
  }) {
    return super.paint(
      context,
      offset,
      parentBox: parentBox,
      sliderTheme: sliderTheme,
      enableAnimation: enableAnimation,
      textDirection: textDirection,
      thumbCenter: thumbCenter,
      additionalActiveTrackHeight: 0,
    );
  }
}
