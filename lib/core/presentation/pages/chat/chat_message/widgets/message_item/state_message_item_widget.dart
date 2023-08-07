import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

class StateMessageItem extends StatelessWidget {
  final Event event;
  const StateMessageItem(this.event, {Key? key}) : super(key: key);

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
            future: event.calcLocalizedBody(MatrixDefaultLocalizations()),
            builder: (context, snapshot) {
              return Text(
                snapshot.data ??
                    event.calcLocalizedBodyFallback(
                      MatrixDefaultLocalizations()
                    ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
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
