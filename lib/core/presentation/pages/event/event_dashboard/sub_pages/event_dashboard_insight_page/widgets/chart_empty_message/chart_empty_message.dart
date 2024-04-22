import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class ChartEmptyMessage extends StatelessWidget {
  final bool isLoading;
  final String? title;
  final String? description;
  const ChartEmptyMessage({
    super.key,
    required this.isLoading,
    this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Positioned.fill(
      child: isLoading
          ? Center(
              child: Loading.defaultLoading(context),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title ?? '',
                  style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description ?? '',
                  style: Typo.small.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
    );
  }
}
