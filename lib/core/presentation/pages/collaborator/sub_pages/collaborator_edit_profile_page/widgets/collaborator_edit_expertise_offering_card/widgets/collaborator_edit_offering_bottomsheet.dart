import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:slang/builder/utils/string_extensions.dart';

List<String> offeringList = [
  "Artistic Services",
  "Copywriting",
  "Data Analysis",
  "Design Services",
  "Digital Marketing",
  "Product Management",
  "Product Development",
  "Music Performance (Rapper)",
  "Research Services",
  "Sales Consulting",
];

class CollaboratorEditOfferingBottomSheet extends StatefulWidget {
  const CollaboratorEditOfferingBottomSheet({super.key});

  @override
  CollaboratorEditOfferingBottomSheetState createState() =>
      CollaboratorEditOfferingBottomSheetState();
}

class CollaboratorEditOfferingBottomSheetState
    extends State<CollaboratorEditOfferingBottomSheet> {
  List<String> selectedOffering = [];
  String searchValue = '';

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      color: LemonColor.atomicBlack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BottomSheetGrabber(),
          LemonAppBar(
            title: t.collaborator.offering,
            backgroundColor: LemonColor.atomicBlack,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: Spacing.smMedium,
              right: Spacing.smMedium,
              top: Spacing.xSmall,
              bottom: Spacing.smMedium,
            ),
            child: LemonTextField(
              hintText: t.common.search.capitalize(),
              contentPadding: EdgeInsets.all(Spacing.small),
              onChange: (value) {
                setState(() {
                  searchValue = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
              child: ListView.builder(
                itemCount: offeringList.length,
                padding: EdgeInsets.only(bottom: Spacing.large),
                itemBuilder: (BuildContext context, int index) {
                  final offering = offeringList[index];
                  final offeringLower = offering.toLowerCase();
                  if (offeringLower.contains(searchValue)) {
                    final isChecked = selectedOffering.contains(offering);
                    return _OfferingItem(
                      offering: offering,
                      isChecked: isChecked,
                      onChecked: (isChecked) {
                        setState(() {
                          if (isChecked) {
                            selectedOffering.add(offering);
                          } else {
                            selectedOffering.remove(offering);
                          }
                        });
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: LemonColor.atomicBlack,
                border: Border(top: BorderSide(color: colorScheme.outline)),
              ),
              padding: EdgeInsets.all(Spacing.smMedium),
              child: SafeArea(
                child: Opacity(
                  opacity: selectedOffering.isNotEmpty ? 1 : 0.5,
                  child: LinearGradientButton.primaryButton(
                    onTap: () {
                      if (kDebugMode) {
                        print('selectedOffering : $selectedOffering');
                      }
                      Vibrate.feedback(FeedbackType.light);
                      FocusManager.instance.primaryFocus?.unfocus();
                      AutoRouter.of(context).pop();
                    },
                    label: t.common.apply,
                    textColor: colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OfferingItem extends StatelessWidget {
  final String offering;
  final bool isChecked;
  final Function(bool) onChecked;

  const _OfferingItem({
    required this.offering,
    required this.isChecked,
    required this.onChecked,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        onChecked(!isChecked);
      },
      child: Container(
        padding: EdgeInsets.all(Spacing.small),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offering,
                    style: Typo.mediumPlus.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            isChecked
                ? Assets.icons.icChecked.svg()
                : Assets.icons.icUncheck.svg(),
          ],
        ),
      ),
    );
  }
}
