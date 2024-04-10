import 'dart:async';

import 'package:app/theme/color.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';

abstract class AppFlowyMobileToolbarWidgetService {
  void closeItemMenu();
  void closeKeyboard();

  PropertyValueNotifier<bool> get showMenuNotifier;
}

// build the toolbar item, like Aa, +, image ...
typedef EditorMobileToolbarItemBuilder = Widget Function(
  BuildContext context,
  EditorState editorState,
  AppFlowyMobileToolbarWidgetService service,
  VoidCallback? onMenuCallback,
  VoidCallback? onActionCallback,
);

// build the menu after clicking the toolbar item
typedef EditorMobileToolbarItemMenuBuilder = Widget Function(
  BuildContext context,
  EditorState editorState,
  AppFlowyMobileToolbarWidgetService service,
);

class EditorMobileToolbarItem {
  /// Tool bar item that implements attribute directly(without opening menu)
  const EditorMobileToolbarItem({
    required this.itemBuilder,
    this.menuBuilder,
    this.pilotAtCollapsedSelection = false,
    this.pilotAtExpandedSelection = false,
  });

  final EditorMobileToolbarItemBuilder itemBuilder;
  final EditorMobileToolbarItemMenuBuilder? menuBuilder;
  final bool pilotAtCollapsedSelection;
  final bool pilotAtExpandedSelection;
}

class EditorMobileToolbarIconItem extends StatefulWidget {
  const EditorMobileToolbarIconItem({
    super.key,
    this.icon,
    this.keepSelectedStatus = false,
    this.iconBuilder,
    this.isSelected,
    this.shouldListenToToggledStyle = false,
    this.enable,
    required this.onTap,
    required this.editorState,
  });

  final IconData? icon;
  final bool keepSelectedStatus;
  final VoidCallback onTap;
  final WidgetBuilder? iconBuilder;
  final bool Function()? isSelected;
  final bool shouldListenToToggledStyle;
  final EditorState editorState;
  final bool Function()? enable;

  @override
  State<EditorMobileToolbarIconItem> createState() =>
      _EditorMobileToolbarIconItemState();
}

class _EditorMobileToolbarIconItemState
    extends State<EditorMobileToolbarIconItem> {
  bool isSelected = false;
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();

    isSelected = widget.isSelected?.call() ?? false;
    if (widget.shouldListenToToggledStyle) {
      widget.editorState.toggledStyleNotifier.addListener(_rebuild);
      _subscription = widget.editorState.transactionStream.listen((_) {
        _rebuild();
      });
    }
  }

  @override
  void dispose() {
    if (widget.shouldListenToToggledStyle) {
      widget.editorState.toggledStyleNotifier.removeListener(_rebuild);
      _subscription?.cancel();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant EditorMobileToolbarIconItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isSelected != null) {
      isSelected = widget.isSelected!.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          widget.onTap();
          _rebuild();
        },
        child: widget.iconBuilder?.call(context) ??
            Container(
              width: 30,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                color: isSelected ? Colors.transparent : Colors.transparent,
              ),
              child: Icon(
                widget.icon!,
                color:
                    isSelected ? LemonColor.paleViolet : LemonColor.cloudyGrey,
              ),
            ),
      ),
    );
  }

  void _rebuild() {
    if (!context.mounted) {
      return;
    }
    setState(() {
      isSelected = (widget.keepSelectedStatus && widget.isSelected == null)
          ? !isSelected
          : widget.isSelected?.call() ?? false;
    });
  }
}
