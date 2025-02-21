import 'package:app/core/data/payment/dtos/payment_dto/payment_dto.dart';
import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:app/core/presentation/pages/payment/guest_payment_detail_page/widgets/payment_detail_payment_info_widget.dart';
import 'package:app/core/presentation/pages/payment/guest_payment_detail_page/widgets/payment_detail_user_info_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/graphql/backend/payment/query/get_event_payment.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class GuestPaymentDetailPage extends StatefulWidget {
  final String eventId;
  final String paymentId;

  const GuestPaymentDetailPage({
    super.key,
    required this.eventId,
    required this.paymentId,
  });

  @override
  State<GuestPaymentDetailPage> createState() => _GuestPaymentDetailPageState();
}

class _GuestPaymentDetailPageState extends State<GuestPaymentDetailPage> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      appBar: const LemonAppBar(
        title: 'Guest detail',
      ),
      body: Query$GetEventPayment$Widget(
        options: Options$Query$GetEventPayment(
          variables: Variables$Query$GetEventPayment(
            event: widget.eventId,
            id: widget.paymentId,
          ),
        ),
        builder: (
          result, {
          refetch,
          fetchMore,
        }) {
          if (result.isLoading) {
            return Center(
              child: Loading.defaultLoading(context),
            );
          }
          if (result.hasException ||
              result.parsedData?.getEventPayment == null) {
            return Center(
              child: EmptyList(
                emptyText: t.common.somethingWrong,
              ),
            );
          }
          final payment = Payment.fromDto(
            PaymentDto.fromJson(
              result.parsedData!.getEventPayment!.toJson(),
            ),
          );

          final widgets = [
            PaymentDetailUserInfoWidget(payment: payment),
            PaymentDetailPaymentInfoWidget(payment: payment),
          ];
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: Spacing.small,
                ),
                sliver: SliverList.separated(
                  itemBuilder: (context, index) {
                    return widgets[index];
                  },
                  separatorBuilder: (context, index) => Divider(
                    color: colorScheme.outline,
                    height: Spacing.medium * 2,
                  ),
                  itemCount: widgets.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
