import 'package:app/core/application/farcaster/create_farcaster_cast_bloc/create_farcaster_cast_bloc.dart';
import 'package:app/core/presentation/pages/farcaster/create_farcaster_cast_page/widgets/create_cast_bottom_bar/select_farcaster_channels_dropdown.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateCastBottomBar extends StatelessWidget {
  final Function()? onSubmit;
  const CreateCastBottomBar({
    super.key,
    this.onSubmit,
  });

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
        color: LemonColor.atomicBlack,
      ),
      padding: EdgeInsets.only(
        top: Spacing.smMedium,
        bottom: Spacing.smMedium,
        left: Spacing.smMedium,
        right: Spacing.smMedium,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SelectFarcasterChannelsDropdown(),
          BlocBuilder<CreateFarcasterCastBloc, CreateFarcasterCastState>(
            builder: (context, state) => SizedBox(
              width: 105.w,
              height: Sizing.large,
              child: Opacity(
                opacity: state.isValid ? 1 : 0.5,
                child: LinearGradientButton.primaryButton(
                  onTap: () {
                    if (!state.isValid) {
                      return;
                    }
                    onSubmit?.call();
                  },
                  label: t.farcaster.cast,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
