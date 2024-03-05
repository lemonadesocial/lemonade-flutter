import 'package:app/core/application/event/invite_event_bloc/invite_event_bloc.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventInviteForm extends StatelessWidget {
  final Function()? onAddButtonPressed;
  const EventInviteForm({
    super.key,
    this.onAddButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InviteEventBloc, InviteEventBlocState>(
      builder: (context, state) {
        return Column(
          key: Key(state.emails.length.toString()),
          mainAxisSize: MainAxisSize.min,
          children: [
            ...state.emails.asMap().entries.map(
                  (entry) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _EmailField(
                        initialValue: entry.value,
                        onEmailChanged: (email) =>
                            context.read<InviteEventBloc>().add(
                                  InviteEventBlocEvent.updateEmail(
                                    index: entry.key,
                                    email: email,
                                  ),
                                ),
                        onRemove: () {
                          context.read<InviteEventBloc>().add(
                                InviteEventBlocEvent.removeEmail(
                                  index: entry.key,
                                ),
                              );
                        },
                        removable: state.emails.length > 1,
                      ),
                      if (entry.key != state.emails.length - 1)
                        SizedBox(height: Spacing.xSmall),
                    ],
                  ),
                ),
            SizedBox(
              height: Spacing.medium,
            ),
            _AddButton(
              onPress: () async {
                context.read<InviteEventBloc>().add(
                      InviteEventBlocEvent.addNewEmail(),
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

class _EmailField extends StatelessWidget {
  final String initialValue;
  final Function(String value)? onEmailChanged;
  final Function()? onRemove;
  final bool removable;

  const _EmailField({
    required this.initialValue,
    this.onEmailChanged,
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
              initialText: initialValue,
              hintText: t.common.email,
              onChange: onEmailChanged,
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
