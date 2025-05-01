import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateLensPostBottomBar extends StatefulWidget {
  final Function()? onSubmit;
  final TextEditingController? controller;

  const CreateLensPostBottomBar({
    super.key,
    this.onSubmit,
    this.controller,
  });

  @override
  State<CreateLensPostBottomBar> createState() =>
      _CreateLensPostBottomBarState();
}

class _CreateLensPostBottomBarState extends State<CreateLensPostBottomBar> {
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_validate);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_validate);
    super.dispose();
  }

  void _validate() {
    final content = (widget.controller?.text ?? '').trim();
    setState(() {
      _isValid = content.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: colorScheme.outline,
          ),
        ),
      ),
      padding: EdgeInsets.only(
        top: Spacing.smMedium,
        bottom: Spacing.smMedium,
        left: Spacing.smMedium,
        right: Spacing.smMedium,
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            SizedBox(
              width: 72.w,
              height: Sizing.medium,
              child: Opacity(
                opacity: _isValid ? 1.0 : 0.5,
                child: LinearGradientButton.primaryButton(
                  radius: BorderRadius.circular(LemonRadius.button),
                  onTap: _isValid ? widget.onSubmit : null,
                  label: t.common.actions.post,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
