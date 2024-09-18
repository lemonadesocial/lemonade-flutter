import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestLimitSelectBottomSheet extends StatefulWidget {
  final String? title;
  final String? description;
  final int? initialValue;
  final Function()? onRemove;
  final Function(int)? onSetLimit;

  const GuestLimitSelectBottomSheet({
    super.key,
    required this.title,
    required this.description,
    this.initialValue,
    this.onRemove,
    this.onSetLimit,
  });

  @override
  GuestLimitSelectBottomSheetState createState() =>
      GuestLimitSelectBottomSheetState();
}

class GuestLimitSelectBottomSheetState
    extends State<GuestLimitSelectBottomSheet> {
  late int initialNumber;

  @override
  void initState() {
    super.initState();
    initialNumber = widget.initialValue ?? 0;
  }

  void _increment() {
    setState(() {
      initialNumber++;
    });
  }

  void _decrement() {
    setState(() {
      initialNumber--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      color: LemonColor.atomicBlack,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const BottomSheetGrabber(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Spacing.smMedium,
                vertical: Spacing.medium,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title ?? '',
                    style: Typo.large.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  SizedBox(height: Spacing.superExtraSmall),
                  Text(
                    widget.description ?? '',
                    style: Typo.medium.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.54),
                    ),
                  ),
                  SizedBox(height: Spacing.medium),
                  Container(
                    padding: EdgeInsets.all(Spacing.small),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: colorScheme.onSurface.withOpacity(0.12),
                      ),
                      borderRadius: BorderRadius.circular(LemonRadius.small),
                    ),
                    child: Row(
                      children: [
                        _MinusPlusButton(
                          onTap: _decrement,
                          icon: ThemeSvgIcon(
                            color: colorScheme.onSecondary,
                            builder: (colorFilter) => Assets.icons.icMinus.svg(
                              colorFilter: colorFilter,
                              width: 18.w,
                              height: 18.w,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            initialNumber.toString(),
                            textAlign: TextAlign.center,
                            style: Typo.large.copyWith(
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ),
                        _MinusPlusButton(
                          onTap: _increment,
                          icon: ThemeSvgIcon(
                            color: colorScheme.onSecondary,
                            builder: (colorFilter) => Assets.icons.icPlus.svg(
                              colorFilter: colorFilter,
                              width: 18.w,
                              height: 18.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(Spacing.small),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1,
                    color: colorScheme.onSurface.withOpacity(0.06),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: LinearGradientButton.secondaryButton(
                      label: t.common.actions.remove,
                      onTap: widget.onRemove,
                    ),
                  ),
                  SizedBox(width: Spacing.small),
                  Expanded(
                    child: LinearGradientButton.primaryButton(
                      label: t.common.actions.setLimit,
                      onTap: () {
                        if (widget.onSetLimit != null) {
                          widget.onSetLimit!(initialNumber);
                        }
                      },
                    ),
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

class _MinusPlusButton extends StatelessWidget {
  final Widget icon;
  final Function() onTap;

  const _MinusPlusButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.w,
        height: 36.w,
        padding: EdgeInsets.all(Spacing.extraSmall),
        decoration: ShapeDecoration(
          color: colorScheme.onSurface.withOpacity(0.12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.r),
          ),
        ),
        child: Center(child: icon),
      ),
    );
  }
}
