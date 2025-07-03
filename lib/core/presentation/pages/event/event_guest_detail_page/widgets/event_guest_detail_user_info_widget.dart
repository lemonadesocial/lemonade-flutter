import 'package:app/core/domain/event/entities/event_guest_detail/event_guest_detail.dart';
import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/onboarding/onboarding_inputs.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class EventGuestDetailUserInfoWidget extends StatelessWidget {
  final EventGuestDetail? eventGuestDetail;
  final List<EventTicket>? eventTickets;
  const EventGuestDetailUserInfoWidget({
    super.key,
    this.eventGuestDetail,
    this.eventTickets,
  });

  String get _nonLoginDisplayName =>
      eventGuestDetail?.joinRequest?.nonLoginUser?.displayName ?? '';
  String get _buyerName => eventGuestDetail?.user.name ?? '';
  String get _name => _buyerName.isNotEmpty ? _buyerName : _nonLoginDisplayName;
  String get _buyerAvatar => eventGuestDetail?.user.imageAvatar ?? '';
  String get _buyerEmail =>
      eventGuestDetail?.user.email ?? t.event.eventGuestDetail.NA;
  DateTime? get _joinRequestCreatedAt =>
      eventGuestDetail?.joinRequest?.createdAt;
  Map<String, DateTime>? get _stamps => eventGuestDetail?.payment?.stamps;
  DateTime? get _paymentStampsCreatedAt => _stamps?['created'];
  EventJoinRequest? get _joinRequest => eventGuestDetail?.joinRequest;

  String _getFormattedTimestamp(BuildContext context) {
    final t = Translations.of(context);

    if (_joinRequestCreatedAt != null) {
      return DateFormatUtils.custom(
        _joinRequestCreatedAt!,
        pattern: 'dd MMM, HH:mm',
      );
    }

    if (_paymentStampsCreatedAt != null) {
      return DateFormatUtils.custom(
        _paymentStampsCreatedAt!,
        pattern: 'dd MMM, HH:mm',
      );
    }

    return t.event.eventGuestDetail.NA;
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    return Column(
      children: [
        Row(
          children: [
            LemonNetworkImage(
              imageUrl: _buyerAvatar,
              width: Sizing.medium,
              height: Sizing.medium,
              borderRadius: BorderRadius.circular(Sizing.medium),
              placeholder: ImagePlaceholder.avatarPlaceholder(),
            ),
            SizedBox(width: Spacing.xSmall),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_name.isNotEmpty)
                    Text(
                      _name,
                      style: appText.md,
                    ),
                  if (_buyerEmail.isNotEmpty)
                    Text(
                      _buyerEmail,
                      style: appText.sm.copyWith(
                        color: appColors.textSecondary,
                      ),
                    ),
                ],
              ),
            ),
            if (_joinRequest != null)
              _ApprovalStatus(
                joinRequest: _joinRequest!,
              ),
          ],
        ),
        SizedBox(
          height: Spacing.medium,
        ),
        Row(
          children: [
            _InfoItem(
              title: t.event.eventGuestDetail.registeredOn,
              value: _getFormattedTimestamp(context),
            ),
            SizedBox(
              height: Sizing.medium,
              child: VerticalDivider(
                color: appColors.pageDivider,
                thickness: 1,
                width: Spacing.large,
              ),
            ),
            _InfoItem(
              title: t.event.eventGuestDetail.tickets,
              value:
                  '${eventTickets?.length ?? 0} ${t.event.tickets(n: eventTickets?.length ?? 0)}',
            ),
            SizedBox(
              height: Sizing.medium,
              child: VerticalDivider(
                color: appColors.pageDivider,
                thickness: 1,
                width: Spacing.large,
              ),
            ),
            FutureBuilder(
              future: eventGuestDetail?.user.id != null
                  ? getIt<UserRepository>().getUserProfile(
                      GetProfileInput(
                        id: eventGuestDetail?.user.id,
                      ),
                    )
                  : Future.value(null),
              builder: (context, snapshot) {
                final user = snapshot.data?.fold((l) => null, (r) => r);
                final ethAddress = user?.walletsNew?['ethereum']?.firstOrNull;
                return _InfoItem(
                  title: t.event.rsvpWeb3Indetity.ethAddress,
                  value: ethAddress != null
                      ? Web3Utils.formatIdentifier(ethAddress)
                      : '--',
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String title;
  final String value;
  const _InfoItem({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: appText.sm.copyWith(
                color: appColors.textSecondary,
              ),
            ),
          ],
        ),
        SizedBox(height: Spacing.superExtraSmall),
        Text(
          value,
          style: appText.md,
        ),
      ],
    );
  }
}

class _ApprovalStatus extends StatelessWidget {
  final EventJoinRequest joinRequest;
  const _ApprovalStatus({
    required this.joinRequest,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    Color? color;
    String displayText;

    if (joinRequest.isPending) {
      displayText = t.event.eventGuestDetail.pending;
      color = appColors.textSecondary;
    } else if (joinRequest.isDeclined) {
      displayText = t.event.eventGuestDetail.declined;
      color = appColors.textError;
    } else {
      displayText = t.event.eventGuestDetail.going;
      color = appColors.textSuccess;
    }

    return Container(
      padding: EdgeInsets.all(
        Spacing.superExtraSmall,
      ),
      decoration: BoxDecoration(
        color: LemonColor.chineseBlack,
        borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
        border: Border.all(
          color: appColors.pageDivider,
        ),
      ),
      child: Text(
        displayText,
        style: appText.sm.copyWith(
          color: color,
        ),
      ),
    );
  }
}
