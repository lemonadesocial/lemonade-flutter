import 'package:app/core/presentation/widgets/common/editor/custom_text_decoration_items.dart';
import 'package:app/core/presentation/widgets/common/editor/editor_mobile_toolbar.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MobileEditor extends StatefulWidget {
  const MobileEditor({
    super.key,
    required this.editorState,
    this.editorStyle,
    this.autoFocus,
  });

  final EditorState editorState;
  final EditorStyle? editorStyle;
  final bool? autoFocus;

  @override
  State<MobileEditor> createState() => _MobileEditorState();
}

class _MobileEditorState extends State<MobileEditor> {
  EditorState get editorState => widget.editorState;

  late final EditorScrollController editorScrollController;

  late EditorStyle editorStyle;
  late Map<String, BlockComponentBuilder> blockComponentBuilders;

  @override
  void initState() {
    super.initState();

    editorScrollController = EditorScrollController(
      editorState: editorState,
      shrinkWrap: false,
    );

    editorStyle = _buildMobileEditorStyle();
    blockComponentBuilders = _buildBlockComponentBuilders();
  }

  @override
  void reassemble() {
    super.reassemble();

    editorStyle = _buildMobileEditorStyle();
    blockComponentBuilders = _buildBlockComponentBuilders();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    assert(PlatformExtension.isMobile);
    return EditorMobileToolbar(
      toolbarHeight: 55.0,
      backgroundColor: colorScheme.secondaryContainer,
      iconColor: colorScheme.secondaryContainer,
      itemOutlineColor: Colors.transparent,
      outlineColor: Colors.transparent,
      buttonBorderWidth: 0,
      buttonSelectedBorderWidth: 0,
      buttonHeight: 55.0,
      toolbarItems: [
        boldToolbarItem,
        italicToolbarItem,
        bulletedListToolbarItem,
        numberedToolbarItem,
      ],
      editorState: editorState,
      child: Column(
        children: [
          // build appflowy editor
          Expanded(
            child: MobileFloatingToolbar(
              editorState: editorState,
              editorScrollController: editorScrollController,
              toolbarBuilder: (context, anchor, closeToolbar) {
                return AdaptiveTextSelectionToolbar.editable(
                  clipboardStatus: ClipboardStatus.pasteable,
                  onCopy: () {
                    copyCommand.execute(editorState);
                    closeToolbar();
                  },
                  onCut: () => cutCommand.execute(editorState),
                  onPaste: () => pasteCommand.execute(editorState),
                  onSelectAll: () => selectAllCommand.execute(editorState),
                  onLiveTextInput: null,
                  onLookUp: null,
                  onSearchWeb: null,
                  onShare: null,
                  anchors: TextSelectionToolbarAnchors(
                    primaryAnchor: anchor,
                  ),
                );
              },
              child: AppFlowyEditor(
                autoFocus: widget.autoFocus ?? true,
                editorStyle: editorStyle,
                editorState: editorState,
                editorScrollController: editorScrollController,
                blockComponentBuilders: blockComponentBuilders,
                showMagnifier: true,
                // showcase 3: customize the header and footer.
                header: Padding(
                  padding: EdgeInsets.only(bottom: Spacing.small),
                ),
                // Add footer to prevent keyboard hide it
                footer: const SizedBox(
                  height: 250,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // showcase 1: customize the editor style.
  EditorStyle _buildMobileEditorStyle() {
    return EditorStyle.mobile(
      cursorColor: LemonColor.paleViolet12,
      dragHandleColor: LemonColor.paleViolet,
      selectionColor: LemonColor.paleViolet36,
      textStyleConfiguration: TextStyleConfiguration(
        text: GoogleFonts.poppins(
          fontSize: 14.0,
          color: Colors.white,
        ),
        code: GoogleFonts.sourceCodePro(
          backgroundColor: Colors.grey.shade200,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      magnifierSize: const Size(144, 96),
      mobileDragHandleBallSize: const Size(12, 12),
    );
  }

  // showcase 2: customize the block style
  Map<String, BlockComponentBuilder> _buildBlockComponentBuilders() {
    final map = {
      ...standardBlockComponentBuilderMap,
    };
    // customize the heading block component
    final levelToFontSize = [
      24.0,
      22.0,
      20.0,
      18.0,
      16.0,
      14.0,
    ];
    map[HeadingBlockKeys.type] = HeadingBlockComponentBuilder(
      textStyleBuilder: (level) => GoogleFonts.poppins(
        fontSize: levelToFontSize.elementAtOrNull(level - 1) ?? 14.0,
        fontWeight: FontWeight.w600,
      ),
    );
    map[ParagraphBlockKeys.type] = ParagraphBlockComponentBuilder(
      configuration: BlockComponentConfiguration(
        placeholderText: (node) => 'Type something...',
      ),
    );
    return map;
  }
}
