import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/select_event_page/select_event_page.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/core/utils/permission_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';

class CreateLensPostBottomBar extends StatefulWidget {
  final TextEditingController? controller;
  final Function()? onSubmit;
  final Function(Event)? onEventSelected;
  final Function(XFile)? onImagePick;

  const CreateLensPostBottomBar({
    super.key,
    this.controller,
    this.onSubmit,
    this.onEventSelected,
    this.onImagePick,
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

  void selectEvent(BuildContext context) async {
    await showCupertinoModalBottomSheet(
      context: context,
      builder: (context) {
        return SelectEventPage(
          onEventSelected: (event) {
            widget.onEventSelected?.call(event);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void pickImage(BuildContext context) async {
    final hasPermission = await PermissionUtils.checkPhotosPermission(context);
    if (!hasPermission) {
      return;
    }
    final image = await getImageFromGallery();
    if (image == null) return;
    widget.onImagePick?.call(image);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appColors = context.theme.appColors;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: appColors.pageDivider,
          ),
        ),
      ),
      padding: EdgeInsets.all(Spacing.s4),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    selectEvent(context);
                  },
                  child: ThemeSvgIcon(
                    color: appColors.textPrimary,
                    builder: (filter) => Assets.icons.icCelebrationOutline.svg(
                      colorFilter: filter,
                    ),
                  ),
                ),
                SizedBox(width: Spacing.s6),
                InkWell(
                  onTap: () => pickImage(context),
                  child: ThemeSvgIcon(
                    color: appColors.textPrimary,
                    builder: (filter) => Assets.icons.icCamera.svg(
                      colorFilter: filter,
                    ),
                  ),
                ),
              ],
            ),
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
