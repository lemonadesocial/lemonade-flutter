import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TicketTierCategoryForm extends StatefulWidget {
  final Function(String title, String decription) onSubmit;

  const TicketTierCategoryForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<TicketTierCategoryForm> createState() => _TicketTierCategoryFormState();
}

class _TicketTierCategoryFormState extends State<TicketTierCategoryForm> {
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appColors = context.theme.appColors;
    return SingleChildScrollView(
      controller: ModalScrollController.of(context),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: appColors.pageBg,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              LemonAppBar(
                backgroundColor: appColors.pageBg,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      t.event.ticketTierSetting.categorySetting.newCategory,
                      style: Typo.extraLarge.copyWith(
                        color: appColors.textPrimary,
                        fontFamily: FontFamily.clashDisplay,
                      ),
                    ),
                    SizedBox(height: Spacing.superExtraSmall),
                    Text(
                      t.event.ticketTierSetting.categorySetting
                          .newCategoryDescription,
                      style: Typo.medium.copyWith(
                        color: appColors.textTertiary,
                      ),
                    ),
                    SizedBox(height: Spacing.medium),
                    _TextField(
                      hintText: t.event.ticketTierSetting.categorySetting.name,
                      height: 60.w,
                      onChanged: (value) {
                        setState(() {
                          title = value;
                        });
                      },
                    ),
                    SizedBox(height: Spacing.xSmall),
                    _TextField(
                      hintText:
                          t.event.ticketTierSetting.categorySetting.description,
                      height: 140.w,
                      onChanged: (value) {
                        setState(() {
                          description = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: Spacing.smMedium),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: appColors.pageDivider,
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: Spacing.smMedium,
                  horizontal: Spacing.xSmall,
                ),
                child: Opacity(
                  opacity: title.isNotEmpty ? 1 : 0.5,
                  child: LinearGradientButton.primaryButton(
                    onTap: () {
                      if (!title.isNotEmpty) {
                        return;
                      }
                      widget.onSubmit(title, description);
                    },
                    label:
                        t.event.ticketTierSetting.categorySetting.addCategory,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  final Function(String value) onChanged;
  final double height;
  final String? hintText;
  const _TextField({
    required this.onChanged,
    this.height = 140,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(LemonRadius.small),
      borderSide: BorderSide(color: appColors.pageDivider),
    );
    return SizedBox(
      height: height,
      child: TextField(
        onChanged: onChanged,
        textAlignVertical: TextAlignVertical.top,
        expands: true,
        cursorColor: appColors.textTertiary,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          enabledBorder: border,
          focusedBorder: border,
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
      ),
    );
  }
}
