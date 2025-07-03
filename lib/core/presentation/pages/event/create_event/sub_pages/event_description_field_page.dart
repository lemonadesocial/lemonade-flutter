import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:app/core/application/event/edit_event_detail_bloc/edit_event_detail_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/app_theme/app_theme.dart';

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
    final appColors = context.theme.appColors;
    final paddingBottom = MediaQuery.of(context).padding.bottom;
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
            backgroundColor: appColors.pageBg,
            title: t.event.eventCreation.description,
            onPressBack: () async {
              AutoRouter.of(context).pop();
            },
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                child: SizedBox(
                  width: 60.w,
                  child: LinearGradientButton.secondaryButton(
                    height: 32.w,
                    loadingWhen: isLoading,
                    label:
                        isButtonSaved ? t.common.saved : t.common.actions.save,
                    onTap: isLoading ? null : _handleSave,
                    radius: BorderRadius.circular(LemonRadius.full),
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Container(
              color: appColors.pageBg,
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: Spacing.smMedium,
                  vertical: Spacing.smMedium / 2,
                ),
                decoration: BoxDecoration(
                  color: appColors.pageBg,
                  borderRadius: BorderRadius.circular(LemonRadius.medium),
                  border: Border.all(
                    color: appColors.pageDivider,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(LemonRadius.medium),
                  child: HtmlEditor(
                    controller: controller,
                    htmlEditorOptions: HtmlEditorOptions(
                      hint: 'Type something...',
                      shouldEnsureVisible: true,
                      initialText: widget.description,
                      darkMode: Theme.of(context).brightness == Brightness.dark,
                    ),
                    htmlToolbarOptions: HtmlToolbarOptions(
                      renderBorder: false,
                      renderSeparatorWidget: false,
                      gridViewVerticalSpacing: 0,
                      gridViewHorizontalSpacing: 0,
                      buttonColor: appColors.textTertiary,
                      buttonSelectedColor: appColors.textAccent,
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
                      height: 1.sh - paddingBottom,
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
          ),
        );
      },
    );
  }
}
