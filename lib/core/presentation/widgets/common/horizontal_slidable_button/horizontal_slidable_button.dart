import 'package:flutter/material.dart';

import 'package:app/core/presentation/widgets/common/horizontal_slidable_button/slidable_button_clipper.dart';
import 'package:app/core/presentation/widgets/common/horizontal_slidable_button/slidable_button_simulation.dart';

/// Position of button which on the left or right
enum SlidableButtonPosition {
  start,
  center,
  end,

  /// Only available if `tristate` is true
  sliding,
}

class HorizontalSlidableButton extends StatefulWidget {
  /// Label of the button.
  final Widget? label;

  /// A widget that is behind the button.
  final Widget? child;

  /// Button color if it disabled.
  ///
  /// [disabledColor] is set to `Colors.grey` by default.
  final Color? disabledColor;

  /// The color of button.
  ///
  /// If null, it will be transparent.
  final Color? buttonColor;

  /// The color of background.
  ///
  /// If null, it will be transparent.
  final Color? color;

  /// Border of area slide (usually called background).
  final BoxBorder? border;

  /// Border Radius for the button and it's child.
  ///
  /// Default value is `const BorderRadius.all(const Radius.circular(60.0))`
  final BorderRadius borderRadius;

  /// The height of this widget (button and it's background).
  ///
  /// Default value is 36.0.
  final double height;

  /// Width of area slide (usually called background).
  ///
  /// Default value is 120.0.
  final double width;

  /// Width of button. If [buttonWidth] is still null and the [label] is not null, this will automatically wrapping [label].
  ///
  /// The minimum size is [height], and the maximum size is three quarters from [width].
  final double? buttonWidth;

  /// Height of button.
  final double? buttonHeight;

  /// It means the effect while and after sliding.
  ///
  /// If `true`, [child] will disappear along with button sliding. Otherwise, it stay visible even the button was slide.
  final bool dismissible;

  /// Initial button position. It can on the left or right.
  final SlidableButtonPosition initialPosition;

  /// The % at which the slide gesture should be considered as completed (0 to 1)
  ///
  /// Default value is 0.5.
  final double completeSlideAt;

  /// Listen to position, is button on the left or right.
  ///
  /// You must set this argument although is null.
  final ValueChanged<SlidableButtonPosition>? onChanged;

  /// Controller for the button while sliding.
  final AnimationController? controller;

  /// Restart animation when the position is opposite to initialPosition
  ///
  /// Default value false
  final bool isRestart;

  /// If true the button's position can be left, right, or sliding. Otherwise only left or right.
  ///
  /// Default value false
  final bool tristate;

  /// Button will auto slide to nearest point after drag released if true, otherwise will not slide.
  ///
  /// Default value true
  final bool autoSlide;

  /// Whether the button can be stopped at center position.
  ///
  /// This will ignore and lock [completeSlideAt] to default value.
  ///
  /// Default value false
  final bool centerPoint;

  /// Creates a [HorizontalSlidableButton]
  const HorizontalSlidableButton({
    super.key,
    required this.onChanged,
    this.controller,
    this.child,
    this.autoSlide = true,
    this.disabledColor,
    this.buttonColor,
    this.color,
    this.label,
    this.border,
    this.borderRadius = const BorderRadius.all(Radius.circular(60.0)),
    this.initialPosition = SlidableButtonPosition.start,
    double completeSlideAt = 0.5,
    this.height = 36.0,
    this.width = 120.0,
    this.buttonWidth,
    this.buttonHeight,
    this.dismissible = true,
    this.isRestart = false,
    this.tristate = false,
    this.centerPoint = false,
  }) : completeSlideAt = centerPoint ? 0.5 : completeSlideAt;

  @override
  State<HorizontalSlidableButton> createState() =>
      _HorizontalSlidableButtonState();
}

