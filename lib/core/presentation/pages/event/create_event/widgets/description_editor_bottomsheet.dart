import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class DescriptionEditorBottomSheet extends StatefulWidget {
  const DescriptionEditorBottomSheet({
    super.key,
    required this.content,
    required this.onTapBack,
  });

  final Function(String result) onTapBack;
  final String content;

  @override
  DescriptionEditorBottomSheetState createState() =>
      DescriptionEditorBottomSheetState();
}

class DescriptionEditorBottomSheetState
    extends State<DescriptionEditorBottomSheet> {
  final HtmlEditorController controller = HtmlEditorController();
  bool isLoading = true;
  String result = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      result = widget.content;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        controller.clearFocus();
      },
      child: Theme(
        data: ThemeData(
          colorScheme: ColorScheme.dark(
            primary: LemonColor.white,
            onPrimary: LemonColor.white,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: LemonColor.white,
            ),
          ),
        ),
        child: Scaffold(
          backgroundColor: LemonColor.atomicBlack,
          appBar: LemonAppBar(
            backgroundColor: LemonColor.atomicBlack,
            title: t.event.eventCreation.description,
            customBackHandler: () {
              widget.onTapBack(result);
            },
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isLoading
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: Spacing.small),
                        child: Loading.defaultLoading(context),
                      )
                    : const SizedBox(),
                HtmlEditor(
                  controller: controller,
                  htmlEditorOptions: const HtmlEditorOptions(
                    hint: "Write your message",
                    autoAdjustHeight: true,
                    adjustHeightForKeyboard: true,
                    androidUseHybridComposition: true,
                    shouldEnsureVisible: true,
                  ),
                  htmlToolbarOptions: HtmlToolbarOptions(
                    gridViewHorizontalSpacing: 0,
                    gridViewVerticalSpacing: 0,
                    toolbarPosition: ToolbarPosition.belowEditor,
                    toolbarType: ToolbarType.nativeScrollable,
                    textStyle: Typo.medium,
                    buttonColor: colorScheme.onSecondary,
                    buttonSelectedColor: LemonColor.paleViolet,
                    buttonHighlightColor: Colors.transparent,
                    defaultToolbarButtons: [
                      const FontButtons(
                        underline: true,
                        clearAll: false,
                        strikethrough: false,
                        superscript: false,
                        subscript: false,
                      ),
                      const ListButtons(
                        listStyles: true,
                      ),
                      const InsertButtons(
                        link: true,
                        picture: false,
                        audio: false,
                        video: false,
                        otherFile: false,
                        table: false,
                        hr: false,
                      ),
                    ],
                    renderBorder: false,
                    renderSeparatorWidget: false,
                  ),
                  otherOptions: OtherOptions(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(LemonRadius.medium),
                      border: Border.all(color: Colors.transparent),
                    ),
                    height: MediaQuery.of(context).size.height - 140,
                  ),
                  callbacks: Callbacks(
                    onInit: () {
                      controller.clear();
                      controller.setText(result);
                      controller.setFocus();
                      controller.setFullScreen();
                      setState(() {
                        isLoading = false;
                      });
                    },
                    onChangeContent: (content) {
                      setState(() {
                        result = content ?? '';
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
