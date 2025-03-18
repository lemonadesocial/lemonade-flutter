import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SetLimitBottomSheet extends StatefulWidget {
  /// if return null, user close;
  /// if return -1, it means unlimited;
  /// otherwise, it is the limit
  static Future<int?> show(
    BuildContext context, {
    required String title,
    required String description,
    int? initialValue,
  }) async {
    return showCupertinoModalBottomSheet(
      context: context,
      backgroundColor: LemonColor.atomicBlack,
      barrierColor: Colors.black.withOpacity(0.5),
      expand: false,
      builder: (context) => SetLimitBottomSheet(
        title: title,
        description: description,
        initialValue: initialValue,
      ),
    );
  }

  final String? title;
  final String? description;
  final int? initialValue;

  const SetLimitBottomSheet({
    super.key,
    required this.title,
    required this.description,
    this.initialValue,
  });

  @override
  SetLimitBottomSheetState createState() => SetLimitBottomSheetState();
}

class SetLimitBottomSheetState extends State<SetLimitBottomSheet> {
  late int initialNumber;
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    initialNumber = widget.initialValue ?? 0;
    _textEditingController =
        TextEditingController(text: initialNumber.toString());
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _increment() {
    setState(() {
      initialNumber++;
      _textEditingController.text = initialNumber.toString();
    });
  }

  void _decrement() {
    setState(() {
      if (initialNumber > 0) {
        initialNumber--;
        _textEditingController.text = initialNumber.toString();
      }
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
                          child: TextField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            controller: _textEditingController,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            style: Typo.large.copyWith(
                              color: colorScheme.onSurface,
                            ),
                            cursorColor: colorScheme.onSurface,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 8),
                            ),
                            onTap: () {
                              _textEditingController.selection =
                                  TextSelection.fromPosition(
                                TextPosition(
                                  offset: _textEditingController.text.length,
                                ),
                              );
                            },
                            onChanged: (value) {
                              setState(() {
                                initialNumber =
                                    int.tryParse(value) ?? initialNumber;
                                _textEditingController.text =
                                    initialNumber.toString();
                                _textEditingController.selection =
                                    TextSelection.fromPosition(
                                  TextPosition(
                                    offset: _textEditingController.text.length,
                                  ),
                                );
                              });
                            },
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
                    child: LemonOutlineButton(
                      height: 48.w,
                      label: t.common.actions.remove,
                      backgroundColor: LemonColor.chineseBlack,
                      radius: BorderRadius.circular(LemonRadius.medium),
                      textStyle: Typo.mediumPlus.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                      onTap: () {
                        Navigator.pop(context, -1);
                      },
                    ),
                  ),
                  SizedBox(width: Spacing.small),
                  Expanded(
                    child: LinearGradientButton.primaryButton(
                      label: t.common.actions.setLimit,
                      onTap: () {
                        Navigator.pop(context, initialNumber);
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
