import 'package:app/core/application/event/event_application_form_bloc/event_application_form_bloc.dart';
import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/application/profile/user_profile_bloc/user_profile_bloc.dart';
import 'package:app/core/domain/common/common_enums.dart';
import 'package:app/core/domain/event/entities/event_application_profile_field.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/edit_profile/widgets/edit_profile_field_item.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix/matrix.dart' as matrix;

class GuestEventApplicationFormProfileItems extends StatelessWidget {
  const GuestEventApplicationFormProfileItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final event = context.read<EventProviderBloc>().event;
    User? user = context.watch<UserProfileBloc>().state.maybeWhen(
          fetched: (user) => user,
          orElse: () => null,
        );
    List<EventApplicationProfileField> applicationProfileFields =
        (event.applicationProfileFields ?? []).toList();
    if (user == null) {
      return const SizedBox();
    }
    return BlocBuilder<EventApplicationFormBloc, EventApplicationFormBlocState>(
      builder: (context, state) {
        return Column(
          children: applicationProfileFields.map((applicationProfileField) {
            final profileFieldKey = ProfileFieldKey.values.firstWhere(
              (element) => element.fieldKey == applicationProfileField.field,
            );
            String? value =
                state.fieldsState.tryGet(profileFieldKey.fieldKey).toString();
            return Column(
              children: [
                EditProfileFieldItem(
                  profileFieldKey: profileFieldKey,
                  // userProfile: user,
                  onChange: (value) {
                    context.read<EventApplicationFormBloc>().add(
                          EventApplicationFormBlocEvent.updateField(
                            key: applicationProfileField.field ?? '',
                            value: value,
                            event: event,
                          ),
                        );
                  },
                  showRequired: applicationProfileField.required,
                  value: value,
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
