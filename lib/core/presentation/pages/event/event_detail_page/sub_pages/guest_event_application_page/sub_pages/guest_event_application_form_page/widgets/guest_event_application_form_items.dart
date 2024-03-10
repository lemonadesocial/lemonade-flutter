import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/event_application_form_bloc/event_application_form_bloc.dart';
import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/domain/common/common_enums.dart';
import 'package:app/core/presentation/pages/edit_profile/widgets/edit_profile_field_item.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuestEventApplicationFormItems extends StatelessWidget {
  const GuestEventApplicationFormItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final event = context.read<EventProviderBloc>().event;
    final userProfile = context.read<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession,
          orElse: () => null,
        );
    List<String> profileRequiredFields =
        (event.requiredProfileFields ?? []).toList();
    return BlocBuilder<EventApplicationFormBloc, EventApplicationFormBlocState>(
      builder: (context, state) {
        return Column(
          children: profileRequiredFields.map((field) {
            if (ProfileFieldKey.values.any((element) => element.key == field)) {
              return Column(
                children: [
                  EditProfileFieldItem(
                    profileFieldKey: ProfileFieldKey.values.firstWhere(
                      (element) => element.key == field,
                    ),
                    userProfile: userProfile!,
                    onChange: (value) {
                      context.read<EventApplicationFormBloc>().add(
                            EventApplicationFormBlocEvent.updateField(
                              key: field,
                              value: value,
                            ),
                          );
                    },
                  ),
                  SizedBox(
                    height: Spacing.smMedium,
                  ),
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          }).toList(),
        );
      },
    );
  }
}
