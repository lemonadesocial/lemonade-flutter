import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/domain/token/entities/token_entities.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TicketAssignPopup extends StatelessWidget {
  const TicketAssignPopup({
    super.key,
    this.token,
    this.onClose,
  });

  final TokenDetail? token;
  final Function()? onClose;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(LemonRadius.normal),
      ),
      backgroundColor: LemonColor.chineseBlack,
      insetPadding: EdgeInsets.only(
        left: Spacing.smMedium,
        right: Spacing.smMedium,
      ),
      child: SizedBox(
        child: Padding(
          padding: EdgeInsets.all(Spacing.medium),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${t.event.eventTicketManagement.assignTicket} ${t.event.tickets(n: 1)}',
                    style: Typo.extraMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: ThemeSvgIcon(
                      color: colorScheme.onPrimary.withOpacity(0.18),
                      builder: (filter) => Assets.icons.icClose.svg(
                        colorFilter: filter,
                        width: Sizing.small,
                        height: Sizing.small,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Spacing.smMedium),
              // TODO: Ticket info
              Container(
                clipBehavior: Clip.hardEdge,
                padding: EdgeInsets.all(Spacing.smMedium),
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(LemonRadius.small),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(LemonRadius.small / 2),
                      child: CachedNetworkImage(
                        width: Sizing.medium,
                        height: Sizing.medium,
                        imageUrl:
                            "https://s3-alpha-sig.figma.com/img/8448/74ff/afa063f89d78e9f9137eb4b299f6643c?Expires=1696204800&Signature=NRQC5vG1JIAcF9Yd4TeIJTXxU2c1yxQTm-n14IBB6NYqPmX8wWQ5~SbSfuJ-RfDIPUMhJjIBhzUV-ifKCSyDeimfyh0jZ-W5yWawNFyicnAIbKeuA9Fu9qvjebqI2y2mzCkRCi1qa0AWRcN9DZVGnSrWyBHojDyyYEFA5nY-dl263a9P~PDSL4v3G-83CFu2fuX6OIoT3uNUiF4yRXFwjRuYJrLSUrTPM~3onkWkiDTmp6O2R51czghgCJ1MNZeFzlIi8HNJfgmLaq5S-dZKweO6BuPx0vhCCd3OsQSaA8CeXbuyLhCPdtJTGdV8LHigFhLuNYlrTmxamb09zcI8oQ__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4",
                        placeholder: (context, url) =>
                            ImagePlaceholder.defaultPlaceholder(),
                        errorWidget: (context, url, err) =>
                            ImagePlaceholder.defaultPlaceholder(),
                      ),
                    ),
                    SizedBox(width: Spacing.xSmall),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Festival pass ${NumberUtils.formatCurrency(amount: 5000, currency: Currency.USD)}',
                          style: Typo.medium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 2.w,
                        ),
                        Text(
                          'Culture fest',
                          style: Typo.small.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: Spacing.xSmall),
              SizedBox(
                height: Sizing.xLarge,
                child: LemonTextField(
                  hintText: t.event.eventTicketManagement.ticketHolderEmail,
                  onChange: (v) {},
                ),
              ),
              SizedBox(height: Spacing.medium),
              SizedBox(
                height: 42.w,
                child: LinearGradientButton(
                  mode: GradientButtonMode.lavenderMode,
                  radius: BorderRadius.circular(LemonRadius.xSmall),
                  label: t.event.eventTicketManagement.assignTicket,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
