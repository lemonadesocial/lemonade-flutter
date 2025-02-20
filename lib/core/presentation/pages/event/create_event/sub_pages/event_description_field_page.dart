import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:app/core/application/event/edit_event_detail_bloc/edit_event_detail_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EventDescriptionFieldPage extends StatefulWidget {
  const EventDescriptionFieldPage({
    super.key,
    required this.description,
    this.onDescriptionChanged,
    this.isEditMode = false,
    this.eventId,
    required this.onSave,
  });
  final String description;
  final Function(String value)? onDescriptionChanged;
  final bool isEditMode;
  final String? eventId;
  final Future<void> Function(String value)? onSave;

  @override
  State<EventDescriptionFieldPage> createState() =>
      _EventDescriptionFieldPageState();
}

class _EventDescriptionFieldPageState extends State<EventDescriptionFieldPage> {
  HtmlEditorController controller = HtmlEditorController();
  bool _isSaved = false;

  Future<void> _handleSave() async {
    final text = await controller.getText();
    await widget.onSave?.call(text);

    if (!widget.isEditMode) {
      setState(() => _isSaved = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<EditEventDetailBloc, EditEventDetailState>(
      builder: (context, state) {
        final bool isLoading =
            state.status == EditEventDetailBlocStatus.loading;
        final bool isSuccess =
            state.status == EditEventDetailBlocStatus.success;
        final isButtonSaved = (widget.isEditMode && isSuccess) ||
            (!widget.isEditMode && _isSaved);

        return Scaffold(
          appBar: LemonAppBar(
            backgroundColor: LemonColor.atomicBlack,
            title: t.event.eventCreation.description,
            onPressBack: () async {
              AutoRouter.of(context).pop();
            },
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                child: TextButton(
                  onPressed: isLoading ? null : _handleSave,
                  style: TextButton.styleFrom(
                    backgroundColor:
                        isButtonSaved ? Colors.transparent : Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: Spacing.extraSmall,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                      side: BorderSide(
                        color: colorScheme.onSecondary,
                        width: isButtonSaved ? 1 : 0,
                      ),
                    ),
                  ),
                  child: isLoading
                      ? SizedBox(
                          height: Sizing.xSmall,
                          width: Sizing.xSmall,
                          child: Loading.defaultLoading(context),
                        )
                      : Text(
                          isButtonSaved ? 'Saved' : 'Save',
                          style: TextStyle(
                            color: isButtonSaved ? Colors.white : Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),
              ),
            ],
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
      },
    );
  }
}
