import 'package:app/core/application/poap/transfer_poap_bloc/transfer_poap_bloc.dart';
import 'package:app/core/domain/poap/input/poap_input.dart';
import 'package:app/core/domain/token/entities/token_entities.dart';
import 'package:app/core/domain/poap/entities/poap_entities.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/dialog/lemon_alert_dialog.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/media_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web3dart/web3dart.dart';

class PoapTransferPopup extends StatelessWidget {
  const PoapTransferPopup({
    super.key,
    this.token,
    this.onBack,
    this.onClose,
  });

  final TokenDetail? token;
  final Function()? onBack;
  final Function()? onClose;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransferPoapBloc(),
      child: _PoapTransferPopupView(
        token: token,
        onBack: onBack,
        onClose: onClose,
      ),
    );
  }
}

class _PoapTransferPopupView extends StatefulWidget {
  const _PoapTransferPopupView({
    this.token,
    this.onBack,
    this.onClose,
  });

  final TokenDetail? token;
  final Function()? onBack;
  final Function()? onClose;

  @override
  State<_PoapTransferPopupView> createState() => _PoapTransferPopupState();
}

class _PoapTransferPopupState extends State<_PoapTransferPopupView> {
  String walletAddress = '';
  bool isAddressValid = false;

  bool validateAddress(String address) {
    if (address.isEmpty) return false;

    try {
      EthereumAddress.fromHex(address);
      return true;
    } catch (error) {
      return false;
    }
  }

  void onChange(String value) {
    setState(() {
      walletAddress = value;
      isAddressValid = validateAddress(value);
    });
  }

  void transfer() {
    context.read<TransferPoapBloc>().add(
          TransferPoapEvent.transfer(
            input: TransferInput(
              input: TransferArgsInput(
                to: walletAddress.toLowerCase(),
                tokenId: widget.token?.tokenId,
              ),
              network: widget.token?.network ?? '',
              address: widget.token?.contract ?? '',
            ),
          ),
        );
    widget.onClose?.call();
  }

  void onTransferSuccess(Transfer transfer) {
    widget.onClose?.call();
  }

  void onTransferFailed(String? message) {
    showDialog(
      context: context,
      builder: (context) => LemonAlertDialog(
        child: Text(message ?? t.common.somethingWrong),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final verticalOffset = MediaQuery.of(context).viewInsets.bottom * -0.5;
    return BlocListener<TransferPoapBloc, TransferPoapState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          success: onTransferSuccess,
          failure: onTransferFailed,
        );
      },
      child: SingleChildScrollView(
        child: AnimatedContainer(
          padding: EdgeInsets.only(top: 78.w),
          transform: Matrix4.translationValues(
            0.0,
            verticalOffset,
            0.0,
          ),
          duration: const Duration(milliseconds: 100),
          child: Center(
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(LemonRadius.small),
              ),
              backgroundColor: colorScheme.primary,
              insetPadding: EdgeInsets.only(
                left: Spacing.smMedium,
                right: Spacing.smMedium,
              ),
              child: SizedBox(
                height: 0.68.sh,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    LemonRadius.small,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 339.w,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: FutureBuilder(
                                future: MediaUtils.getNftMedia(
                                  widget.token?.metadata?.image,
                                  widget.token?.metadata?.animation_url,
                                ),
                                builder: (context, snapshot) =>
                                    CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: snapshot.data?.url ?? '',
                                  placeholder: (_, __) =>
                                      ImagePlaceholder.defaultPlaceholder(
                                    radius: BorderRadius.only(
                                      topLeft:
                                          Radius.circular(LemonRadius.small),
                                      topRight:
                                          Radius.circular(LemonRadius.small),
                                    ),
                                  ),
                                  errorWidget: (_, __, ___) =>
                                      ImagePlaceholder.defaultPlaceholder(
                                    radius: BorderRadius.only(
                                      topLeft:
                                          Radius.circular(LemonRadius.small),
                                      topRight:
                                          Radius.circular(LemonRadius.small),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: InkWell(
                                onTap: () => widget.onBack?.call(),
                                child: Container(
                                  width: 42.w,
                                  height: 42.w,
                                  margin: EdgeInsets.all(Spacing.xSmall),
                                  decoration: BoxDecoration(
                                    color:
                                        colorScheme.primary.withOpacity(0.36),
                                    borderRadius: BorderRadius.circular(42.w),
                                  ),
                                  child: Center(
                                    child: ThemeSvgIcon(
                                      color: colorScheme.onSecondary,
                                      builder: (filter) => Assets.icons.icBack
                                          .svg(colorFilter: filter),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: LemonColor.dialogBackground,
                          padding: EdgeInsets.all(Spacing.medium),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                t.nft.transferCollectibleTo,
                                style: Typo.extraMedium.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: FontFamily.generalSans,
                                ),
                              ),
                              SizedBox(height: Spacing.xSmall),
                              LemonTextField(
                                hintText: t.nft.enterWalletId,
                                onChange: onChange,
                              ),
                              SizedBox(height: Spacing.medium),
                              BlocBuilder<TransferPoapBloc, TransferPoapState>(
                                builder: (context, state) {
                                  final isProcessing = state.maybeWhen(
                                    loading: () => true,
                                    orElse: () => false,
                                  );
                                  return SizedBox(
                                    height: 42.w,
                                    child: Opacity(
                                      opacity: isAddressValid && !isProcessing
                                          ? 1
                                          : 0.5,
                                      child: LinearGradientButton(
                                        label: isProcessing
                                            ? '${t.common.processing}...'
                                            : t.nft.transferCollectible,
                                        mode: GradientButtonMode.lavenderMode,
                                        onTap: isAddressValid || isProcessing
                                            ? transfer
                                            : null,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
