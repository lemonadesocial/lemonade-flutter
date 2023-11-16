import 'package:flutter/material.dart';

mixin LemonBottomSheet<M extends StatelessWidget> on Widget {
  Future<dynamic> showAsBottomSheet(
    BuildContext context, {
    double? heightFactor,
  }) =>
      showModalBottomSheet<dynamic>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        isDismissible: true,
        useRootNavigator: true,
        builder: (context) => Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          clipBehavior: Clip.hardEdge,
          child: FractionallySizedBox(
            heightFactor: heightFactor ?? 0.95,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  width: 35,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Expanded(child: this),
              ],
            ),
          ),
        ),
      );
}
