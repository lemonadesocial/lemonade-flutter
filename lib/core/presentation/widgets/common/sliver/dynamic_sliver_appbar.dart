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
  double? height;

  @override
  void initState() {
    super.initState();
    calculateHeight();
  }

  @override
  void didUpdateWidget(DynamicSliverAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    calculateHeight();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: const SizedBox.shrink(),
      floating: widget.floating,
      forceElevated: widget.forceElevated,
      expandedHeight: height ?? widget.maxHeight,
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

  void calculateHeight() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        height = (_childKey.currentContext?.findRenderObject() as RenderBox)
            .size
            .height;
      });
    });
  }
}
