import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/web3/web3_repository.dart';
import 'package:app/core/service/web3/web3_contract_service.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/material.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:http/http.dart' as http;

class StakingConfigInfoWidget extends StatelessWidget {
  final PaymentAccount? paymentAccount;

  const StakingConfigInfoWidget({
    super.key,
    required this.paymentAccount,
  });

  DateTime? get checkInBefore =>
      paymentAccount?.accountInfo?.requirementCheckinBefore;

  String? get configId => paymentAccount?.accountInfo?.configId;

  String? get network => paymentAccount?.accountInfo?.network;

  Future<int> getRefundConfig() async {
    try {
      final chainResponse =
          await getIt<Web3Repository>().getChainById(chainId: network ?? '');
      if (chainResponse.isLeft()) {
        return -1;
      }
      final chain = chainResponse.getOrElse(() => null);
      final web3Client = Web3Client(chain?.rpcUrl ?? '', http.Client());
      final contract =
          Web3ContractService.getStakeVaultContract(configId ?? '');
      final response = await web3Client.call(
        contract: contract,
        function: contract.function('refundPPM'),
        params: [],
      );
      if (response.isEmpty) {
        return -1;
      }
      final refundPPM = response[0];
      if (refundPPM is! BigInt) {
        return -1;
      }
      return refundPPM.toInt() ~/ 10000;
    } catch (err) {
      return -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final t = Translations.of(context);
    final displayedDate = checkInBefore != null
        ? DateFormatUtils.custom(
            checkInBefore!,
            pattern: 'EEEE, MMMM d, h:mm a',
          )
        : '';
    return FutureBuilder(
      future: getRefundConfig(),
      builder: (context, snapshot) {
        final refundPPM = snapshot.data;
        return Text.rich(
          TextSpan(
            text: t.common.actions.checkIn,
            style: appText.sm.copyWith(color: appColors.textTertiary),
            children: [
              TextSpan(
                text:
                    ' ${t.event.eventBuyTickets.beforeTime(time: displayedDate)} ',
                style: appText.sm.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (refundPPM != null && refundPPM != -1)
                TextSpan(
                  text: t.event.eventBuyTickets.claimStakingRefund(
                    percentage: '$refundPPM%',
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
