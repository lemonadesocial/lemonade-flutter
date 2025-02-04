import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:html_editor_enhanced/html_editor.dart';

@RoutePage()
class EventDescriptionFieldPage extends StatefulWidget {
  const EventDescriptionFieldPage({
    super.key,
    required this.description,
    required this.onDescriptionChanged,
  });
  final String description;
  final Function(String value) onDescriptionChanged;

  @override
  State<EventDescriptionFieldPage> createState() =>
      _EventDescriptionFieldPageState();
}

class _EventDescriptionFieldPageState extends State<EventDescriptionFieldPage> {
  HtmlEditorController controller = HtmlEditorController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: LemonAppBar(
        backgroundColor: LemonColor.atomicBlack,
        title: t.event.eventCreation.description,
        onPressBack: () async {
          AutoRouter.of(context).pop();
          widget.onDescriptionChanged(await controller.getText());
        },
      ),
      body: SafeArea(
        child: Container(
          color: LemonColor.atomicBlack,
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: Spacing.smMedium,
              vertical: Spacing.smMedium / 2,
            ),
            decoration: BoxDecoration(
              color: LemonColor.atomicBlack,
              borderRadius: BorderRadius.circular(LemonRadius.medium),
              border: Border.all(
                color: colorScheme.outline,
              ),
            ),
            child: HtmlEditor(
              controller: controller,
              htmlEditorOptions: HtmlEditorOptions(
                hint: 'Type something...',
                shouldEnsureVisible: true,
                initialText: widget.description,
              ),
              htmlToolbarOptions: HtmlToolbarOptions(
                renderBorder: false,
                renderSeparatorWidget: false,
                gridViewVerticalSpacing: 0,
                gridViewHorizontalSpacing: 0,
                buttonColor: colorScheme.onSecondary,
                buttonSelectedColor: LemonColor.paleViolet,
                defaultToolbarButtons: [
                  const StyleButtons(),
                  const FontButtons(
                    clearAll: false,
                    strikethrough: false,
                    superscript: false,
                    subscript: false,
                  ),
                  const ListButtons(listStyles: false),
                  const InsertButtons(
                    picture: false,
                    audio: false,
                    video: false,
                    otherFile: false,
                    table: false,
                    hr: false,
                  ),
                ],
                toolbarPosition: ToolbarPosition.aboveEditor,
                toolbarType: ToolbarType.nativeScrollable,
              ),
              otherOptions: OtherOptions(
                height: MediaQuery.sizeOf(context).height -
                    MediaQuery.paddingOf(context).vertical -
                    AppBar().preferredSize.height -
                    MediaQuery.viewInsetsOf(context).vertical -
                    (2 * Spacing.medium), // Account for vertical margins
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(LemonRadius.medium),
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                ),
              ),
              callbacks: Callbacks(
                onBeforeCommand: (String? currentHtml) {
                  debugPrint('html before change is $currentHtml');
                },
                onChangeContent: (String? changed) {
                  debugPrint('content changed to $changed');
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
