import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/profile/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:app/core/presentation/pages/setting/enums/notification_type.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/utils/string_utils.dart';

@RoutePage()
class NotificationSettingPage extends StatelessWidget {
  const NotificationSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final notificationFilterString = context.read<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession.notificationFilterList!,
          orElse: () => <String>[],
        );
    return BlocProvider(
      create: (context) => EditProfileBloc()
        ..add(
          EditProfileEvent.mapNotificationType(
            notificationFilterString: notificationFilterString,
          ),
        ),
      child: BlocConsumer<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state.status == EditProfileStatus.success) {
            context.router.pop();
            context.read<AuthBloc>().add(const AuthEvent.refreshData());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: LemonAppBar(
              title: t.setting.notification,
            ),
            backgroundColor: colorScheme.primary,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: NotificationSettingType.values.length,
                      itemBuilder: (context, index) => Row(
                        children: [
                          Checkbox(
                            value: state.notificationMap![
                                NotificationSettingType.values[index]],
                            onChanged: (value) {
                              context.read<EditProfileBloc>().add(
                                    EditProfileEventNotificationCheck(
                                      type:
                                          NotificationSettingType.values[index],
                                    ),
                                  );
                            },
                          ),
                          Text(
                            NotificationSettingType.values[index].name
                                .capitalize(),
                          ),
                        ],
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: Spacing.small,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: Spacing.smMedium),
                    child: LinearGradientButton(
                      onTap: () {
                        if (state.status == EditProfileStatus.editing) {
                          context
                              .read<EditProfileBloc>()
                              .add(EditProfileEvent.submitEditProfile());
                        }
                      },
                      label: t.profile.saveChanges,
                      textStyle: Typo.medium.copyWith(
                        fontFamily: FontFamily.clashDisplay,
                        fontWeight: FontWeight.w600,
                      ),
                      height: Sizing.large,
                      radius: BorderRadius.circular(LemonRadius.large),
                      mode: state.status != EditProfileStatus.initial
                          ? GradientButtonMode.lavenderMode
                          : GradientButtonMode.defaultMode,
                      loadingWhen: state.status == EditProfileStatus.loading,
                    ),
                  ),
                  SizedBox(height: Spacing.smMedium),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
