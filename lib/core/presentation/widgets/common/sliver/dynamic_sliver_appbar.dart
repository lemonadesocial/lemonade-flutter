import 'package:flutter/material.dart';

class DynamicSliverAppBar extends SliverAppBar {
  final Widget child;
  final double maxHeight;

  const DynamicSliverAppBar({
    required this.child,
    required this.maxHeight,
    super.key,
    super.forceElevated,
    super.floating,
    super.pinned,
  });

  @override
  DynamicSliverAppBarState createState() => DynamicSliverAppBarState();
}

class DynamicSliverAppBarState extends State<DynamicSliverAppBar> {
  final GlobalKey _childKey = GlobalKey();
  bool isHeightCalculated = false;
  double? height;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!isHeightCalculated) {
        isHeightCalculated = true;
        setState(() {
          height = (_childKey.currentContext?.findRenderObject() as RenderBox)
              .size
              .height;
        });
      }
    });

    return SliverAppBar(
      leading: const SizedBox.shrink(),
      floating: widget.floating,
      forceElevated: widget.forceElevated,
      expandedHeight: isHeightCalculated ? height : widget.maxHeight,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          children: [
            Container(
              key: _childKey,
              child: widget.child,
            ),
            const Expanded(child: SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}
