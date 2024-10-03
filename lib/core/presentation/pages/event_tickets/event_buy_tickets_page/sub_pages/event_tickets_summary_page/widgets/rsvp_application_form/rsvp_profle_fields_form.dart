import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/event_application_form_bloc/event_application_form_bloc.dart';
import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/domain/common/common_enums.dart';
import 'package:app/core/domain/event/entities/event_application_profile_field.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/edit_profile/widgets/edit_profile_field_item.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:app/core/utils/date_utils.dart' as date_utils;

class RSVPProfileFieldsForm extends StatefulWidget {
  const RSVPProfileFieldsForm({
    super.key,
  });

  @override
  State<RSVPProfileFieldsForm> createState() => _RSVPProfileFieldsFormState();
}

class _RSVPProfileFieldsFormState extends State<RSVPProfileFieldsForm> {
  final birthDayCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final fieldState =
        context.read<EventApplicationFormBloc>().state.fieldsState;
    if (fieldState.tryGet(ProfileFieldKey.dateOfBirth.fieldKey) != null &&
        fieldState.tryGet(ProfileFieldKey.dateOfBirth.fieldKey) != '') {
      String dateOfBirthValue =
          fieldState.tryGet(ProfileFieldKey.dateOfBirth.fieldKey).toString();
      birthDayCtrl.text =
          date_utils.DateUtils.formatDateTimeToDDMMYYYY(dateOfBirthValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    final event = context.read<EventProviderBloc>().event;
    User? user = context.watch<AuthBloc>().state.maybeWhen(
          authenticated: (user) => user,
          orElse: () => null,
        );
    List<EventApplicationProfileField> applicationProfileFields =
        (event.applicationProfileFields ?? []).toList();
    if (user == null) {
      return const SizedBox();
    }
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<EventApplicationFormBloc, EventApplicationFormBlocState>(
      builder: (context, state) {
        if (state.isInitialized == true) {
          return Loading.defaultLoading(context);
        }
        return Column(
          children: applicationProfileFields.map((applicationProfileField) {
            final profileFieldKey = ProfileFieldKey.values.firstWhere(
              (element) => element.fieldKey == applicationProfileField.field,
              orElse: () => ProfileFieldKey.unknown,
            );
            String? value =
                state.fieldsState.tryGet(profileFieldKey.fieldKey).toString();
            if (profileFieldKey == ProfileFieldKey.unknown) {
              return const SizedBox();
            }
            return Column(
              children: [
                // Special handle for date picker
                if (profileFieldKey == ProfileFieldKey.dateOfBirth)
                  Focus(
                    child: EditProfileFieldItem(
                      controller: birthDayCtrl,
                      profileFieldKey: profileFieldKey,
                      onChange: (value) {
                        birthDayCtrl.text = value;
                      },
                      onDateSelect: (selectedDate) {
                        birthDayCtrl.text =
                            date_utils.DateUtils.toLocalDateString(
                          selectedDate,
                        );
                        context.read<EventApplicationFormBloc>().add(
                              EventApplicationFormBlocEvent.updateField(
                                key: applicationProfileField.field ?? '',
                                value: selectedDate.toUtc().toIso8601String(),
                                event: event,
                              ),
                            );
                      },
                      value: value,
                      showRequired: applicationProfileField.required,
                      backgroundColor: LemonColor.atomicBlack,
                      labelStyle: Typo.medium.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                    ),
                    onFocusChange: (hasFocus) {
                      if (!hasFocus) {
                        // On blur
                        birthDayCtrl.text =
                            date_utils.DateUtils.toLocalDateString(
                          date_utils.DateUtils.parseDateString(
                            birthDayCtrl.text,
                          ),
                        );
                        context.read<EventApplicationFormBloc>().add(
                              EventApplicationFormBlocEvent.updateField(
                                key: applicationProfileField.field ?? '',
                                value: date_utils.DateUtils.parseDateString(
                                  (birthDayCtrl.text),
                                ).toIso8601String(),
                                event: event,
                              ),
                            );
                      }
                    },
                  )
                else
                  EditProfileFieldItem(
                    profileFieldKey: profileFieldKey,
                    onChange: (value) {
                      context.read<EventApplicationFormBloc>().add(
                            EventApplicationFormBlocEvent.updateField(
                              key: applicationProfileField.field ?? '',
                              value: value,
                              event: event,
                            ),
                          );
                    },
                    value: value,
                    showRequired: applicationProfileField.required,
                    backgroundColor: LemonColor.atomicBlack,
                    labelStyle: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                SizedBox(
                  height: Spacing.smMedium,
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
