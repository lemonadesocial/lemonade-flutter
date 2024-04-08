import 'package:app/core/presentation/widgets/common/editor/editor_mobile_toolbar_item.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';

final boldToolbarItem = MobileToolbarItem.action(
  itemIconBuilder: (context, editorState, ___) {
    return EditorMobileToolbarIconItem(
      editorState: editorState,
      shouldListenToToggledStyle: true,
      isSelected: () =>
          editorState.isTextDecorationSelected(
            AppFlowyRichTextKeys.bold,
          ) &&
          editorState.toggledStyle[AppFlowyRichTextKeys.bold] != false,
      icon: Icons.format_bold_rounded,
      onTap: () async => editorState.toggleAttribute(
        AppFlowyRichTextKeys.bold,
        selectionExtraInfo: {
          selectionExtraInfoDisableFloatingToolbar: true,
        },
      ),
    );
  },
  actionHandler: (context, editorState) async {},
);

final italicToolbarItem = MobileToolbarItem.action(
  itemIconBuilder: (context, editorState, ___) {
    return EditorMobileToolbarIconItem(
      editorState: editorState,
      shouldListenToToggledStyle: true,
      isSelected: () => editorState.isTextDecorationSelected(
        AppFlowyRichTextKeys.italic,
      ),
      icon: Icons.format_italic_rounded,
      onTap: () async => editorState.toggleAttribute(
        AppFlowyRichTextKeys.italic,
        selectionExtraInfo: {
          selectionExtraInfoDisableFloatingToolbar: true,
        },
      ),
    );
  },
  actionHandler: (BuildContext context, EditorState editorState) {},
);

final underlineToolbarItem = MobileToolbarItem.action(
  itemIconBuilder: (context, editorState, ___) {
    return EditorMobileToolbarIconItem(
      editorState: editorState,
      shouldListenToToggledStyle: true,
      isSelected: () => editorState.isTextDecorationSelected(
        AppFlowyRichTextKeys.underline,
      ),
      icon: Icons.format_underlined_rounded,
      onTap: () async => editorState.toggleAttribute(
        AppFlowyRichTextKeys.underline,
        selectionExtraInfo: {
          selectionExtraInfoDisableFloatingToolbar: true,
        },
      ),
    );
  },
  actionHandler: (BuildContext context, EditorState editorState) {},
);

final bulletedListToolbarItem = MobileToolbarItem.action(
  itemIconBuilder: (context, editorState, ___) {
    final isSelected =
        editorState.isBlockTypeSelected(BulletedListBlockKeys.type);
    return EditorMobileToolbarIconItem(
      editorState: editorState,
      shouldListenToToggledStyle: true,
      isSelected: () => isSelected,
      icon: Icons.format_list_bulleted_rounded,
      onTap: () async => {
        await editorState.convertBlockType(
          BulletedListBlockKeys.type,
        ),
      },
    );
  },
  actionHandler: (BuildContext context, EditorState editorState) {},
);

final numberedToolbarItem = MobileToolbarItem.action(
  itemIconBuilder: (context, editorState, ___) {
    final isSelected =
        editorState.isBlockTypeSelected(NumberedListBlockKeys.type);
    return EditorMobileToolbarIconItem(
      editorState: editorState,
      shouldListenToToggledStyle: true,
      isSelected: () => isSelected,
      icon: Icons.format_list_numbered_rounded,
      onTap: () async => {
        await editorState.convertBlockType(
          NumberedListBlockKeys.type,
        ),
      },
    );
  },
  actionHandler: (BuildContext context, EditorState editorState) {},
);

final _blocksCanContainChildren = [
  ParagraphBlockKeys.type,
  BulletedListBlockKeys.type,
  NumberedListBlockKeys.type,
  TodoListBlockKeys.type,
];

extension MobileToolbarEditorState on EditorState {
  bool isBlockTypeSelected(
    String blockType, {
    int? level,
  }) {
    final selection = this.selection;
    if (selection == null) {
      return false;
    }
    final node = getNodeAtPath(selection.start.path);
    final type = node?.type;
    if (node == null || type == null) {
      return false;
    }
    if (level != null && blockType == HeadingBlockKeys.type) {
      return type == blockType &&
          node.attributes[HeadingBlockKeys.level] == level;
    }
    return type == blockType;
  }

  bool isTextDecorationSelected(
    String richTextKey,
  ) {
    final selection = this.selection;
    if (selection == null) {
      return false;
    }

    final nodes = getNodesInSelection(selection);
    bool isSelected = false;
    if (selection.isCollapsed) {
      if (toggledStyle.containsKey(richTextKey)) {
        isSelected = toggledStyle[richTextKey] as bool;
      } else {
        if (selection.startIndex != 0) {
          // get previous index text style
          isSelected = nodes.allSatisfyInSelection(
              selection.copyWith(
                start: selection.start.copyWith(
                  offset: selection.startIndex - 1,
                ),
              ), (delta) {
            return delta.everyAttributes(
              (attributes) => attributes[richTextKey] == true,
            );
          });
        }
      }
    } else {
      isSelected = nodes.allSatisfyInSelection(selection, (delta) {
        return delta.everyAttributes(
          (attributes) => attributes[richTextKey] == true,
        );
      });
    }
    return isSelected;
  }

  Future<void> convertBlockType(
    String newBlockType, {
    Selection? selection,
    Attributes? extraAttributes,
    bool? isSelected,
    Map? selectionExtraInfo,
  }) async {
    selection = selection ?? this.selection;
    if (selection == null) {
      return;
    }
    final node = getNodeAtPath(selection.start.path);
    final type = node?.type;
    if (node == null || type == null) {
      assert(false, 'node or type is null');
      return;
    }
    final selected = isSelected ?? type == newBlockType;

    // if the new block type can't contain children, we need to move all the children to the parent
    bool needToDeleteChildren = false;
    if (!selected &&
        node.children.isNotEmpty &&
        !_blocksCanContainChildren.contains(newBlockType)) {
      final transaction = this.transaction;
      needToDeleteChildren = true;
      transaction.insertNodes(
        selection.end.path.next,
        node.children.map((e) => e.copyWith()),
      );
      await apply(transaction);
    }
    await formatNode(
      selection,
      (node) {
        final attributes = {
          ParagraphBlockKeys.delta: (node.delta ?? Delta()).toJson(),
          // for some block types, they have extra attributes, like todo list has checked attribute, callout has icon attribute, etc.
          if (!selected && extraAttributes != null) ...extraAttributes,
        };
        return node.copyWith(
          type: selected ? ParagraphBlockKeys.type : newBlockType,
          attributes: attributes,
          children: needToDeleteChildren ? [] : null,
        );
      },
      selectionExtraInfo: selectionExtraInfo,
    );
  }
}
