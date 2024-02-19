import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart' as matrix;

class EventJoinRequestApplicationForm extends StatelessWidget {
  final User? user;
  final Event? event;
  const EventJoinRequestApplicationForm({
    super.key,
    this.user,
    this.event,
  });

  @override
  Widget build(BuildContext context) {
    List<String> profileRequiredFields = (event?.requiredProfileFields ?? [])
        .map(StringUtils.snakeToCamel)
        .toList();

    List<String> formattedFieldNames =
        profileRequiredFields.map(StringUtils.camelCaseToWords).toList();

    return SliverList.separated(
      itemCount: profileRequiredFields.length,
      itemBuilder: (context, index) {
        final userJson = user?.toJson();
        final value = userJson?.tryGet(profileRequiredFields[index]);
        return _FormField(
          label: StringUtils.capitalize(formattedFieldNames[index]),
          value: value is String ? value : null,
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: Spacing.medium),
    );
  }
}

class _FormField extends StatelessWidget {
  final String label;
  final String? value;
  const _FormField({
    required this.label,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Typo.mediumPlus.copyWith(
            color: colorScheme.onSecondary,
          ),
        ),
        SizedBox(height: Spacing.xSmall),
        Container(
          padding: EdgeInsets.all(Spacing.smMedium),
          decoration: BoxDecoration(
            border: Border.all(color: colorScheme.outline),
            borderRadius: BorderRadius.circular(LemonRadius.small),
          ),
          child: Row(
            children: [
              Text(
                value ?? '',
                style: Typo.mediumPlus.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
