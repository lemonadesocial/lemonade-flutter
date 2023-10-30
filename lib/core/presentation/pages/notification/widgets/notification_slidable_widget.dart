import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotificationSlidable extends StatelessWidget {
  final Widget child;
  final String id;
  final void Function()? onRemove;
  final void Function()? onDismissed;
  const NotificationSlidable({
    super.key,
    required this.id,
    required this.child,
    this.onRemove,
    // ignore: unused_element
    this.onDismissed,
  });
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return Slidable(
      key: ValueKey(id),
      endActionPane: ActionPane(
        dismissible: DismissiblePane(
          closeOnCancel: true,
          confirmDismiss: () async {
            return true;
          },
          onDismissed: () {
            onDismissed?.call();
          },
        ),
        extentRatio: 0.2,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              onRemove?.call();
            },
            backgroundColor: LemonColor.red,
            foregroundColor: colorScheme.onPrimary,
            icon: Icons.delete,
            label: t.common.delete,
          ),
        ],
      ),
      child: child,
    );
  }
}
