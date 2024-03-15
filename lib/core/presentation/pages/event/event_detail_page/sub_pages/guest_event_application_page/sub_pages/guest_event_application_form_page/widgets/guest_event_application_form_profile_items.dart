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
            return Column(
              children: [
                EditProfileFieldItem(
                  profileFieldKey: ProfileFieldKey.values.firstWhere(
                    (element) =>
                        element.fieldKey == applicationProfileField.field,
                  ),
                  userProfile: user,
                  onChange: (value) {
                    context.read<EventApplicationFormBloc>().add(
                          EventApplicationFormBlocEvent.updateField(
                            key: applicationProfileField.field,
                            value: value,
                          ),
                        );
                  },
                  showRequired: applicationProfileField.required,
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
