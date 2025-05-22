import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/utils/email_validator.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AddEmailToWhiteListBottomSheet extends StatefulWidget {
  final Function(List<String> addedEmails) onSubmit;

  const AddEmailToWhiteListBottomSheet({
    super.key,
    required this.onSubmit,
  });

  @override
  State<AddEmailToWhiteListBottomSheet> createState() =>
      _AddEmailToWhiteListBottomSheetState();
}

class _AddEmailToWhiteListBottomSheetState
    extends State<AddEmailToWhiteListBottomSheet> {
  bool isValid = false;
  List<String> result = [];

  List<String> transformInput(String value) {
    return value.trim().split('\n');
  }

  bool validate(List<String> result) {
    return result.every((element) => EmailValidator.validate(element));
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      controller: ModalScrollController.of(context),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: LemonColor.atomicBlack,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              LemonAppBar(
                backgroundColor: LemonColor.atomicBlack,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      t.event.ticketTierSetting.whitelistSetting.addEmail,
                      style: Typo.extraLarge.copyWith(
                        color: colorScheme.onPrimary,
                        fontFamily: FontFamily.clashDisplay,
                      ),
                    ),
                    SizedBox(height: Spacing.superExtraSmall),
                    Text(
                      t.event.ticketTierSetting.whitelistSetting
                          .whiteListAddEmailDescription,
                      style: Typo.medium.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                    SizedBox(height: Spacing.medium),
                    EmailInput(
                      onChanged: (value) {
                        final newResult = transformInput(value);
                        setState(() {
                          isValid = validate(newResult);
                          result = newResult;
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
                      color: colorScheme.outline,
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: Spacing.smMedium,
                  horizontal: Spacing.xSmall,
                ),
                child: Opacity(
                  opacity: isValid ? 1 : 0.5,
                  child: LinearGradientButton.primaryButton(
                    onTap: () {
                      if (!isValid) {
                        return;
                      }
                      widget.onSubmit(result);
                      Navigator.of(context).pop();
                    },
                    label: t.event.ticketTierSetting.whitelistSetting
                        .addToWhitelist,
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

class EmailInput extends StatelessWidget {
  final Function(String value) onChanged;
  const EmailInput({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(LemonRadius.small),
      borderSide: BorderSide(color: colorScheme.outline),
    );
    return SizedBox(
      height: 140.w,
      child: TextField(
        onChanged: onChanged,
        textAlignVertical: TextAlignVertical.top,
        expands: true,
        cursorColor: colorScheme.onSecondary,
        decoration: InputDecoration(
          hintText: t.event.ticketTierSetting.whitelistSetting
              .whitelistInputPlaceholder,
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
