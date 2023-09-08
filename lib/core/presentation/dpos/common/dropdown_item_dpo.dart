import 'package:flutter/material.dart';

class DropdownItemDpo<T> {
  final String label;
  final Widget? leadingIcon;
  final T? value;

  DropdownItemDpo({
    required this.label,
    this.value,
    this.leadingIcon,
  });
}
