import 'package:app/core/application/event_tickets/issue_tickets_bloc/issue_tickets_bloc.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IssueTicketsAssignmentForm extends StatelessWidget {
  final Function()? onAddButtonPressed;
  const IssueTicketsAssignmentForm({
    super.key,
    this.onAddButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssueTicketsBloc, IssueTicketsBlocState>(
      builder: (context, state) {
        final ticketAssignments = state.ticketAssignments;
        return Column(
          key: Key(ticketAssignments.length.toString()),
          mainAxisSize: MainAxisSize.min,
          children: [
            ...ticketAssignments.asMap().entries.map(
                  (entry) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _AssignmentFormField(
                        ticketAssignmentInput: entry.value,
                        onEmailChanged: (email) =>
                            context.read<IssueTicketsBloc>().add(
                                  IssueTicketsBlocEvent.updateTicketAssignment(
                                    index: entry.key,
                                    ticketAssignment:
                                        entry.value.copyWith(email: email),
                                  ),
                                ),
                        onCountChanged: (count) {
                          context.read<IssueTicketsBloc>().add(
                                IssueTicketsBlocEvent.updateTicketAssignment(
                                  index: entry.key,
                                  ticketAssignment: entry.value.copyWith(
                                    count: count.isNotEmpty
                                        ? double.parse(count)
                                        : 0,
                                  ),
                                ),
                              );
                        },
                        onRemove: () {
                          context.read<IssueTicketsBloc>().add(
                                IssueTicketsBlocEvent.removeTicketAssignmen(
                                  index: entry.key,
                                ),
                              );
                        },
                        removable: ticketAssignments.length > 1,
                      ),
                      if (entry.key != ticketAssignments.length - 1)
                        SizedBox(height: Spacing.xSmall),
                    ],
                  ),
                ),
            SizedBox(
              height: Spacing.medium,
            ),
            _AddButton(
              onPress: () async {
                context.read<IssueTicketsBloc>().add(
                      IssueTicketsBlocEvent.addNewTicketAssignment(),
                    );
                await Future.delayed(const Duration(milliseconds: 300));
                onAddButtonPressed?.call();
              },
            ),
          ],
        );
      },
    );
  }
}

class _AddButton extends StatelessWidget {
  final Function()? onPress;
  const _AddButton({
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        InkWell(
          onTap: onPress,
          child: Container(
            width: Sizing.xLarge,
            height: Sizing.xLarge,
            decoration: BoxDecoration(
              color: colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(Sizing.xLarge),
            ),
            child: Center(
              child: ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => Assets.icons.icAdd.svg(
                  width: Sizing.xSmall,
                  height: Sizing.xSmall,
                  colorFilter: filter,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AssignmentFormField extends StatelessWidget {
  final Input$TicketAssignment ticketAssignmentInput;
  final Function(String value)? onEmailChanged;
  final Function(String count)? onCountChanged;
  final Function()? onRemove;
  final bool removable;

  const _AssignmentFormField({
    required this.ticketAssignmentInput,
    this.onEmailChanged,
    this.onCountChanged,
    this.onRemove,
    this.removable = false,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 3,
            child: LemonTextField(
              initialText: ticketAssignmentInput.email,
              hintText: t.common.email,
              onChange: onEmailChanged,
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          Expanded(
            flex: 1,
            child: LemonTextField(
              initialText: ticketAssignmentInput.count.toInt().toString(),
              hintText: "1",
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              textInputType: TextInputType.number,
              onChange: onCountChanged,
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          InkWell(
            onTap: removable ? onRemove : null,
            child: Container(
              width: Sizing.medium,
              decoration: BoxDecoration(
                border: Border.all(
                  color: removable ? Colors.transparent : colorScheme.outline,
                ),
                color:
                    removable ? LemonColor.atomicBlack : colorScheme.background,
                borderRadius: BorderRadius.circular(LemonRadius.normal),
              ),
              child: Center(
                child: ThemeSvgIcon(
                  color: colorScheme.onSecondary,
                  builder: (filter) => Assets.icons.icClose.svg(
                    width: Sizing.xSmall,
                    height: Sizing.xSmall,
                    colorFilter: filter,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
