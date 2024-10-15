import 'package:app/core/application/payment/add_new_card_bloc/add_new_card_bloc.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_bottom_sheet_mixin.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCardBottomSheet extends StatelessWidget with LemonBottomSheet {
  AddCardBottomSheet({
    super.key,
    required this.publishableKey,
  });

  final String publishableKey;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNewCardBloc(),
      child: AddCardBottomSheetView(
        publishableKey: publishableKey,
      ),
    );
  }
}

class AddCardBottomSheetView extends StatelessWidget {
  final String publishableKey;

  AddCardBottomSheetView({
    super.key,
    required this.publishableKey,
  });

  final expireDateFocusNode = FocusNode();
  final cvvFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final addCardBloc = context.read<AddNewCardBloc>();

    return BlocConsumer<AddNewCardBloc, AddNewCardState>(
      listener: (context, state) {
        if (state.status == AddNewCardBlocStatus.success) {
          // Return previous screen with new card data
          Navigator.of(context).pop(state.paymentCard);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const BottomSheetGrabber(),
              Padding(
                padding: EdgeInsets.only(
                  left: Spacing.small,
                  right: Spacing.small,
                  top: Spacing.medium,
                  bottom: MediaQuery.of(context).viewInsets.bottom != 0
                      ? 0
                      : Spacing.smMedium,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.event.eventPayment.newCard,
                      style: Typo.extraLarge.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onPrimary,
                      ),
                    ),
                    SizedBox(height: Spacing.superExtraSmall),
                    Text(
                      t.event.eventPayment.addNewCardDescription,
                      style: Typo.medium.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                    SizedBox(height: Spacing.medium),
                    LemonTextField(
                      filled: true,
                      fillColor: LemonColor.chineseBlack,
                      borderColor: colorScheme.outlineVariant,
                      placeholderStyle: Typo.medium.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      onChange: (value) {
                        addCardBloc.onCardNumberChange(value);
                        if (value.length == 19) {
                          expireDateFocusNode.requestFocus();
                        }
                      },
                      hintText: t.event.eventPayment.cardNumber,
                      textInputType: TextInputType.number,
                      errorText: state.error != null ? ' ' : null,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(19),
                        FilteringTextInputFormatter.digitsOnly,
                        CardNumberFormatter(),
                      ],
                    ),
                    SizedBox(height: Spacing.xSmall),
                    Row(
                      children: [
                        Expanded(
                          child: LemonTextField(
                            filled: true,
                            fillColor: LemonColor.chineseBlack,
                            borderColor: colorScheme.outlineVariant,
                            placeholderStyle: Typo.medium.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                            focusNode: expireDateFocusNode,
                            onChange: (value) {
                              addCardBloc.onValidDateChange(value);
                              if (value.length == 5) {
                                cvvFocusNode.requestFocus();
                              }
                            },
                            hintText: t.event.eventPayment.validThrough,
                            textInputType: TextInputType.number,
                            errorText: state.error != null ? ' ' : null,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(5),
                              FilteringTextInputFormatter.digitsOnly,
                              CardDateFormatter(),
                            ],
                          ),
                        ),
                        SizedBox(width: Spacing.xSmall),
                        Expanded(
                          child: LemonTextField(
                            filled: true,
                            fillColor: LemonColor.chineseBlack,
                            borderColor: colorScheme.outlineVariant,
                            placeholderStyle: Typo.medium.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                            focusNode: cvvFocusNode,
                            onChange: (value) {
                              addCardBloc.onCvvChange(value);
                              if (value.length == 3) {
                                FocusScope.of(context).unfocus();
                              }
                            },
                            hintText: t.event.eventPayment.cvc,
                            errorText: state.error != null ? ' ' : null,
                            textInputType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: state.error != null,
                      child: Text(
                        state.error ?? '',
                        textAlign: TextAlign.end,
                        style: Typo.small.copyWith(
                          color: LemonColor.errorRedBg,
                        ),
                      ),
                    ),
                    SizedBox(height: Spacing.medium),
                    Opacity(
                      opacity: state.fieldValidated ? 1 : 0.5,
                      child: LinearGradientButton.primaryButton(
                        onTap: state.fieldValidated
                            ? () => addCardBloc.addNewCard(
                                  publishableKey: publishableKey,
                                )
                            : null,
                        label: t.event.eventPayment.saveAndSelectCard,
                        loadingWhen:
                            state.status == AddNewCardBlocStatus.loading,
                      ),
                    ),
                    SizedBox(height: Spacing.smMedium),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(
          ' ',
        ); // Replace this with anything you want to put after each 4 numbers
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

class CardDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != text.length) {
        buffer.write(
          '/',
        ); // Replace this with anything you want to put after each 4 numbers
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}
