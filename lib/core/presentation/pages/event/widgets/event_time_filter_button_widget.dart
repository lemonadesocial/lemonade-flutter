import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/core/presentation/dpos/common/dropdown_item_dpo.dart';
import 'package:app/core/presentation/widgets/frosted_glass_dropdown_widget.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';

class EventTimeFilterButton extends StatefulWidget {
  final Function(EventTimeFilter? eventTimeFilter)? onSelect;
  const EventTimeFilterButton({
    super.key,
    this.onSelect,
  });

  @override
  State<EventTimeFilterButton> createState() => _EventTimeFilterButtonState();
}

class _EventTimeFilterButtonState extends State<EventTimeFilterButton>
    with TickerProviderStateMixin {
  final GlobalKey _btnKey = GlobalKey();
  bool isVisible = false;
  double y = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

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
      child: _buildButton(colorScheme),
    );
  }

  GestureDetector _buildButton(ColorScheme colorScheme) {
    return GestureDetector(
      key: _btnKey,
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        await _calculatePosition();
        if (isVisible) return _hide();
        _show();
      },
      child: SizedBox(
        width: Sizing.medium,
        height: Sizing.medium,
        child: Center(
          child: Assets.icons.icFilter.svg(
            width: 18,
            height: 18,
            colorFilter:
                ColorFilter.mode(colorScheme.onSecondary, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(BuildContext context) {
    final t = Translations.of(context);
    return Stack(
      children: [
        _buildBackDrop(),
        Positioned(
          right: Spacing.small,
          top: y + Sizing.medium,
          child: ScaleTransition(
            alignment: Alignment.topRight,
            scale: _animation,
            child: FrostedGlassDropdown<EventTimeFilter>(
              isEqual: (a, b) => a.value == b.value,
              items: EventTimeFilter.values
                  .map(
                    (filter) => DropdownItemDpo<EventTimeFilter>(
                      label: t['common.${filter.labelKey}'],
                      value: filter,
                    ),
                  )
                  .toList(),
              onItemPressed: (filterItem) {
                widget.onSelect?.call(filterItem?.value);
                _hide();
              },
            ),
          ),
        ),
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

  void _show() {
    if (!mounted) return;
    setState(() {
      isVisible = true;
    });
    _animationController.forward();
  }

  void _hide() {
    if (!mounted) return;
    setState(() {
      isVisible = false;
    });
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
