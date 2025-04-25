import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class CreateLensNewFeedBottomSheet extends StatefulWidget {
  final Space space;

  const CreateLensNewFeedBottomSheet({
    super.key,
    required this.space,
  });

  @override
  CreateLensNewFeedBottomSheetState createState() =>
      CreateLensNewFeedBottomSheetState();
}

class CreateLensNewFeedBottomSheetState
    extends State<CreateLensNewFeedBottomSheet> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<String> _selectedAdmins = [];

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.space.title ?? '';
    _descriptionController.text = widget.space.description ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool get _isFormValid =>
      _nameController.text.isNotEmpty &&
      _descriptionController.text.isNotEmpty &&
      _selectedAdmins.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      color: LemonColor.atomicBlack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BottomSheetGrabber(),
          LemonAppBar(
            title: t.space.lens.createNewFeed,
            backgroundColor: LemonColor.atomicBlack,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(Spacing.smMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name field
                  Text(
                    t.space.lens.name,
                    style: TextStyle(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: Spacing.xSmall),
                  LemonTextField(
                    controller: _nameController,
                    hintText: t.space.lens.name,
                    onChange: (_) => setState(() {}),
                  ),
                  SizedBox(height: Spacing.medium),

                  // Description field
                  Text(
                    t.space.lens.description,
                    style: TextStyle(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: Spacing.xSmall),
                  LemonTextField(
                    controller: _descriptionController,
                    hintText: t.space.lens.description,
                    maxLines: 3,
                    onChange: (_) => setState(() {}),
                  ),
                  SizedBox(height: Spacing.medium),

                  // Admins field
                  Text(
                    t.space.lens.admins,
                    style: TextStyle(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: Spacing.xSmall),
                  // TODO: Implement admin selection widget
                  // This could be a separate widget that shows selected admins
                  // and allows adding more through a search interface
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: LemonColor.atomicBlack,
              border: Border(
                top: BorderSide(color: colorScheme.outline),
              ),
            ),
            padding: EdgeInsets.all(Spacing.smMedium),
            child: SafeArea(
              child: Opacity(
                opacity: _isFormValid ? 1 : 0.5,
                child: LinearGradientButton.primaryButton(
                  onTap: _isFormValid
                      ? () async {
                          // TODO: Implement create feed logic
                          // This should call your feed creation API
                          AutoRouter.of(context).pop();
                        }
                      : null,
                  label: t.space.lens.createFeed,
                  textColor: colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
