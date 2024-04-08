import 'package:app/core/presentation/widgets/common/editor/mobile_editor.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class EventDescriptionFieldPage extends StatefulWidget {
  const EventDescriptionFieldPage(
      {super.key,
      required this.description,
      required this.onDescriptionChanged});
  final String description;
  final Function(String value) onDescriptionChanged;

  @override
  State<EventDescriptionFieldPage> createState() =>
      _EventDescriptionFieldPageState();
}

class _EventDescriptionFieldPageState extends State<EventDescriptionFieldPage> {
  late EditorState editorState;

  @override
  void initState() {
    super.initState();
    final document = markdownToDocument(widget.description);
    setState(() {
      editorState = EditorState(document: document);
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      extendBodyBehindAppBar: PlatformExtension.isDesktopOrWeb,
      appBar: LemonAppBar(
        backgroundColor: LemonColor.atomicBlack,
        title: t.event.eventCreation.description,
        onPressBack: () {
          AutoRouter.of(context).pop();
          widget.onDescriptionChanged(documentToMarkdown(editorState.document));
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
            child: MobileEditor(
              editorState: editorState,
            ),
          ),
        ),
      ),
    );
  }
}
