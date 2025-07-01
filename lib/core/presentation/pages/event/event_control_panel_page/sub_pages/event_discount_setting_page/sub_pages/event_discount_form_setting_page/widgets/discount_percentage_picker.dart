import 'package:app/core/application/event/create_event_discount_bloc/create_event_discount_bloc.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<double> prefixPercentages = [0.1, 0.2, 0.5, 0.7, 1];

class DiscountPercentagePicker extends StatelessWidget {
  final bool? readOnly;
  const DiscountPercentagePicker({
    super.key,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appColors = context.theme.appColors;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.event.eventPromotions.discountPercent,
          style: Typo.mediumPlus.copyWith(
            color: appColors.textPrimary,
          ),
        ),
        SizedBox(height: Spacing.xSmall),
        BlocBuilder<CreateEventDiscountBloc, CreateEventDiscountState>(
          buildWhen: (previous, current) =>
              current.data.ratio != previous.data.ratio,
          builder: (context, state) => _Picker(
            readOnly: readOnly,
            ratio: state.data.ratio ?? 0,
            onChangeRatio: (newRatio) {
              context.read<CreateEventDiscountBloc>().add(
                    CreateEventDiscountEvent.onRatioChanged(
                      ratio: newRatio,
                    ),
                  );
            },
          ),
        ),
        SizedBox(height: Spacing.xSmall),
        SizedBox(
          height: Sizing.medium,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...prefixPercentages.map(
                (item) {
                  final displayPercentage = '${(item * 100).toInt()}%';
                  return LemonOutlineButton(
                    onTap: () {
                      if (readOnly == true) {
                        return;
                      }
                      context.read<CreateEventDiscountBloc>().add(
                            CreateEventDiscountEvent.onRatioChanged(
                              ratio: item.toDouble(),
                            ),
                          );
                    },
                    radius: BorderRadius.circular(LemonRadius.normal),
                    label: displayPercentage,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Picker extends StatelessWidget {
  final double ratio;
  final bool? readOnly;
  final Function(double ratio)? onChangeRatio;

  const _Picker({
    required this.ratio,
    this.onChangeRatio,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final displayPercentage = '${(ratio * 100).toInt()}%';

    return Container(
      padding: EdgeInsets.all(Spacing.xSmall),
      decoration: BoxDecoration(
        border: Border.all(color: appColors.pageDivider),
        borderRadius: BorderRadius.circular(LemonRadius.small),
      ),
      child: SizedBox(
        height: Sizing.large,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _Button(
              onTap: () {
                if (readOnly == true) {
                  return;
                }
                if (ratio > 0) {
                  onChangeRatio?.call(ratio - 0.01);
                }
              },
              icon: Icon(
                Icons.remove,
                color: appColors.textTertiary,
              ),
            ),
            Text(
              displayPercentage,
              style: Typo.extraLarge.copyWith(
                color: appColors.textPrimary,
                fontFamily: FontFamily.clashDisplay,
              ),
            ),
            _Button(
              onTap: () {
                if (readOnly == true) {
                  return;
                }
                if (ratio < 1) {
                  onChangeRatio?.call(ratio + 0.01);
                }
              },
              icon: ThemeSvgIcon(
                color: appColors.textTertiary,
                builder: (colorFilter) => Assets.icons.icAdd.svg(
                  colorFilter: colorFilter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final Widget icon;
  final Function()? onTap;
  const _Button({
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Sizing.large,
        height: Sizing.large,
        decoration: BoxDecoration(
          color: appColors.cardBg,
          borderRadius: BorderRadius.circular(LemonRadius.xSmall),
        ),
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}
