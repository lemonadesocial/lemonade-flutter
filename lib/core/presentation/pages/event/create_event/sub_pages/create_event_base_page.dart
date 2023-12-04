import 'package:app/core/application/event/create_event_bloc/create_event_bloc.dart';
import 'package:app/core/presentation/pages/event/create_event/widgets/create_event_config_grid.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:app/i18n/i18n.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';

@RoutePage()
class CreateEventBasePage extends StatelessWidget {
  const CreateEventBasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<CreateEventBloc, CreateEventState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          context.router.popUntilRoot();
          SnackBarUtils.showSuccessSnackbar(
            t.event.eventCreation.createEventSuccessfully,
          );
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: colorScheme.primary,
          appBar: LemonAppBar(
            title: t.event.eventCreation.createEvent,
          ),
          body: BlocBuilder<CreateEventBloc, CreateEventState>(
            builder: (context, state) {
              return CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Spacing.smMedium,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: Spacing.medium),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    LemonTextField(
                                      initialText: state.title.value,
                                      label: t.event.eventCreation.title,
                                      onChange: (value) => context
                                          .read<CreateEventBloc>()
                                          .add(TitleChanged(title: value)),
                                      errorText:
                                          state.title.displayError != null
                                              ? state.title.displayError!
                                                  .getMessage(
                                                  t.event.eventCreation.title,
                                                )
                                              : null,
                                    ),
                                    SizedBox(
                                      height: Spacing.smMedium,
                                    ),
                                    LemonTextField(
                                      initialText: state.description.value,
                                      label: t.event.eventCreation.description,
                                      onChange: (value) =>
                                          context.read<CreateEventBloc>().add(
                                                DescriptionChanged(
                                                  description: value,
                                                ),
                                              ),
                                      errorText:
                                          state.description.displayError != null
                                              ? state.description.displayError!
                                                  .getMessage(
                                                  t.event.eventCreation
                                                      .description,
                                                )
                                              : null,
                                    ),
                                    SizedBox(height: Spacing.smMedium),
                                    CreateEventConfigGrid(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        _buildSubmitButton(context),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  _buildSubmitButton(BuildContext context) {
    final t = Translations.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.smMedium,
        vertical: Spacing.smMedium,
      ),
      child: LinearGradientButton(
        label: t.common.next,
        height: 48.h,
        radius: BorderRadius.circular(24),
        textStyle: Typo.medium.copyWith(),
        mode: GradientButtonMode.lavenderMode,
        onTap: () => context.read<CreateEventBloc>().add(const FormSubmitted()),
      ),
    );
  }
}
