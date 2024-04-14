import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CheckGuildRoomRolesBottomSheet extends StatefulWidget {
  final Function() onEnterChannel;

  const CheckGuildRoomRolesBottomSheet({
    super.key,
    required this.onEnterChannel,
  });

  @override
  State<CheckGuildRoomRolesBottomSheet> createState() =>
      _CheckGuildRoomRolesBottomSheetState();
}

class _CheckGuildRoomRolesBottomSheetState
    extends State<CheckGuildRoomRolesBottomSheet> {
  bool isValid = false;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      controller: ModalScrollController.of(context),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: LemonColor.chineseBlack,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: Spacing.xSmall,
                  right: Spacing.xSmall,
                  top: Spacing.large,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      t.chat.guild.citizenOnlyAccess,
                      style: Typo.extraLarge.copyWith(
                        color: colorScheme.onPrimary,
                        fontFamily: FontFamily.nohemiVariable,
                      ),
                    ),
                    SizedBox(height: Spacing.superExtraSmall),
                    Text(
                      t.chat.guild.citizenOnlyAccessDescription,
                      style: Typo.medium.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Spacing.smMedium),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: colorScheme.outline,
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: Spacing.smMedium,
                  horizontal: Spacing.xSmall,
                ),
                child: Opacity(
                  opacity: isValid ? 1 : 0.5,
                  child: LinearGradientButton.primaryButton(
                    onTap: () {
                      if (!isValid) {
                        return;
                      }
                      widget.onEnterChannel();
                    },
                    label: t.event.ticketTierSetting.whitelistSetting
                        .addToWhitelist,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
