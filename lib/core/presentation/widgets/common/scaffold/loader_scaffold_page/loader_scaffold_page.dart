import 'package:app/core/presentation/widgets/animation/circular_loading_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class LoaderScaffoldPage extends StatelessWidget {
  final String title;
  final String description;
  const LoaderScaffoldPage({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Spacer(),
            const CircularLoadingWidget(),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: Typo.extraLarge.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontFamily.nohemiVariable,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: Spacing.superExtraSmall),
                  Text(
                    description,
                    style: Typo.mediumPlus.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
