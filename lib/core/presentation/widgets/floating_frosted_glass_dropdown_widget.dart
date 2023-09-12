import 'package:app/core/presentation/dpos/common/dropdown_item_dpo.dart';
import 'package:app/core/presentation/widgets/frosted_glass_dropdown_widget.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';

class FloatingFrostedGlassDropdown<T> extends StatefulWidget {
  final Widget child;
  final List<DropdownItemDpo<T>> items;
  final Function(DropdownItemDpo<T>? item)? onItemPressed;
  final Offset? offset;

  const FloatingFrostedGlassDropdown({
    super.key,
    required this.items,
    required this.child,
    this.onItemPressed,
    this.offset,
  });

  @override
  State<FloatingFrostedGlassDropdown<T>> createState() =>
      _FloatingFrostedGlassDropdown<T>();
}

class _FloatingFrostedGlassDropdown<T>
    extends State<FloatingFrostedGlassDropdown<T>>
    with TickerProviderStateMixin {
  final GlobalKey _btnKey = GlobalKey();
  bool isVisible = false;
  double y = 0;

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );
  late final Animation<double> _animation =
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return PortalTarget(
      visible: true,
      portalFollower: _buildDropdown(context),
      child: _buildChild(colorScheme),
    );
  }

  GestureDetector _buildChild(ColorScheme colorScheme) {
    return GestureDetector(
      key: _btnKey,
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        await _calculatePosition();
        if (isVisible) return _hide();
        _show();
      },
      child: widget.child,
    );
  }

  Widget _buildDropdown(BuildContext context) {
    return Stack(
      children: [
        _buildBackDrop(),
        Positioned(
          right: Spacing.small,
          top: y + Sizing.medium + (widget.offset?.dy ?? 0),
          child: ScaleTransition(
            alignment: Alignment.topRight,
            scale: _animation,
            child: FrostedGlassDropdown<T>(
              items: widget.items,
              onItemPressed: (item) {
                _hide();
                widget.onItemPressed?.call(item);
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _buildBackDrop() {
    return ScaleTransition(
      alignment: Alignment.topRight,
      scale: _animation,
      child: GestureDetector(
        onTap: () => _hide(),
        child: Container(color: Colors.transparent),
      ),
    );
  }

  _show() {
    isVisible = true;
    _animationController.forward();
  }

  _hide() {
    isVisible = false;
    _animationController.reverse();
  }

  _calculatePosition() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      RenderBox? renderObj =
          _btnKey.currentContext?.findRenderObject() as RenderBox?;
      Offset? position = renderObj?.localToGlobal(Offset.zero);
      setState(() {
        y = position?.dy ?? 150;
      });
    });
    await Future.delayed(const Duration(milliseconds: 100));
  }
}
