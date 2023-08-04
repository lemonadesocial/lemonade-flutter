import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

class StateMessageItem extends StatelessWidget {
  final Event event;
  const StateMessageItem(this.event, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onInverseSurface,
            borderRadius: BorderRadius.circular(6),
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
