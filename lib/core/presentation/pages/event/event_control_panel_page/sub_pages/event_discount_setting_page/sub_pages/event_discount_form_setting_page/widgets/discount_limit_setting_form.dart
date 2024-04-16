import 'package:app/core/application/event/create_event_discount_bloc/create_event_discount_bloc.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscountLimitSettingForm extends StatelessWidget {
  final bool? readOnly;
  const DiscountLimitSettingForm({
    super.key,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final createEventDiscountBloc = context.read<CreateEventDiscountBloc>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          t.common.settings,
          style: Typo.mediumPlus.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: Spacing.xSmall),
        _Field(
          readOnly: readOnly,
          initalValue:
              (createEventDiscountBloc.state.data.ticketLimit?.toInt() ?? 0)
                  .toString(),
          title: t.event.eventPromotions.ticketLimit,
          description: t.event.eventPromotions.ticketLimitDescription,
          hintText: '100',
          onChange: (value) {
            final parsedValue =
                value.isNotEmpty == true ? double.parse(value) : 0;
            context.read<CreateEventDiscountBloc>().add(
                  CreateEventDiscountEvent.onTicketLimitChanged(
                    ticketLimit: parsedValue.toDouble(),
                  ),
                );
          },
        ),
        SizedBox(height: Spacing.xSmall),
        _Field(
          readOnly: readOnly,
          initalValue:
              (createEventDiscountBloc.state.data.ticketLimitPer?.toInt() ?? 0)
                  .toString(),
          title: t.event.eventPromotions.ticketLimitPerGuest,
          description: t.event.eventPromotions.ticketLimitPerGuestDescription,
          hintText: '1',
          onChange: (value) {
            final parsedValue =
                value.isNotEmpty == true ? double.parse(value) : 0;
            context.read<CreateEventDiscountBloc>().add(
                  CreateEventDiscountEvent.onTicketLimitPerChanged(
                    ticketLimitPer: parsedValue.toDouble(),
                  ),
                );
          },
        ),
      ],
    );
  }
}

class _Field extends StatelessWidget {
  final String title;
  final String description;
  final String? hintText;
  final String? initalValue;
  final bool? readOnly;

  final Function(String value)? onChange;

  const _Field({
    required this.title,
    required this.description,
    this.hintText,
    this.onChange,
    this.initalValue,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(LemonRadius.small),
      borderSide: BorderSide(color: colorScheme.outline),
    );
    return Container(
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.circular(LemonRadius.medium),
      ),
      padding: EdgeInsets.all(Spacing.small),
      child: SizedBox(
        height: Sizing.medium,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              flex: 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    description,
                    style: Typo.small.copyWith(
                      color: colorScheme.onSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: Sizing.medium * 2,
              height: Sizing.medium,
              child: TextFormField(
                readOnly: readOnly ?? false,
                enableSuggestions: false,
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                onChanged: onChange,
                cursorColor: colorScheme.onPrimary,
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 2.w),
                  hintText: hintText,
                  enabledBorder: border,
                  focusedBorder: border,
                ),
                initialValue: initalValue,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
