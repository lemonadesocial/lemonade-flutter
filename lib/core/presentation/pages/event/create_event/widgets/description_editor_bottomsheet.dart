import 'package:app/core/application/event/create_event_bloc/create_event_bloc.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class DescriptionEditorBottomSheet extends StatefulWidget {
  const DescriptionEditorBottomSheet({
    super.key,
  });

  @override
  DescriptionEditorBottomSheetState createState() =>
      DescriptionEditorBottomSheetState();
}

class DescriptionEditorBottomSheetState
    extends State<DescriptionEditorBottomSheet> {
  final HtmlEditorController controller = HtmlEditorController();
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        if (!kIsWeb) {
          controller.clearFocus();
        }
      },
      child: Scaffold(
        backgroundColor: LemonColor.atomicBlack,
        appBar: LemonAppBar(
          backgroundColor: LemonColor.atomicBlack,
          title: t.event.eventCreation.description,
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
                    controller.setText("");
                    controller.setFocus();
                    controller.setFullScreen();
                    setState(() {
                      isLoading = false;
                    });
                  },
                  onChangeContent: (content) {
                    context.read<CreateEventBloc>().add(
                        EventDescriptionChanged(description: content ?? ''));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
