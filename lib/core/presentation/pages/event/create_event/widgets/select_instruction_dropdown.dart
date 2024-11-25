import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_custom_instructions_setting_page/event_custom_instructions_setting_page.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/domain/event/input/get_event_detail_input.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SelectInstructionDropdown extends StatefulWidget {
  final String initialInstruction;
  final Function(String selectedInstruction)? onChange;
  final String? parentEventId;

  const SelectInstructionDropdown({
    super.key,
    this.initialInstruction = '',
    this.onChange,
    this.parentEventId,
  });

  @override
  State<SelectInstructionDropdown> createState() =>
      _SelectInstructionDropdownState();
}

class _SelectInstructionDropdownState extends State<SelectInstructionDropdown> {
  String selectedItem = '';
  List<String> addressDirections = [];

  @override
  void initState() {
    super.initState();
    selectedItem = widget.initialInstruction;
    _fetchEventDetail();
  }

  Future<void> _fetchEventDetail() async {
    final result = await getIt<EventRepository>().getEventDetail(
      input: GetEventDetailInput(id: widget.parentEventId ?? ''),
    );

    result.fold(
      (failure) {
        // Handle error if needed
      },
      (event) {
        setState(() {
          addressDirections = event.addressDirections ?? [];
        });
      },
    );
  }

  void _handleInstructionSelection(String instruction) {
    setState(() => selectedItem = instruction);
    widget.onChange?.call(instruction);
  }

  void _showInstructionModal([String? initialInstruction]) {
    Vibrate.feedback(FeedbackType.light);
    showCupertinoModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (mContext) => EventCustomInstructionsSettingPage(
        instruction: initialInstruction,
        onConfirm: _handleInstructionSelection,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isCustomInstruction =
        selectedItem.isNotEmpty && !addressDirections.contains(selectedItem);

    return isCustomInstruction
        ? _CustomInstructionButton(
            instruction: selectedItem,
            onTap: () => _showInstructionModal(selectedItem),
          )
        : _InstructionDropdown(
            selectedItem: selectedItem,
            addressDirections: addressDirections,
            onAddNewInstruction: _showInstructionModal,
            onSelectInstruction: _handleInstructionSelection,
          );
  }
}

class _CustomInstructionButton extends StatelessWidget {
  final String instruction;
  final VoidCallback onTap;

  const _CustomInstructionButton({
    required this.instruction,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(Spacing.small),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LemonRadius.small),
          color: LemonColor.chineseBlack,
        ),
        child: Row(
          children: [
            ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icSymbolConversion.svg(
                width: Sizing.mSmall,
                height: Sizing.mSmall,
                colorFilter: filter,
              ),
            ),
            SizedBox(width: Spacing.small),
            Expanded(
              child: Text(
                instruction,
                style: Typo.medium.copyWith(color: colorScheme.onPrimary),
              ),
            ),
            SizedBox(width: Spacing.xSmall),
            ThemeSvgIcon(
              color: LemonColor.white18,
              builder: (filter) => Assets.icons.icEdit.svg(
                width: Sizing.mSmall,
                height: Sizing.mSmall,
                colorFilter: filter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InstructionDropdown extends StatelessWidget {
  final String selectedItem;
  final List<String> addressDirections;
  final VoidCallback onAddNewInstruction;
  final Function(String) onSelectInstruction;

  const _InstructionDropdown({
    required this.selectedItem,
    required this.addressDirections,
    required this.onAddNewInstruction,
    required this.onSelectInstruction,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        value: selectedItem.isEmpty ? null : selectedItem,
        onChanged: (value) => onSelectInstruction(value ?? ''),
        customButton: Container(
          width: double.infinity,
          padding: EdgeInsets.all(Spacing.small),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(LemonRadius.small),
            color: LemonColor.chineseBlack,
          ),
          child: Row(
            children: [
              ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => selectedItem.isNotEmpty
                    ? Assets.icons.icSymbolConversion.svg(
                        width: Sizing.mSmall,
                        height: Sizing.mSmall,
                        colorFilter: filter,
                      )
                    : Assets.icons.icPlus.svg(
                        width: Sizing.mSmall,
                        height: Sizing.mSmall,
                        colorFilter: filter,
                      ),
              ),
              SizedBox(width: Spacing.small),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    selectedItem.isNotEmpty
                        ? Text(
                            selectedItem,
                            style: Typo.medium.copyWith(
                              color: selectedItem.isEmpty
                                  ? colorScheme.onSecondary
                                  : colorScheme.onPrimary,
                            ),
                          )
                        : Text(
                            t.event.instructions.addInstructions,
                            style: Typo.medium.copyWith(
                              color: colorScheme.onSecondary,
                            ),
                          ),
                  ],
                ),
              ),
              SizedBox(width: Spacing.xSmall),
              ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) =>
                    Assets.icons.icArrowUpDown.svg(colorFilter: filter),
              ),
            ],
          ),
        ),
        items: <DropdownMenuItem<String>>[
          // Special first item
          DropdownMenuItem<String>(
            value: '',
            child: StatefulBuilder(
              builder: (context, menuSetState) {
                return InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Vibrate.feedback(FeedbackType.light);
                    showCupertinoModalBottomSheet(
                      context: context,
                      useRootNavigator: true,
                      builder: (mContext) => EventCustomInstructionsSettingPage(
                        onConfirm: (instruction) {
                          onSelectInstruction(instruction);
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 50.w,
                    padding: EdgeInsets.symmetric(
                      horizontal: Spacing.small,
                    ),
                    child: Row(
                      children: [
                        ThemeSvgIcon(
                          color: LemonColor.paleViolet,
                          builder: (filter) => Assets.icons.icPlus.svg(
                            colorFilter: filter,
                            width: Sizing.mSmall,
                            height: Sizing.mSmall,
                          ),
                        ),
                        SizedBox(width: Spacing.small),
                        Text(
                          t.event.instructions.addInstructions,
                          style: Typo.medium.copyWith(
                            color: LemonColor.paleViolet,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          ...addressDirections.map(
            (addressDirection) => DropdownMenuItem<String>(
              value: addressDirection,
              child: StatefulBuilder(
                builder: (context, menuSetState) {
                  final selected = selectedItem == addressDirection;
                  return InkWell(
                    onTap: () {
                      onSelectInstruction(addressDirection);
                      Navigator.pop(context);
                    },
                    child: _SelectInstructionItem(
                      addressDirection: addressDirection,
                      selected: selected,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(LemonRadius.medium),
            color: LemonColor.chineseBlack,
          ),
          padding: EdgeInsets.zero,
          offset: Offset(0, -Spacing.superExtraSmall),
        ),
        menuItemStyleData: const MenuItemStyleData(
          overlayColor: MaterialStatePropertyAll(LemonColor.darkBackground),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}

class _SelectInstructionItem extends StatelessWidget {
  final String addressDirection;
  final bool selected;
  const _SelectInstructionItem({
    required this.addressDirection,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: 50.w,
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.small,
      ),
      decoration: BoxDecoration(
        color: selected ? LemonColor.white06 : Colors.transparent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              addressDirection,
              style: Typo.medium.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          if (selected)
            ThemeSvgIcon(
              color: colorScheme.onPrimary,
              builder: (filter) => Assets.icons.icChecked.svg(
                colorFilter: filter,
              ),
            ),
        ],
      ),
    );
  }
}