class _HorizontalSlidableButtonState extends State<HorizontalSlidableButton>
    with SingleTickerProviderStateMixin {
  final GlobalKey _containerKey = GlobalKey();
  final GlobalKey _positionedKey = GlobalKey();

  late final AnimationController _controller;
  late Animation<double> _contentAnimation;
  Offset _start = Offset.zero;
  bool _isSliding = false;

  RenderBox? get _positioned =>
      _positionedKey.currentContext!.findRenderObject() as RenderBox?;

  RenderBox? get _container =>
      _containerKey.currentContext!.findRenderObject() as RenderBox?;

  double get _buttonWidth {
    final width = widget.buttonWidth ?? double.minPositive;
    final maxWidth = widget.width * 3 / 4;
    if (width > maxWidth) return maxWidth;
    return width;
  }

  double get _buttonHeight => widget.buttonHeight ?? widget.height;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? AnimationController.unbounded(vsync: this);
    _contentAnimation = Tween<double>(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _initialPositionController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant HorizontalSlidableButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialPosition != oldWidget.initialPosition) {
      _initialPositionController();
    }
  }

  void _initialPositionController() {
    switch (widget.initialPosition) {
      case SlidableButtonPosition.start:
        _controller.value = 0.0;
        break;
      case SlidableButtonPosition.center:
        _controller.value = 0.5;
        break;
      case SlidableButtonPosition.end:
        _controller.value = 1.0;
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        border: widget.border,
        borderRadius: widget.borderRadius,
      ),
      child: Stack(
        key: _containerKey,
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: widget.borderRadius,
            ),
            child: widget.dismissible
                ? ClipRRect(
                    clipper: SlidableButtonClipper(
                      animation: _controller,
                      borderRadius: widget.borderRadius,
                    ),
                    borderRadius: widget.borderRadius,
                    child: SizedBox.expand(
                      child: FadeTransition(
                        opacity: _contentAnimation,
                        child: widget.child,
                      ),
                    ),
                  )
                : SizedBox.expand(child: widget.child),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) => Align(
              alignment: Alignment((_controller.value * 2.0) - 1.0, 0.0),
              child: child,
            ),
            child: Container(
              key: _positionedKey,
              height: _buttonHeight,
              width: _buttonWidth,
              decoration: BoxDecoration(
                borderRadius: widget.borderRadius,
                color: widget.onChanged == null
                    ? widget.disabledColor ?? Colors.grey
                    : widget.buttonColor,
              ),
              child: widget.onChanged == null
                  ? Center(child: widget.label)
                  : GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onHorizontalDragStart: _onDragStart,
                      onHorizontalDragUpdate: _onDragUpdate,
                      onHorizontalDragEnd: _onDragEnd,
                      child: Center(child: widget.label),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    final pos = _positioned!.globalToLocal(details.globalPosition);
    _start = Offset(pos.dx, 0.0);
    _controller.stop(canceled: true);
  }

  void _onDragUpdate(DragUpdateDetails details) {
    final pos = _container!.globalToLocal(details.globalPosition) - _start;
    final extent = _container!.size.width - _positioned!.size.width;
    _controller.value = (pos.dx.clamp(0.0, extent) / extent);

    if (widget.tristate && !_isSliding) {
      _isSliding = true;
      _onChanged(SlidableButtonPosition.sliding);
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (!widget.autoSlide) return _afterDragEnd();

    if (widget.centerPoint) {
      if (_controller.value > 0.25 && _controller.value < 0.75) {
        _controller
            .animateTo(
              0.5,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            )
            .whenComplete(_afterDragEnd);
        return;
      }
    }

    final extent = _container!.size.width - _positioned!.size.width;
    double fractionalVelocity = (details.primaryVelocity! / extent).abs();
    if (fractionalVelocity < 0.5) {
      fractionalVelocity = 0.5;
    }

    double acceleration, velocity;
    if (_controller.value >= widget.completeSlideAt) {
      acceleration = 0.5;
      velocity = fractionalVelocity;
    } else {
      acceleration = -0.5;
      velocity = -fractionalVelocity;
    }

    final simulation = SlidableSimulation(
      acceleration,
      _controller.value,
      1.0,
      velocity,
    );

    _controller.animateWith(simulation).whenComplete(_afterDragEnd);
  }

  void _afterDragEnd() {
    final SlidableButtonPosition position;

    if (_controller.value > 0.5) {
      position = SlidableButtonPosition.end;
    } else {
      if (widget.centerPoint && _controller.value == 0.5) {
        position = SlidableButtonPosition.center;
      } else {
        position = SlidableButtonPosition.start;
      }
    }

    if (widget.isRestart && widget.initialPosition != position) {
      _initialPositionController();
    }

    _isSliding = false;

    _onChanged(position);
  }

  void _onChanged(SlidableButtonPosition position) {
    if (widget.onChanged != null) {
      widget.onChanged!(position);
    }
  }
}
