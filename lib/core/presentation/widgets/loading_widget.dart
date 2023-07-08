import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading {
  static Widget defaultLoading(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: CupertinoActivityIndicator(
        color: colorScheme.onPrimary,
      ),
    );
  }
}
