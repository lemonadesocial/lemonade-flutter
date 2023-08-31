import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

class StateMessageItem extends StatelessWidget {
  const StateMessageItem(this.event, {Key? key}) : super(key: key);
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Spacing.extraSmall,
        horizontal: Spacing.extraSmall,
      ),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Spacing.xSmall,
            vertical: Spacing.extraSmall,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(LemonRadius.small),
          ),
          child: FutureBuilder<String>(
            future: event.calcLocalizedBody(const MatrixDefaultLocalizations()),
            builder: (context, snapshot) {
              return Text(
                snapshot.data ??
                    event.calcLocalizedBodyFallback(
                      const MatrixDefaultLocalizations(),
                    ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  decoration:
                      event.redacted ? TextDecoration.lineThrough : null,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
