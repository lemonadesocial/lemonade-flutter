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
            backgroundColor: LemonColor.coralReef.withOpacity(0.18),
            foregroundColor: LemonColor.coralReef,
            icon: Icons.delete_outline_rounded,
          ),
        ],
      ),
      child: child,
    );
  }
}
