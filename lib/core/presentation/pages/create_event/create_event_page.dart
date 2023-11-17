import 'package:app/core/application/event/create_event_bloc/create_event_bloc.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:app/i18n/i18n.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    // final createEventBloc = CreateEventBloc(event: );
    return BlocProvider(
      create: (_) => CreateEventBloc(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: colorScheme.primary,
          appBar: LemonAppBar(
            title: t.event.createEvent,
          ),
          body: BlocBuilder<CreateEventBloc, CreateEventState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Spacing.medium),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LemonTextField(
                            initialText: state.title.value,
                            label: "Title*",
                            onChange: (value) => context
                                .read<CreateEventBloc>()
                                .add(TitleChanged(title: value)),
                            errorText: state.title.displayError != null
                                ? '''Title can't be empty'''
                                : null,
                          ),
                          SizedBox(
                            height: Spacing.smMedium,
                          ),
                          LemonTextField(
                            initialText: state.description.value,
                            label: "Description*",
                            onChange: (value) => context
                                .read<CreateEventBloc>()
                                .add(DescriptionChanged(description: value)),
                            errorText: state.description.displayError != null
                                ? '''Description can't be empty'''
                                : null,
                          ),
                        ],
                      ),
                    ),
                    _buildSubmitButton(context)
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _buildSubmitButton(BuildContext context) {
    final t = Translations.of(context);
    final isValid =
        context.select((CreateEventBloc bloc) => bloc.state.isValid);
    return Padding(
      padding: EdgeInsets.only(bottom: Spacing.smMedium),
      child: LinearGradientButton(
        label: t.common.next,
        height: 48.h,
        radius: BorderRadius.circular(24),
        textStyle: Typo.medium.copyWith(),
        mode: GradientButtonMode.lavenderMode,
        onTap: () {
          if (isValid) {
            context.read<CreateEventBloc>().add(const FormSubmitted());
          }
          return;
        },
      ),
    );
  }
}
