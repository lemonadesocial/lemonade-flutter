import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class EmptyTabView extends StatelessWidget {
  const EmptyTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('🍋', style: Typo.large),
    );
  }
}
