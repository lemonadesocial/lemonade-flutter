import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DescriptionEditorBottomSheet extends StatelessWidget {
  const DescriptionEditorBottomSheet({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const HtmlEditorExample(title: 'Flutter HTML Editor Example');
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(),
    //   darkTheme: ThemeData.dark(),
    //   home: const HtmlEditorExample(title: 'Flutter HTML Editor Example'),
    // );
  }
}

class HtmlEditorExample extends StatefulWidget {
  const HtmlEditorExample({super.key, required this.title});

  final String title;

  @override
  HtmlEditorExampleState createState() => HtmlEditorExampleState();
}

class HtmlEditorExampleState extends State<HtmlEditorExample> {
  String result = '';
  final HtmlEditorController controller = HtmlEditorController();

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
                    controller.setFocus();
                    controller.setFullScreen();
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

// import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
// import 'package:app/i18n/i18n.g.dart';
// import 'package:app/theme/color.dart';
// import 'package:flutter/material.dart';
// import 'package:html_editor_enhanced/html_editor.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// class DescriptionEditorBottomSheet extends StatefulWidget {
//   const DescriptionEditorBottomSheet({super.key});

//   @override
//   State<DescriptionEditorBottomSheet> createState() =>
//       _DescriptionEditorBottomSheetState();
// }

// class _DescriptionEditorBottomSheetState
//     extends State<DescriptionEditorBottomSheet> {
//   HtmlEditorController controller = HtmlEditorController();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final t = Translations.of(context);
//     final colorScheme = Theme.of(context).colorScheme;
//     return SingleChildScrollView(
//       controller: ModalScrollController.of(context),
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           color: LemonColor.atomicBlack,
//         ),
//         child: SafeArea(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               LemonAppBar(
//                 backgroundColor: LemonColor.atomicBlack,
//                 title: t.event.timezoneSetting.chooseTimezone,
//               ),
//               Stack(
//                 children: [
//                   HtmlEditor(
//                     controller: controller,
//                     htmlEditorOptions: const HtmlEditorOptions(
//                       shouldEnsureVisible: true
//                     ),
//                     htmlToolbarOptions: const HtmlToolbarOptions(
//                       toolbarPosition: ToolbarPosition.belowEditor,
//                       defaultToolbarButtons: [
//                         FontButtons(
//                           underline: false,
//                           clearAll: false,
//                           strikethrough: false,
//                           superscript: false,
//                           subscript: false,
//                         ),
//                         ListButtons(
//                           listStyles: false,
//                         ),
//                       ],
//                       renderBorder: false,
//                       renderSeparatorWidget: false,

//                     ),

//                     otherOptions: const OtherOptions(
//                       decoration: BoxDecoration(
//                         color: Colors.transparent,
//                       ),
//                       height: 600,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
