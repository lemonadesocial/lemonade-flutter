import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
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
  final List<String> _admins = ['']; // Initialize with one empty field

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

  void _addNewAdmin() {
    setState(() {
      _admins.add('');
    });
  }

  void _removeAdmin(int index) {
    if (_admins.length > 1) {
      setState(() {
        _admins.removeAt(index);
      });
    }
  }

  void _updateAdmin(int index, String value) {
    setState(() {
      _admins[index] = value;
    });
  }

  bool get _isFormValid =>
      _nameController.text.isNotEmpty &&
      _admins.any((admin) => admin.isNotEmpty);

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

                  // Admins section
                  Text(
                    t.space.lens.admins,
                    style: TextStyle(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: Spacing.xSmall),
                  Column(
                    children: [
                      ..._admins.asMap().entries.map(
                            (entry) => Column(
                              children: [
                                _AdminField(
                                  value: entry.value,
                                  onChanged: (value) =>
                                      _updateAdmin(entry.key, value),
                                  onRemove: () => _removeAdmin(entry.key),
                                  removable: _admins.length > 1,
                                ),
                                SizedBox(height: Spacing.xSmall),
                              ],
                            ),
                          ),
                      SizedBox(height: Spacing.superExtraSmall),
                      _AddButton(
                        onPress: _addNewAdmin,
                      ),
                    ],
                  ),
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
                          await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Feed Data'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Name: ${_nameController.text}'),
                                  Text(
                                      'Description: ${_descriptionController.text}'),
                                  Text('Admins: ${_admins.join(", ")}'),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
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

class _AdminField extends StatelessWidget {
  final String value;
  final Function(String) onChanged;
  final VoidCallback onRemove;
  final bool removable;

  const _AdminField({
    required this.value,
    required this.onChanged,
    required this.onRemove,
    required this.removable,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 3,
            child: LemonTextField(
              initialText: value,
              hintText: t.space.lens.adminInputHint,
              onChange: onChanged,
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          InkWell(
            onTap: removable ? onRemove : null,
            child: Container(
              width: Sizing.large,
              height: Sizing.large,
              decoration: BoxDecoration(
                border: Border.all(
                  color: removable ? Colors.transparent : colorScheme.outline,
                ),
                color:
                    removable ? LemonColor.atomicBlack : colorScheme.background,
                borderRadius: BorderRadius.circular(LemonRadius.large * 2),
              ),
              child: Center(
                child: ThemeSvgIcon(
                  color: colorScheme.onSecondary,
                  builder: (filter) => Assets.icons.icClose.svg(
                    width: Sizing.xSmall,
                    height: Sizing.xSmall,
                    colorFilter: filter,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final VoidCallback onPress;

  const _AddButton({required this.onPress});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        InkWell(
          onTap: onPress,
          child: Container(
            width: Sizing.xLarge,
            height: Sizing.xLarge,
            decoration: BoxDecoration(
              color: colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(Sizing.xLarge),
            ),
            child: Center(
              child: ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => Assets.icons.icAdd.svg(
                  width: Sizing.xSmall,
                  height: Sizing.xSmall,
                  colorFilter: filter,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
