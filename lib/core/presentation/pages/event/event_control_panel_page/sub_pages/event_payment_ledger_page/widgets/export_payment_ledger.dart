import 'dart:io';

import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/domain/web3/web3_repository.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:collection/collection.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ExportPaymentLedgerWidget extends StatefulWidget {
  final List<Payment> payments;
  final Event? event;
  const ExportPaymentLedgerWidget({
    super.key,
    required this.payments,
    required this.event,
  });

  @override
  State<ExportPaymentLedgerWidget> createState() =>
      _ExportPaymentLedgerWidgetState();
}

class _ExportPaymentLedgerWidgetState extends State<ExportPaymentLedgerWidget> {
  Future<void> exportMapListToCsv({
    required List<Map<String, dynamic>> dataList,
    required String fileName,
    String delimiter = ',',
  }) async {
    try {
      if (dataList.isEmpty) return;

      // Get headers from the first item
      final headers = dataList.first.keys.toList();

      // Convert data to list of lists format for CSV
      List<List<dynamic>> csvData = [
        headers, // Add headers as first row
        ...dataList.map(
          (map) =>
              headers.map((header) => map[header]?.toString() ?? '').toList(),
        ),
      ];

      // Convert to CSV string
      String csv = ListToCsvConverter(
        fieldDelimiter: delimiter,
      ).convert(csvData);

      // Get temporary directory
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/$fileName.csv');

      // Write to file
      await file.writeAsString(csv);

      // Share the file
      await Share.shareXFiles(
        [XFile(file.path)],
        subject: fileName,
      );
    } catch (e) {
      SnackBarUtils.showError(message: e.toString());
    }
  }

  Future<void> exportPaymentLedgerToCsv({
    required List<Payment> payments,
    required String eventName,
  }) async {
    final chains = (await getIt<Web3Repository>().getChainsList())
        .fold((l) => <Chain>[], (r) => r);

    final dataList = payments
        .map(
          (payment) => {
            'ID': payment.id,
            'Name': payment.buyerName,
            'Email': payment.buyerEmail,
            'Purchase Date': payment.stamps?['succeeded'] ??
                payment.stamps?['await_capture'] ??
                payment.stamps?['initialized'] ??
                '',
            'Ticket Tiers':
                payment.ticketTypesExpanded?.map((e) => e.title).join(','),
            'Amount': payment.formattedTotalAmount,
            'Currency': payment.currency,
            'Promo Code': payment.discountCode,
            'Discount Amount': payment.formattedDiscountAmount,
            'Network': payment.cryptoPaymentInfo?.network != null
                ? chains
                    .firstWhereOrNull(
                      (chain) =>
                          chain.chainId == payment.cryptoPaymentInfo?.network,
                    )
                    ?.name
                : '',
            'Payment Method': payment.stripePaymentInfo?.card?.brand ??
                payment.transferParams?['from']?.toString() ??
                '',
            'Payment ID/Trx': payment.stripePaymentInfo?.paymentIntent ??
                payment.cryptoPaymentInfo?.txHash ??
                '',
            'Status': payment.state
                .toString()
                .replaceAll('Enum\$NewPaymentState.', ''),
          },
        )
        .toList();

    await exportMapListToCsv(
      dataList: dataList,
      fileName:
          '${eventName}_payments_ledger_${DateTime.now().millisecondsSinceEpoch}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () => exportPaymentLedgerToCsv(
        payments: widget.payments,
        eventName: widget.event?.title ?? '',
      ),
      child: Container(
        width: Sizing.medium,
        height: Sizing.medium,
        decoration: BoxDecoration(
          color: LemonColor.atomicBlack,
          borderRadius: BorderRadius.circular(Sizing.medium),
        ),
        child: Center(
          child: ThemeSvgIcon(
            color: colorScheme.onPrimary,
            builder: (filter) => Assets.icons.icDownload.svg(
              colorFilter: filter,
            ),
          ),
        ),
      ),
    );
  }
}
