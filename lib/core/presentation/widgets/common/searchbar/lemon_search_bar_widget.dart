import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class LemonSearchBar extends StatelessWidget {
  final Function(String? text)? onChangeText;
  const LemonSearchBar({
    super.key,
    this.onChangeText,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: colorScheme.onSurfaceVariant,
          selectionColor: colorScheme.secondary,
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: LemonColor.darkCharcoal,
          filled: true,
          isCollapsed: true,
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(LemonRadius.xSmall),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: Spacing.xSmall,
            horizontal: Spacing.xSmall,
          ),
          hintStyle: Typo.medium.copyWith(color: colorScheme.onSurfaceVariant),
        ),
      ),
      child: SizedBox(
        height: 42,
        child: TextField(
          decoration: InputDecoration(
            prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
            prefixIcon: Padding(
              padding: EdgeInsets.only(
                left: Spacing.xSmall,
                right: Spacing.superExtraSmall,
              ),
              child: ThemeSvgIcon(
                color: colorScheme.onSurfaceVariant,
                builder: (filter) => Assets.icons.icSearch.svg(
                  colorFilter: filter,
                  width: 18,
                  height: 18,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            hintText: StringUtils.capitalize(t.common.search),
          ),
          onChanged: this.onChangeText,
        ),
      ),
    );
  }
}
