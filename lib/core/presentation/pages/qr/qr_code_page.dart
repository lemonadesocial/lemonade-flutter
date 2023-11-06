import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/lemon_back_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/modal_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:app/core/config.dart';

@RoutePage()
class QrCodePage extends StatelessWidget {
  const QrCodePage({super.key});

  void shareProfile(
    context, {
    required username,
  }) async {
    try {
      final box = context.findRenderObject() as RenderBox?;
      Vibrate.feedback(FeedbackType.light);
      await Share.share(
        '${AppConfig.webUrl}/$username',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    } catch (e) {
      if (kDebugMode) {
        print("Error _shareProfileLink $e");
      }
    }
  }

  Future<void> copyProfileLink({
    required username,
  }) async {
    try {
      Vibrate.feedback(FeedbackType.light);
      await Clipboard.setData(
        ClipboardData(
          text: '${AppConfig.webUrl}/$username',
        ),
      );
      SnackBarUtils.showSnackbar(t.common.profileUrlCopied);
    } catch (e) {
      if (kDebugMode) {
        print("Error copy profile link $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = AuthUtils.getUserId(context);
    final username = context.read<AuthBloc>().state.maybeWhen(
          orElse: () => '',
          authenticated: (session) => session.username,
        );
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: LemonAppBar(
        title: t.common.qrCode,
        leading: LemonBackButton(color: colorScheme.onPrimary),
        actions: [
          InkWell(
            onTap: () => showComingSoonDialog(context),
            child: ThemeSvgIcon(
              color: colorScheme.onPrimary,
              builder: (filter) =>
                  Assets.icons.icScanLine.svg(colorFilter: filter),
            ),
          ),
          SizedBox(width: Spacing.smMedium),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(LemonRadius.normal),
              child: SizedBox(
                width: 300.w,
                height: 300.w,
                child: QrImageView(
                  embeddedImage: Assets.images.lemonCircleLogo.provider(),
                  embeddedImageStyle: QrEmbeddedImageStyle(
                    size: Size(90.w, 90.w),
                  ),
                  errorCorrectionLevel: QrErrorCorrectLevel.H,
                  backgroundColor: LemonColor.atomicBlack,
                  foregroundColor: colorScheme.onPrimary,
                  padding: EdgeInsets.all(Spacing.xSmall * 2),
                  data: userId,
                ),
              ),
            ),
            SizedBox(height: Spacing.smMedium),
            SizedBox(
              width: 300.w,
              height: 84.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => shareProfile(context, username: username),
                      child: Container(
                        decoration: BoxDecoration(
                          color: LemonColor.atomicBlack,
                          borderRadius:
                              BorderRadius.circular(LemonRadius.normal),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Assets.icons.icShare.svg(
                              width: Sizing.small,
                              height: Sizing.small,
                            ),
                            SizedBox(height: Spacing.superExtraSmall),
                            Text(
                              t.common.actions.shareProfile,
                              style: Typo.mediumPlus
                                  .copyWith(color: colorScheme.onSecondary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Spacing.extraSmall),
                  Expanded(
                    child: InkWell(
                      onTap: () => copyProfileLink(username: username),
                      child: Container(
                        decoration: BoxDecoration(
                          color: LemonColor.atomicBlack,
                          borderRadius:
                              BorderRadius.circular(LemonRadius.normal),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Assets.icons.icLink.svg(
                              width: Sizing.small,
                              height: Sizing.small,
                            ),
                            SizedBox(height: Spacing.superExtraSmall),
                            Text(
                              t.common.actions.copyLink,
                              style: Typo.mediumPlus
                                  .copyWith(color: colorScheme.onSecondary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
